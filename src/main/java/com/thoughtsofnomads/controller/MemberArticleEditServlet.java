package com.thoughtsofnomads.controller;

import com.thoughtsofnomads.dao.ArticleDAO;
import com.thoughtsofnomads.dao.CategoryDAO;
import com.thoughtsofnomads.dao.TagDAO;
import com.thoughtsofnomads.dao.UserDAO;
import com.thoughtsofnomads.model.Article;
import com.thoughtsofnomads.model.Category;
import com.thoughtsofnomads.model.Tag;
import com.thoughtsofnomads.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.ArrayList;
import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@WebServlet("/member/articles/edit")
@MultipartConfig(maxFileSize = 5 * 1024 * 1024, maxRequestSize = 10 * 1024 * 1024)
public class MemberArticleEditServlet extends HttpServlet {

    private final ArticleDAO  articleDAO  = new ArticleDAO();
    private final CategoryDAO categoryDAO = new CategoryDAO();
    private final TagDAO      tagDAO      = new TagDAO();
    private final UserDAO     userDAO     = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User user = (User) request.getSession(false).getAttribute("user");
        Article article = resolveArticle(request, response, user);
        if (article == null) return;

        User fullUser = userDAO.getUserById(user.getUserId());
        if (fullUser != null) request.setAttribute("userProfile", fullUser.getProfile());

        List<Integer> savedTagIds = articleDAO.getTagIdsByArticle(article.getArticleId());

        request.setAttribute("article", article);
        request.setAttribute("savedTagIds", savedTagIds);
        loadFormData(request);
        request.getRequestDispatcher("/WEB-INF/views/member/edit.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User user = (User) request.getSession(false).getAttribute("user");
        Article existing = resolveArticle(request, response, user);
        if (existing == null) return;

        String title         = request.getParameter("title");
        String content       = request.getParameter("content");
        String categoryIdStr = request.getParameter("categoryId");
        String tagIdsStr     = request.getParameter("tagIds");
        String action        = request.getParameter("action"); // "draft" or "submit"

        if (isBlank(title) || isBlank(content) || isBlank(categoryIdStr)) {
            request.setAttribute("article", existing);
            request.setAttribute("savedTagIds", articleDAO.getTagIdsByArticle(existing.getArticleId()));
            request.setAttribute("errorMsg", "Title, content, and category are required.");
            request.setAttribute("formTitle", title);
            request.setAttribute("formContent", content);
            request.setAttribute("formCategoryId", categoryIdStr);
            loadFormData(request);
            request.getRequestDispatcher("/WEB-INF/views/member/edit.jsp").forward(request, response);
            return;
        }

        // Optional new cover image
        String newCoverPath = null;
        try {
            Part coverPart = request.getPart("coverImage");
            if (coverPart != null && coverPart.getSize() > 0) {
                String uploadsDir = getServletContext().getRealPath("") + File.separator + "uploads" + File.separator + "covers";
                Files.createDirectories(Paths.get(uploadsDir));
                String originalName = coverPart.getSubmittedFileName();
                String ext = (originalName != null && originalName.contains("."))
                        ? originalName.substring(originalName.lastIndexOf('.')) : ".jpg";
                String filename = UUID.randomUUID().toString() + ext;
                try (InputStream in = coverPart.getInputStream()) {
                    Files.copy(in, Paths.get(uploadsDir, filename), StandardCopyOption.REPLACE_EXISTING);
                }
                newCoverPath = "uploads/covers/" + filename;
            }
        } catch (Exception ignored) {}

        List<Integer> tagIds = new ArrayList<>();
        if (!isBlank(tagIdsStr)) {
            for (String s : tagIdsStr.split(",")) {
                s = s.trim();
                if (!s.isEmpty()) {
                    try { tagIds.add(Integer.parseInt(s)); } catch (NumberFormatException ignored) {}
                }
            }
        }

        Article updated = new Article();
        updated.setArticleId(existing.getArticleId());
        updated.setAuthorId(user.getUserId());
        updated.setCategoryId(Integer.parseInt(categoryIdStr.trim()));
        updated.setTitle(title.trim());
        updated.setContent(content);
        updated.setStatus("submit".equals(action) ? "PENDING" : "DRAFT");
        updated.setCoverImage(newCoverPath); // null means no new file uploaded — DAO uses COALESCE to keep old one

        boolean ok = articleDAO.updateArticle(updated, tagIds);
        if (ok) {
            String msg = "submit".equals(action)
                    ? "Article resubmitted for review."
                    : "Draft saved successfully.";
            request.getSession().setAttribute("flashSuccess", msg);
            response.sendRedirect(request.getContextPath() + "/member/articles");
        } else {
            request.setAttribute("article", existing);
            request.setAttribute("savedTagIds", tagIds);
            request.setAttribute("errorMsg", "Could not save your article. Please try again.");
            request.setAttribute("formTitle", title);
            request.setAttribute("formContent", content);
            request.setAttribute("formCategoryId", categoryIdStr);
            loadFormData(request);
            request.getRequestDispatcher("/WEB-INF/views/member/edit.jsp").forward(request, response);
        }
    }

    private Article resolveArticle(HttpServletRequest request, HttpServletResponse response, User user)
            throws IOException {
        String idStr = request.getParameter("id");
        if (idStr == null) {
            response.sendRedirect(request.getContextPath() + "/member/articles");
            return null;
        }
        int articleId;
        try { articleId = Integer.parseInt(idStr); }
        catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/member/articles");
            return null;
        }
        Article article = articleDAO.getArticleById(articleId);
        // make sure contributors can only edit their own articles
        if (article == null || article.getAuthorId() != user.getUserId()) {
            response.sendRedirect(request.getContextPath() + "/member/articles");
            return null;
        }
        return article;
    }

    private void loadFormData(HttpServletRequest request) {
        List<Category> raw = categoryDAO.getAllCategories();
        List<Category> roots = new ArrayList<>();
        Map<Integer, List<Category>> childrenMap = new LinkedHashMap<>();
        for (Category c : raw) childrenMap.put(c.getId(), new ArrayList<>());
        for (Category c : raw) {
            if (c.getParentId() == null) roots.add(c);
            else {
                List<Category> siblings = childrenMap.get(c.getParentId());
                if (siblings != null) siblings.add(c);
            }
        }
        List<Category> ordered = new ArrayList<>();
        Map<Integer, Integer> depthMap = new LinkedHashMap<>();
        visit(roots, 0, childrenMap, ordered, depthMap);
        request.setAttribute("categories", ordered);
        request.setAttribute("categoryDepths", depthMap);
        request.setAttribute("tags", tagDAO.getAllTags());
    }

    private void visit(List<Category> cats, int depth,
                       Map<Integer, List<Category>> childrenMap,
                       List<Category> out, Map<Integer, Integer> depthMap) {
        for (Category c : cats) {
            out.add(c);
            depthMap.put(c.getId(), depth);
            visit(childrenMap.getOrDefault(c.getId(), Collections.emptyList()), depth + 1, childrenMap, out, depthMap);
        }
    }

    private boolean isBlank(String s) { return s == null || s.isBlank(); }
}
