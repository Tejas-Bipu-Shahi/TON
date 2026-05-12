package com.thoughtsofnomads.controller;

import com.thoughtsofnomads.config.EmailService;
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
import java.util.Random;

@WebServlet("/auth/register")
public class RegisterServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // Validate inputs
        if (fullName == null || fullName.trim().isEmpty() || !fullName.matches("^[a-zA-Z\\s]+$")) {
            request.setAttribute("error", "Please enter a valid name. Numbers and special characters are not permitted.");
            request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
            return;
        }

        if (email == null || email.trim().isEmpty() || !email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
            request.setAttribute("error", "Please enter a valid email address.");
            request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
            return;
        }

        if (password == null || password.length() < 8) {
            request.setAttribute("error", "Password must be at least 8 characters long.");
            request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
            return;
        }

        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match.");
            request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
            return;
        }

        try {
            String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
            // 6-digit OTP, zero-padded so "000123" stays as a string not an int
            String otp = String.format("%06d", new Random().nextInt(999999));
            User newUser = new User(email, hashedPassword, Role.CONTRIBUTOR, AccountStatus.PENDING);

            boolean isRegistrationSuccess = false;

            // allow re-registration if the previous attempt was never verified
            User existingUser = userDAO.getUserByEmail(email);
            if (existingUser != null) {
                if (existingUser.getAccountStatus() == AccountStatus.PENDING) {
                    isRegistrationSuccess = userDAO.overrideUnverifiedUser(newUser, fullName, phone);
                } else {
                    request.setAttribute("error", "Email is already registered. Please sign in instead.");
                    request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
                    return;
                }
            } else {
                isRegistrationSuccess = userDAO.registerUser(newUser, fullName, phone);
            }

            if (isRegistrationSuccess) {
                EmailService.sendOTP(email, otp);

                // store OTP in session — it gets consumed and removed after successful verify
                HttpSession session = request.getSession();
                session.setAttribute("verificationEmail", email);
                session.setAttribute("verificationOTP", otp);
                
                response.sendRedirect(request.getContextPath() + "/auth/verify");
            } else {
                request.setAttribute("error", "Registration failed. Please try again.");
                request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An unexpected error occurred during registration. Please try again later.");
            request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
        }
    }
}
