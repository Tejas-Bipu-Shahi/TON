package com.thoughtsofnomads.controller;

import com.thoughtsofnomads.config.EmailService;
import com.thoughtsofnomads.dao.ArticleDAO;
import com.thoughtsofnomads.dao.SubscriberDAO;
import com.thoughtsofnomads.model.Article;
import com.thoughtsofnomads.model.Subscriber;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/admin/subscribers")
public class AdminSubscribersServlet extends HttpServlet {

    private final SubscriberDAO subscriberDAO = new SubscriberDAO();
    private final ArticleDAO    articleDAO    = new ArticleDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("subscribers",   subscriberDAO.getAllSubscribers());
        request.setAttribute("subCount",      subscriberDAO.countSubscribers());
        request.setAttribute("allPublished",  articleDAO.getPublishedArticles(1, 100));
        request.getRequestDispatcher("/WEB-INF/views/admin/subscribers.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action   = request.getParameter("action");
        String cp       = request.getContextPath();
        String redirect = request.getParameter("redirect");
        String dest     = (redirect != null && !redirect.isBlank()) ? redirect : cp + "/admin/subscribers";

        if ("delete".equals(action)) {
            String idStr = request.getParameter("id");
            if (idStr != null) {
                try {
                    subscriberDAO.deleteSubscriber(Integer.parseInt(idStr));
                    request.getSession().setAttribute("flashSuccess", "Subscriber removed.");
                } catch (NumberFormatException ignored) {}
            }

        } else if ("send".equals(action)) {
            String idStr = request.getParameter("articleId");
            if (idStr != null) {
                try {
                    int articleId  = Integer.parseInt(idStr);
                    Article article = articleDAO.getPublishedById(articleId);
                    if (article == null) {
                        request.getSession().setAttribute("flashError", "Article not found or not published.");
                    } else {
                        List<Subscriber> subs  = subscriberDAO.getAllSubscribers();
                        List<String>     emails = subs.stream().map(Subscriber::getEmail).collect(Collectors.toList());
                        String articleUrl = request.getScheme() + "://" + request.getServerName()
                                + ":" + request.getServerPort() + cp + "/article?id=" + articleId;
                        int sent = EmailService.sendNewsletterToAll(
                                emails, article.getTitle(), articleUrl,
                                article.getAuthorName(), article.getCategoryName());
                        request.getSession().setAttribute("flashSuccess",
                                "Newsletter sent to " + sent + " subscriber" + (sent == 1 ? "" : "s") + ".");
                    }
                } catch (NumberFormatException ignored) {}
            }
        }

        response.sendRedirect(dest);
    }
}
