package com.thoughtsofnomads.controller;

import com.thoughtsofnomads.dao.UserDAO;
import com.thoughtsofnomads.model.AccountStatus;
import com.thoughtsofnomads.model.Role;
import com.thoughtsofnomads.model.User;
import org.mindrot.jbcrypt.BCrypt;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Timestamp;
import java.time.Instant;
import java.time.temporal.ChronoUnit;

@WebServlet("/auth/login")
public class LoginServlet extends HttpServlet {

    private static final int MAX_ATTEMPTS    = 5;
    private static final int LOCK_MINUTES    = 10;

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email    = request.getParameter("email");
        String password = request.getParameter("password");

        User user = userDAO.getUserByEmail(email);

        if (user == null) {
            request.setAttribute("error", "Invalid email or password.");
            request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
            return;
        }

        // ── Locked account: check if window has expired ───────────────────────
        if (user.getAccountStatus() == AccountStatus.LOCKED) {
            Timestamp lockedUntil = user.getDisabledAt();
            if (lockedUntil != null && lockedUntil.toInstant().isBefore(Instant.now())) {
                userDAO.resetFailedAttempts(user.getUserId());
                user.setAccountStatus(AccountStatus.ACTIVE);
            } else {
                long minsLeft = lockedUntil != null
                    ? ChronoUnit.MINUTES.between(Instant.now(), lockedUntil.toInstant()) + 1
                    : LOCK_MINUTES;
                request.setAttribute("error",
                    "Your account is temporarily locked due to too many failed attempts. " +
                    "Please try again in " + minsLeft + " minute" + (minsLeft == 1 ? "" : "s") + ".");
                request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
                return;
            }
        }

        // ── Other non-active statuses (DISABLED, DELETED, PENDING) ───────────
        if (user.getAccountStatus() == AccountStatus.PENDING) {
            request.getSession().setAttribute("verificationEmail", email);
            response.sendRedirect(request.getContextPath() + "/auth/verify");
            return;
        }
        if (user.getAccountStatus() != AccountStatus.ACTIVE) {
            request.setAttribute("error", "Your account is " + user.getAccountStatus().name().toLowerCase() + ".");
            request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
            return;
        }

        // ── Password check ────────────────────────────────────────────────────
        if (BCrypt.checkpw(password, user.getPasswordHash())) {
            userDAO.resetFailedAttempts(user.getUserId());
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            String redirect = user.getRole() == Role.ADMIN ? "/admin/dashboard" : "/member/dashboard";
            response.sendRedirect(request.getContextPath() + redirect);
        } else {
            int attempts = userDAO.incrementFailedAttempts(user.getUserId());
            int remaining = MAX_ATTEMPTS - attempts;

            if (attempts >= MAX_ATTEMPTS) {
                userDAO.lockAccountTemporarily(user.getUserId(), LOCK_MINUTES);
                request.setAttribute("error",
                    "Too many failed attempts. Your account has been locked for " +
                    LOCK_MINUTES + " minutes.");
            } else {
                request.setAttribute("error",
                    "Invalid email or password. " + remaining +
                    " attempt" + (remaining == 1 ? "" : "s") + " remaining before lockout.");
            }
            request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
        }
    }
}
