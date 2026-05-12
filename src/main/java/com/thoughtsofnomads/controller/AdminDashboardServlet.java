package com.thoughtsofnomads.controller;

import com.thoughtsofnomads.dao.ArticleDAO;
import com.thoughtsofnomads.dao.CategoryDAO;
import com.thoughtsofnomads.dao.SubscriberDAO;
import com.thoughtsofnomads.dao.UserDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {

    private final ArticleDAO  articleDAO  = new ArticleDAO();
    private final UserDAO     userDAO     = new UserDAO();
    private final CategoryDAO categoryDAO = new CategoryDAO();
    private final SubscriberDAO subscriberDAO = new SubscriberDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // stat card numbers shown at the top of the dashboard
        request.setAttribute("totalArticles",     articleDAO.countAll());
        request.setAttribute("pendingCount",      articleDAO.countByStatus("PENDING"));
        request.setAttribute("newThisMonth",      articleDAO.countThisMonth());
        request.setAttribute("totalContributors", userDAO.countContributors());
        request.setAttribute("newContributors",   userDAO.countNewContributorsThisWeek());
        request.setAttribute("totalCategories",   categoryDAO.countAll());
        request.setAttribute("totalSubscribers",  subscriberDAO.countSubscribers());

        // show 8 rows in each preview table — enough without making the page too long
        request.setAttribute("pendingArticles", articleDAO.getRecentPending(8));
        request.setAttribute("recentUsers",     userDAO.getRecentUsers(8));

        request.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(request, response);
    }
}
