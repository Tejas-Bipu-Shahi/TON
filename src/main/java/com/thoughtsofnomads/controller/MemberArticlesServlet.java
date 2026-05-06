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

@WebServlet("/member/articles")
public class MemberArticlesServlet extends HttpServlet {

    private final ArticleDAO articleDAO = new ArticleDAO();
    private final UserDAO    userDAO    = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User user = (User) request.getSession(false).getAttribute("user");
        User fullUser = userDAO.getUserById(user.getUserId());
        if (fullUser != null) {
            request.setAttribute("userProfile", fullUser.getProfile());
        }

        List<Article> articles = articleDAO.getArticlesByAuthor(user.getUserId());
        request.setAttribute("articles", articles);
        request.getRequestDispatcher("/WEB-INF/views/member/articles.jsp")
               .forward(request, response);
    }
}
