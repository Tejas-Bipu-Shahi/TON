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

@WebServlet("/auth/login")
public class LoginServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        User user = userDAO.getUserByEmail(email);

        if (user != null && BCrypt.checkpw(password, user.getPasswordHash())) {
            if (user.getAccountStatus() == AccountStatus.PENDING) {
                request.getSession().setAttribute("verificationEmail", email);
                response.sendRedirect(request.getContextPath() + "/auth/verify");
                return;
            } else if (user.getAccountStatus() != AccountStatus.ACTIVE) {
                request.setAttribute("error", "Your account is " + user.getAccountStatus().name().toLowerCase() + ".");
                request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
                return;
            }

            // Successful login — route by role
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            String redirect = user.getRole() == Role.ADMIN ? "/admin/dashboard" : "/member/dashboard";
            response.sendRedirect(request.getContextPath() + redirect);

        } else {
            request.setAttribute("error", "Invalid email or password.");
            request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
        }
    }
}
