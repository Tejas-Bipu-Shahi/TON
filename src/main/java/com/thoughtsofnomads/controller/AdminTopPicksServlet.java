package com.thoughtsofnomads.controller;

import com.thoughtsofnomads.dao.ArticleDAO;
import com.thoughtsofnomads.model.Article;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@WebServlet("/admin/top-picks")
public class AdminTopPicksServlet extends HttpServlet {

    private final ArticleDAO articleDAO = new ArticleDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Article> topPicks     = articleDAO.getTopPicks();
        List<Article> allPublished = articleDAO.getPublishedArticles(1, 50);

        Set<Integer> topPickIds = new HashSet<>();
        for (Article a : topPicks) topPickIds.add(a.getArticleId());

        request.setAttribute("topPicks",     topPicks);
        request.setAttribute("allPublished", allPublished);
        request.setAttribute("topPickCount", topPicks.size());
        request.setAttribute("topPickIds",   topPickIds);
        request.getRequestDispatcher("/WEB-INF/views/admin/top-picks.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String idStr  = request.getParameter("articleId");
        String cp     = request.getContextPath();

        if (idStr == null || action == null) {
            response.sendRedirect(cp + "/admin/top-picks");
            return;
        }

        int articleId;
        try { articleId = Integer.parseInt(idStr); }
        catch (NumberFormatException e) {
            response.sendRedirect(cp + "/admin/top-picks");
            return;
        }

        // max 3 top picks — the homepage layout only has 3 slots
        if ("add".equals(action)) {
            if (articleDAO.countTopPicks() >= 3) {
                request.getSession().setAttribute("flashError",
                        "Top Picks are full (max 3). Remove one first.");
            } else {
                boolean ok = articleDAO.addTopPick(articleId);
                request.getSession().setAttribute(ok ? "flashSuccess" : "flashError",
                        ok ? "Article added to Top Picks."
                           : "Article is already a Top Pick.");
            }
        } else if ("remove".equals(action)) {
            articleDAO.removeTopPick(articleId);
            request.getSession().setAttribute("flashSuccess", "Article removed from Top Picks.");
        }

        response.sendRedirect(cp + "/admin/top-picks");
    }
}
