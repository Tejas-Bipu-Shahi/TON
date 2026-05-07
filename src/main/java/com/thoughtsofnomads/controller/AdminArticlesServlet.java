package com.thoughtsofnomads.controller;

import com.thoughtsofnomads.config.EmailService;
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

@WebServlet(urlPatterns = {"/admin/articles", "/admin/articles/review"})
public class AdminArticlesServlet extends HttpServlet {

    private final ArticleDAO articleDAO = new ArticleDAO();
    private final UserDAO    userDAO    = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();

        if (path.endsWith("/review")) {
            String idStr = request.getParameter("id");
            if (idStr == null) {
                response.sendRedirect(request.getContextPath() + "/admin/articles");
                return;
            }
            try {
                int id = Integer.parseInt(idStr);
                Article article = articleDAO.getArticleById(id);
                if (article == null) {
                    response.sendRedirect(request.getContextPath() + "/admin/articles");
                    return;
                }
                request.setAttribute("article", article);
                request.getRequestDispatcher("/WEB-INF/views/admin/article-review.jsp")
                       .forward(request, response);
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/admin/articles");
            }
            return;
        }

        // Article list
        String statusFilter = request.getParameter("status");
        if (statusFilter == null || statusFilter.isBlank()) statusFilter = "PENDING";
        List<Article> articles = articleDAO.getAllForAdmin(statusFilter);
        request.setAttribute("articles", articles);
        request.setAttribute("statusFilter", statusFilter);

        // Tab counts
        request.setAttribute("countPending",   articleDAO.getAllForAdmin("PENDING").size());
        request.setAttribute("countPublished", articleDAO.getAllForAdmin("PUBLISHED").size());
        request.setAttribute("countRejected",  articleDAO.getAllForAdmin("REJECTED").size());
        request.setAttribute("countDraft",     articleDAO.getAllForAdmin("DRAFT").size());

        request.getRequestDispatcher("/WEB-INF/views/admin/articles.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idStr     = request.getParameter("articleId");
        String action    = request.getParameter("action");    // "publish" or "reject"
        String note      = request.getParameter("reviewNote");

        if (idStr == null || action == null) {
            response.sendRedirect(request.getContextPath() + "/admin/articles");
            return;
        }

        int articleId;
        try { articleId = Integer.parseInt(idStr); }
        catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/articles");
            return;
        }

        String newStatus = "publish".equals(action) ? "PUBLISHED" : "REJECTED";
        String reviewNote = (note != null && !note.isBlank()) ? note.trim() : null;

        if ("REJECTED".equals(newStatus) && reviewNote == null) {
            // Reject requires a note
            Article article = articleDAO.getArticleById(articleId);
            request.setAttribute("article", article);
            request.setAttribute("errorMsg", "Please provide a note explaining why the article is rejected.");
            request.getRequestDispatcher("/WEB-INF/views/admin/article-review.jsp")
                   .forward(request, response);
            return;
        }

        articleDAO.updateStatus(articleId, newStatus, reviewNote);

        // Send email notification to the author
        Article article = articleDAO.getArticleById(articleId);
        if (article != null) {
            User author = userDAO.getUserById(article.getAuthorId());
            if (author != null) {
                String displayName = article.getAuthorName() != null ? article.getAuthorName() : author.getEmail();
                if ("PUBLISHED".equals(newStatus)) {
                    EmailService.sendArticlePublished(author.getEmail(), displayName, article.getTitle());
                } else {
                    EmailService.sendArticleRejected(author.getEmail(), displayName, article.getTitle(), reviewNote);
                }
            }
        }

        String flash = "publish".equals(action)
                ? "Article published successfully."
                : "Article rejected. The contributor has been notified.";
        request.getSession().setAttribute("flashSuccess", flash);
        response.sendRedirect(request.getContextPath() + "/admin/articles");
    }
}
