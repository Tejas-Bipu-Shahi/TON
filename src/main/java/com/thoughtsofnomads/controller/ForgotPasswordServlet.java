package com.thoughtsofnomads.controller;

import com.thoughtsofnomads.config.EmailService;
import com.thoughtsofnomads.dao.UserDAO;
import com.thoughtsofnomads.model.User;
import org.mindrot.jbcrypt.BCrypt;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Random;

@WebServlet("/auth/forgot-password")
public class ForgotPasswordServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        String step = resolveStep(session);

        if ("otp".equals(step)) {
            request.getRequestDispatcher("/WEB-INF/views/auth/reset-otp.jsp").forward(request, response);
        } else if ("reset".equals(step)) {
            request.getRequestDispatcher("/WEB-INF/views/auth/reset-password.jsp").forward(request, response);
        } else {
            // clear any stale reset state when user navigates back to step 1
            if (session != null) clearResetState(session);
            request.getRequestDispatcher("/WEB-INF/views/auth/forgot-password.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String step = request.getParameter("step");
        HttpSession session = request.getSession(true);

        switch (step != null ? step : "") {
            case "email"  -> handleEmail(request, response, session);
            case "otp"    -> handleOtp(request, response, session);
            case "reset"  -> handleReset(request, response, session);
            default       -> response.sendRedirect(request.getContextPath() + "/auth/forgot-password");
        }
    }

    // ── Step 1: email submission ──────────────────────────────────────────────

    private void handleEmail(HttpServletRequest request, HttpServletResponse response,
                             HttpSession session) throws ServletException, IOException {
        String email = trim(request.getParameter("email"));

        if (email == null || email.isBlank()) {
            request.setAttribute("error", "Please enter your email address.");
            request.getRequestDispatcher("/WEB-INF/views/auth/forgot-password.jsp").forward(request, response);
            return;
        }

        // same response whether or not account exists — don't leak which emails are registered
        User user = userDAO.getUserByEmail(email);
        if (user != null) {
            String otp     = generateOtp();
            long   expiry  = System.currentTimeMillis() + 10 * 60 * 1000; // 10 min in ms

            session.setAttribute("resetEmail",  email);
            session.setAttribute("resetOtp",    otp);
            session.setAttribute("resetExpiry", expiry);
            session.removeAttribute("resetVerified");

            try {
                EmailService.sendPasswordResetOtp(email, otp);
            } catch (Exception ignored) {
                // log silently; OTP is in session so the user can still proceed in dev
            }
        }

        // Always redirect to OTP step (security: don't leak account existence)
        session.setAttribute("resetEmail", email);
        response.sendRedirect(request.getContextPath() + "/auth/forgot-password?step=otp");
    }

    // ── Step 2: OTP verification ──────────────────────────────────────────────

    private void handleOtp(HttpServletRequest request, HttpServletResponse response,
                           HttpSession session) throws ServletException, IOException {

        String submittedOtp = trim(request.getParameter("otp"));
        String storedOtp    = (String)  session.getAttribute("resetOtp");
        Long   expiry       = (Long)    session.getAttribute("resetExpiry");

        if (storedOtp == null || expiry == null) {
            request.setAttribute("error", "Session expired. Please start over.");
            request.getRequestDispatcher("/WEB-INF/views/auth/reset-otp.jsp").forward(request, response);
            return;
        }

        if (System.currentTimeMillis() > expiry) {
            clearResetState(session);
            request.setAttribute("error", "Your code has expired. Please request a new one.");
            request.getRequestDispatcher("/WEB-INF/views/auth/reset-otp.jsp").forward(request, response);
            return;
        }

        if (!storedOtp.equals(submittedOtp)) {
            request.setAttribute("error", "Incorrect code. Please try again.");
            request.getRequestDispatcher("/WEB-INF/views/auth/reset-otp.jsp").forward(request, response);
            return;
        }

        session.setAttribute("resetVerified", true);
        session.removeAttribute("resetOtp"); // one-time use — remove after correct entry
        response.sendRedirect(request.getContextPath() + "/auth/forgot-password?step=reset");
    }

    // ── Step 3: new password ──────────────────────────────────────────────────

    private void handleReset(HttpServletRequest request, HttpServletResponse response,
                             HttpSession session) throws ServletException, IOException {

        Boolean verified = (Boolean) session.getAttribute("resetVerified");
        String  email    = (String)  session.getAttribute("resetEmail");

        if (!Boolean.TRUE.equals(verified) || email == null) {
            response.sendRedirect(request.getContextPath() + "/auth/forgot-password");
            return;
        }

        String newPassword     = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        if (blank(newPassword) || blank(confirmPassword)) {
            request.setAttribute("error", "Both password fields are required.");
            request.getRequestDispatcher("/WEB-INF/views/auth/reset-password.jsp").forward(request, response);
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match.");
            request.getRequestDispatcher("/WEB-INF/views/auth/reset-password.jsp").forward(request, response);
            return;
        }

        if (newPassword.length() < 8) {
            request.setAttribute("error", "Password must be at least 8 characters.");
            request.getRequestDispatcher("/WEB-INF/views/auth/reset-password.jsp").forward(request, response);
            return;
        }

        String hash = BCrypt.hashpw(newPassword, BCrypt.gensalt());
        boolean ok  = userDAO.updatePassword(email, hash);

        clearResetState(session);

        if (ok) {
            session.setAttribute("flashSuccess", "Password updated. Please sign in with your new password.");
        } else {
            session.setAttribute("flashError", "Could not update your password. Please try again.");
        }

        response.sendRedirect(request.getContextPath() + "/auth/login");
    }

    // ── Helpers ───────────────────────────────────────────────────────────────

    // determines which step to show on GET requests based on session state
    private String resolveStep(HttpSession session) {
        if (session == null) return "email";
        if (Boolean.TRUE.equals(session.getAttribute("resetVerified"))) return "reset";
        if (session.getAttribute("resetOtp") != null)                   return "otp";
        if (session.getAttribute("resetEmail") != null)                 return "otp";
        return "email";
    }

    private String generateOtp() {
        return String.format("%06d", new Random().nextInt(1_000_000));
    }

    private void clearResetState(HttpSession session) {
        session.removeAttribute("resetEmail");
        session.removeAttribute("resetOtp");
        session.removeAttribute("resetExpiry");
        session.removeAttribute("resetVerified");
    }

    private String trim(String s)  { return (s != null) ? s.trim() : null; }
    private boolean blank(String s) { return s == null || s.isBlank(); }
}
