package com.thoughtsofnomads.controller;

import com.thoughtsofnomads.dao.SubscriberDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/subscribe")
public class SubscribeServlet extends HttpServlet {

    private final SubscriberDAO subscriberDAO = new SubscriberDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json;charset=UTF-8");

        String email = request.getParameter("email");
        if (email == null || !email.matches("^[^@\\s]+@[^@\\s]+\\.[^@\\s]+$")) {
            response.getWriter().write("{\"error\":\"Please enter a valid email address.\"}");
            return;
        }

        boolean alreadySubscribed = subscriberDAO.isSubscribed(email.trim());
        if (alreadySubscribed) {
            response.getWriter().write("{\"error\":\"You're already on the list!\"}");
            return;
        }

        boolean ok = subscriberDAO.addSubscriber(email.trim());
        if (ok) {
            response.getWriter().write("{\"success\":true}");
        } else {
            response.getWriter().write("{\"error\":\"Something went wrong. Please try again.\"}");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/");
    }
}
