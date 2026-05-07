package com.thoughtsofnomads.controller;

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

@WebServlet("/member/profile")
public class MemberProfileServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User sessionUser = (User) request.getSession(false).getAttribute("user");
        User fullUser = userDAO.getUserById(sessionUser.getUserId());
        if (fullUser != null) {
            request.setAttribute("userProfile", fullUser.getProfile());
        }
        request.getRequestDispatcher("/WEB-INF/views/member/profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User sessionUser = (User) session.getAttribute("user");
        String section = request.getParameter("section");

        if ("profile".equals(section)) {
            handleProfileUpdate(request, response, session, sessionUser);
        } else if ("password".equals(section)) {
            handlePasswordChange(request, response, session, sessionUser);
        } else {
            response.sendRedirect(request.getContextPath() + "/member/profile");
        }
    }

    private void handleProfileUpdate(HttpServletRequest request, HttpServletResponse response,
                                     HttpSession session, User sessionUser) throws IOException {
        String fullName       = trim(request.getParameter("fullName"));
        String contactNumber  = trim(request.getParameter("contactNumber"));
        String bio            = trim(request.getParameter("bio"));
        String profilePicture = trim(request.getParameter("profilePicture"));

        if (fullName == null || fullName.isBlank()) {
            session.setAttribute("flashError", "Full name is required.");
            response.sendRedirect(request.getContextPath() + "/member/profile");
            return;
        }

        // Update text fields and picture independently — picture must not be gated on whether
        // text fields changed (MySQL returns 0 affected rows when values are identical).
        boolean ok = userDAO.updateProfile(sessionUser.getUserId(), fullName, contactNumber, bio);

        if (profilePicture != null && !profilePicture.isBlank()) {
            // ImageUploadServlet returns a URL with the context path prefix; strip it so the
            // stored value is "uploads/content/uuid.jpg" — consistent with article covers.
            String ctx = request.getContextPath();
            if (profilePicture.startsWith(ctx + "/")) {
                profilePicture = profilePicture.substring(ctx.length() + 1);
            } else if (profilePicture.startsWith("/")) {
                profilePicture = profilePicture.substring(1);
            }
            userDAO.updateProfilePicture(sessionUser.getUserId(), profilePicture);
        }

        if (ok) {
            User refreshed = userDAO.getUserByEmail(sessionUser.getEmail());
            if (refreshed != null) session.setAttribute("user", refreshed);
            session.setAttribute("flashSuccess", "Profile updated successfully.");
        } else {
            session.setAttribute("flashError", "Could not update profile. Please try again.");
        }

        response.sendRedirect(request.getContextPath() + "/member/profile");
    }

    private void handlePasswordChange(HttpServletRequest request, HttpServletResponse response,
                                      HttpSession session, User sessionUser) throws IOException {
        String currentPassword  = request.getParameter("currentPassword");
        String newPassword      = request.getParameter("newPassword");
        String confirmPassword  = request.getParameter("confirmPassword");

        if (blank(currentPassword) || blank(newPassword) || blank(confirmPassword)) {
            session.setAttribute("flashError", "All password fields are required.");
            response.sendRedirect(request.getContextPath() + "/member/profile");
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            session.setAttribute("flashError", "New passwords do not match.");
            response.sendRedirect(request.getContextPath() + "/member/profile");
            return;
        }

        if (newPassword.length() < 8) {
            session.setAttribute("flashError", "New password must be at least 8 characters.");
            response.sendRedirect(request.getContextPath() + "/member/profile");
            return;
        }

        if (!BCrypt.checkpw(currentPassword, sessionUser.getPasswordHash())) {
            session.setAttribute("flashError", "Current password is incorrect.");
            response.sendRedirect(request.getContextPath() + "/member/profile");
            return;
        }

        String newHash = BCrypt.hashpw(newPassword, BCrypt.gensalt());
        boolean ok = userDAO.updatePassword(sessionUser.getEmail(), newHash);

        if (ok) {
            User refreshed = userDAO.getUserByEmail(sessionUser.getEmail());
            if (refreshed != null) session.setAttribute("user", refreshed);
            session.setAttribute("flashSuccess", "Password changed successfully.");
        } else {
            session.setAttribute("flashError", "Could not update password. Please try again.");
        }

        response.sendRedirect(request.getContextPath() + "/member/profile");
    }

    private String trim(String s) { return (s != null) ? s.trim() : null; }
    private boolean blank(String s) { return s == null || s.isBlank(); }
}
