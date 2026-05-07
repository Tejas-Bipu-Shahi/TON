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
import java.util.stream.Collectors;

@WebServlet({"", "/home"})
public class HomeServlet extends HttpServlet {

    private final ArticleDAO articleDAO = new ArticleDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Article> topPicks = articleDAO.getTopPicks();

        Set<Integer> topPickIds = new HashSet<>();
        for (Article a : topPicks) topPickIds.add(a.getArticleId());

        // Fetch extra to filter out top picks from latest
        List<Article> candidates = articleDAO.getPublishedArticles(1, 12);
        List<Article> latestArticles = candidates.stream()
                .filter(a -> !topPickIds.contains(a.getArticleId()))
                .limit(6)
                .collect(Collectors.toList());

        request.setAttribute("topPicks", topPicks);
        request.setAttribute("latestArticles", latestArticles);
        request.getRequestDispatcher("/WEB-INF/views/public/home.jsp")
               .forward(request, response);
    }
}
