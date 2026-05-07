package com.thoughtsofnomads.controller;

import com.thoughtsofnomads.dao.ArticleDAO;
import com.thoughtsofnomads.dao.CategoryDAO;
import com.thoughtsofnomads.dao.TagDAO;
import com.thoughtsofnomads.model.Article;
import com.thoughtsofnomads.model.Category;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet({"/about", "/contact", "/latest", "/categories", "/category", "/article", "/search"})
public class PageController extends HttpServlet {

    private static final int PAGE_SIZE = 8;

    private final ArticleDAO  articleDAO  = new ArticleDAO();
    private final CategoryDAO categoryDAO = new CategoryDAO();
    private final TagDAO      tagDAO      = new TagDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();

        switch (path) {
            case "/latest"     -> handleLatest(request, response);
            case "/categories" -> handleCategories(request, response);
            case "/category"   -> handleCategory(request, response);
            case "/article"    -> handleArticle(request, response);
            case "/search"     -> handleSearch(request, response);
            default            -> request.getRequestDispatcher(
                                      "/WEB-INF/views/public/" + path.substring(1) + ".jsp")
                                      .forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if ("/contact".equals(request.getServletPath())) {
            request.setAttribute("success", "Thank you for reaching out! We'll get back to you soon.");
            request.getRequestDispatcher("/WEB-INF/views/public/contact.jsp").forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
        }
    }

    // ── /categories ──────────────────────────────────────────────────────────

    private void handleCategories(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("categories", categoryDAO.getAllWithArticleCounts());
        request.getRequestDispatcher("/WEB-INF/views/public/categories.jsp").forward(request, response);
    }

    // ── /latest ──────────────────────────────────────────────────────────────

    private void handleLatest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int page = parsePage(request.getParameter("page"));
        int total = articleDAO.countPublished();
        int totalPages = (int) Math.ceil((double) total / PAGE_SIZE);

        List<Article> articles = articleDAO.getPublishedArticles(page, PAGE_SIZE);
        List<Category> categories = categoryDAO.getAllCategories();

        request.setAttribute("articles",    articles);
        request.setAttribute("categories",  categories);
        request.setAttribute("tags",        tagDAO.getAllTags());
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages",  Math.max(1, totalPages));
        request.setAttribute("total",       total);
        request.getRequestDispatcher("/WEB-INF/views/public/latest.jsp").forward(request, response);
    }

    // ── /article ─────────────────────────────────────────────────────────────

    private void handleArticle(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idStr = request.getParameter("id");
        if (idStr == null) { response.sendRedirect(request.getContextPath() + "/latest"); return; }
        int id;
        try { id = Integer.parseInt(idStr); }
        catch (NumberFormatException e) { response.sendRedirect(request.getContextPath() + "/latest"); return; }

        Article article = articleDAO.getPublishedById(id);
        if (article == null) { response.sendError(HttpServletResponse.SC_NOT_FOUND); return; }

        List<Article> related = articleDAO.getRelatedPublished(id, article.getCategoryId(), 3);

        request.setAttribute("article", article);
        request.setAttribute("related", related);
        request.getRequestDispatcher("/WEB-INF/views/public/article.jsp").forward(request, response);
    }

    // ── /category ────────────────────────────────────────────────────────────

    private void handleCategory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idStr = request.getParameter("id");
        if (idStr == null) { response.sendRedirect(request.getContextPath() + "/latest"); return; }
        int catId;
        try { catId = Integer.parseInt(idStr); }
        catch (NumberFormatException e) { response.sendRedirect(request.getContextPath() + "/latest"); return; }

        Category category = categoryDAO.getCategoryById(catId);
        if (category == null) { response.sendRedirect(request.getContextPath() + "/latest"); return; }

        List<Article>  articles       = articleDAO.getPublishedByCategory(catId);
        List<Category> subcategories  = categoryDAO.getSubcategories(catId);
        List<Category> allCategories  = categoryDAO.getAllCategories();

        // for parent breadcrumb link when this is a subcategory
        Category parentCategory = (category.getParentId() != null)
                ? categoryDAO.getCategoryById(category.getParentId()) : null;

        request.setAttribute("category",       category);
        request.setAttribute("articles",       articles);
        request.setAttribute("subcategories",  subcategories);
        request.setAttribute("allCategories",  allCategories);
        request.setAttribute("parentCategory", parentCategory);
        request.getRequestDispatcher("/WEB-INF/views/public/category.jsp").forward(request, response);
    }

    // ── /search ──────────────────────────────────────────────────────────────

    private void handleSearch(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String query = request.getParameter("q");
        if (query == null) query = "";
        query = query.trim();

        List<Article> results = query.isEmpty() ? List.of() : articleDAO.searchPublished(query);

        request.setAttribute("query",   query);
        request.setAttribute("results", results);
        request.getRequestDispatcher("/WEB-INF/views/public/search.jsp").forward(request, response);
    }

    // ── Helpers ───────────────────────────────────────────────────────────────

    private int parsePage(String param) {
        if (param == null) return 1;
        try { return Math.max(1, Integer.parseInt(param)); }
        catch (NumberFormatException e) { return 1; }
    }
}
