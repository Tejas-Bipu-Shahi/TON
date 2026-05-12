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

@WebServlet("/member/articles/new")
@MultipartConfig(maxFileSize = 5 * 1024 * 1024, maxRequestSize = 10 * 1024 * 1024)
public class MemberArticleServlet extends HttpServlet {

    private final CategoryDAO categoryDAO = new CategoryDAO();
    private final TagDAO      tagDAO      = new TagDAO();
    private final ArticleDAO  articleDAO  = new ArticleDAO();
    private final UserDAO     userDAO     = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = (User) request.getSession(false).getAttribute("user");
        User fullUser = userDAO.getUserById(user.getUserId());
        if (fullUser != null) request.setAttribute("userProfile", fullUser.getProfile());
        loadFormData(request);
        request.getRequestDispatcher("/WEB-INF/views/member/write.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User user = (User) request.getSession(false).getAttribute("user");

        String title         = request.getParameter("title");
        String content       = request.getParameter("content");
        String categoryIdStr = request.getParameter("categoryId");
        String tagIdsStr     = request.getParameter("tagIds");
        String action        = request.getParameter("action"); // "draft" or "submit"

        // Validate required fields
        if (isBlank(title) || isBlank(content) || isBlank(categoryIdStr)) {
            request.setAttribute("errorMsg", "Title, content, and category are required.");
            request.setAttribute("formTitle", title);
            request.setAttribute("formContent", content);
            request.setAttribute("formCategoryId", categoryIdStr);
            request.setAttribute("formTagIds", tagIdsStr);
            loadFormData(request);
            request.getRequestDispatcher("/WEB-INF/views/member/write.jsp").forward(request, response);
            return;
        }

        // Handle cover image upload
        String coverImagePath = null;
        try {
            Part coverPart = request.getPart("coverImage");
            if (coverPart != null && coverPart.getSize() > 0) {
                String uploadsDir = getServletContext().getRealPath("")
                        + File.separator + "uploads" + File.separator + "covers";
                Files.createDirectories(Paths.get(uploadsDir));
                String originalName = coverPart.getSubmittedFileName();
                String ext = (originalName != null && originalName.contains("."))
                        ? originalName.substring(originalName.lastIndexOf('.'))
                        : ".jpg";
                String filename = UUID.randomUUID().toString() + ext;
                try (InputStream in = coverPart.getInputStream()) {
                    Files.copy(in, Paths.get(uploadsDir, filename), StandardCopyOption.REPLACE_EXISTING);
                }
                coverImagePath = "uploads/covers/" + filename;
            }
        } catch (Exception ignored) {}

        // Parse tag IDs
        List<Integer> tagIds = new ArrayList<>();
        if (!isBlank(tagIdsStr)) {
            for (String s : tagIdsStr.split(",")) {
                s = s.trim();
                if (!s.isEmpty()) {
                    try { tagIds.add(Integer.parseInt(s)); } catch (NumberFormatException ignored) {}
                }
            }
        }

        // Build article
        Article article = new Article();
        article.setAuthorId(user.getUserId());
        article.setCategoryId(Integer.parseInt(categoryIdStr.trim()));
        article.setTitle(title.trim());
        article.setContent(content);
        // "Save Draft" keeps it as DRAFT, "Submit" puts it in the review queue
        article.setStatus("submit".equals(action) ? "PENDING" : "DRAFT");
        article.setCoverImage(coverImagePath);

        int newId = articleDAO.createArticle(article, tagIds);
        if (newId > 0) {
            String msg = "submit".equals(action)
                    ? "Article submitted for review. We'll notify you once it's approved."
                    : "Draft saved successfully.";
            request.getSession().setAttribute("flashSuccess", msg);
            response.sendRedirect(request.getContextPath() + "/member/dashboard");
        } else {
            request.setAttribute("errorMsg", "Could not save your article. Please try again.");
            request.setAttribute("formTitle", title);
            request.setAttribute("formContent", content);
            request.setAttribute("formCategoryId", categoryIdStr);
            request.setAttribute("formTagIds", tagIdsStr);
            loadFormData(request);
            request.getRequestDispatcher("/WEB-INF/views/member/write.jsp").forward(request, response);
        }
    }

    private void loadFormData(HttpServletRequest request) {
        List<Category> raw = categoryDAO.getAllCategories();

        // DFS traversal so the dropdown shows "Parent → Child" indented correctly
        List<Category> roots = new ArrayList<>();
        Map<Integer, List<Category>> childrenMap = new LinkedHashMap<>();
        for (Category c : raw) {
            childrenMap.put(c.getId(), new ArrayList<>());
        }
        for (Category c : raw) {
            if (c.getParentId() == null) {
                roots.add(c);
            } else {
                List<Category> siblings = childrenMap.get(c.getParentId());
                if (siblings != null) siblings.add(c);
            }
        }

        // DFS traversal → correct display order + accurate depth per node
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
            List<Category> kids = childrenMap.getOrDefault(c.getId(), Collections.emptyList());
            visit(kids, depth + 1, childrenMap, out, depthMap);
        }
    }

    private boolean isBlank(String s) {
        return s == null || s.isBlank();
    }
}
