package com.thoughtsofnomads.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet({"/about", "/contact", "/latest", "/category", "/article", "/search"})
public class PageController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();
        String viewName = path.substring(1); // Remove leading slash
        
        if ("search".equals(viewName)) {
            String query = request.getParameter("q");
            request.setAttribute("query", query != null ? query : "");
        }
        
        // Map to corresponding JSP in /WEB-INF/views/public/
        request.getRequestDispatcher("/WEB-INF/views/public/" + viewName + ".jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();
        
        if ("/contact".equals(path)) {
            // Mock email sending success
            request.setAttribute("success", "Thank you for reaching out! We've received your message and will get back to you soon.");
            request.getRequestDispatcher("/WEB-INF/views/public/contact.jsp").forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
        }
    }
}
