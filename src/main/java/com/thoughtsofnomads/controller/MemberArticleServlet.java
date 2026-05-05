package com.thoughtsofnomads.controller;

import com.thoughtsofnomads.dao.ArticleDAO;
import com.thoughtsofnomads.dao.CategoryDAO;
import com.thoughtsofnomads.dao.TagDAO;
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

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
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
        List<Category> categories = categoryDAO.getAllCategories();

        // Build depth map: category id → nesting level (0 = root, 1 = child, 2 = grandchild)
        Map<Integer, Integer> depthMap = new LinkedHashMap<>();
        for (Category c : categories) {
            if (c.getParentId() == null) {
                depthMap.put(c.getId(), 0);
            } else {
                int parentDepth = depthMap.getOrDefault(c.getParentId(), 0);
                depthMap.put(c.getId(), parentDepth + 1);
            }
        }

        List<Tag> tags = tagDAO.getAllTags();

        request.setAttribute("categories", categories);
        request.setAttribute("categoryDepths", depthMap);
        request.setAttribute("tags", tags);
    }

    private boolean isBlank(String s) {
        return s == null || s.isBlank();
    }
}
