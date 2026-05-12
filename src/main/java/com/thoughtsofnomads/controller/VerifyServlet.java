package com.thoughtsofnomads.controller;

import com.thoughtsofnomads.dao.UserDAO;
import com.thoughtsofnomads.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/auth/verify")
public class VerifyServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("verificationEmail") == null) {
            response.sendRedirect(request.getContextPath() + "/auth/register");
            return;
        }
        request.getRequestDispatcher("/WEB-INF/views/auth/verify-otp.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("verificationEmail");
        String sessionOtp = (String) session.getAttribute("verificationOTP");
        String otp = request.getParameter("otp");

        if (email == null || sessionOtp == null) {
            response.sendRedirect(request.getContextPath() + "/auth/register");
            return;
        }

        User user = userDAO.getUserByEmail(email);
        if (user != null && otp != null && otp.equals(sessionOtp)) {
            userDAO.activateUser(email);

            // clean up so the verify page can't be revisited
            session.removeAttribute("verificationEmail");
            session.removeAttribute("verificationOTP");

            session.setAttribute("user", user);
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        } else {
            request.setAttribute("error", "Invalid verification code.");
            request.getRequestDispatcher("/WEB-INF/views/auth/verify-otp.jsp").forward(request, response);
        }
    }
}
