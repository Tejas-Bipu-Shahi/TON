package com.thoughtsofnomads.controller;

import com.thoughtsofnomads.dao.ArticleDAO;
import com.thoughtsofnomads.dao.UserDAO;
import com.thoughtsofnomads.model.Article;
import com.thoughtsofnomads.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/member/dashboard")
public class MemberDashboardServlet extends HttpServlet {

    private final UserDAO    userDAO    = new UserDAO();
    private final ArticleDAO articleDAO = new ArticleDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User user = (User) request.getSession(false).getAttribute("user");

        // session only has basic user data — need a DB call to get the full profile with picture
        User fullUser = userDAO.getUserById(user.getUserId());
        if (fullUser != null) {
            request.setAttribute("userProfile", fullUser.getProfile());
        }

        // single aggregated query instead of 5 separate COUNT queries
        int[] stats = articleDAO.getStatsByAuthor(user.getUserId());
        request.setAttribute("statTotal",     stats[0]);
        request.setAttribute("statPublished", stats[1]);
        request.setAttribute("statPending",   stats[2]);
        request.setAttribute("statDraft",     stats[3]);
        request.setAttribute("statRejected",  stats[4]);

        // Recent articles
        List<Article> recent = articleDAO.getRecentByAuthor(user.getUserId(), 6);
        request.setAttribute("recentArticles", recent);

        request.getRequestDispatcher("/WEB-INF/views/member/dashboard.jsp")
               .forward(request, response);
    }
}
