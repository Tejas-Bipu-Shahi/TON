package com.thoughtsofnomads.controller;

import com.thoughtsofnomads.dao.CategoryDAO;
import com.thoughtsofnomads.model.Category;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/categories")
public class AdminCategoriesServlet extends HttpServlet {

    private final CategoryDAO categoryDAO = new CategoryDAO();

    // ── GET — list all, optionally pre-fill form for edit ────────────────────

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Category> categories = categoryDAO.getAllCategories();
        request.setAttribute("categories", categories);

        // Pre-fill edit form when ?editId=X is present
        String editIdParam = request.getParameter("editId");
        if (editIdParam != null && !editIdParam.isBlank()) {
            try {
                int editId = Integer.parseInt(editIdParam);
                Category toEdit = categoryDAO.getCategoryById(editId);
                if (toEdit != null) {
                    request.setAttribute("editCategory", toEdit);
                }
            } catch (NumberFormatException ignored) {}
        }

        // Pass flash messages from session, then remove them
        HttpSession session = request.getSession(false);
        if (session != null) {
            request.setAttribute("flashSuccess", session.getAttribute("flashSuccess"));
            request.setAttribute("flashError",   session.getAttribute("flashError"));
            session.removeAttribute("flashSuccess");
            session.removeAttribute("flashError");
        }

        request.setAttribute("adminPageTitle", "Categories");
        request.getRequestDispatcher("/WEB-INF/views/admin/categories.jsp").forward(request, response);
    }

    // ── POST — add / edit / delete ────────────────────────────────────────────

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String contextPath = request.getContextPath();

        if ("delete".equals(action)) {
            handleDelete(request, response, contextPath);
        } else if ("edit".equals(action)) {
            handleEdit(request, response, contextPath);
        } else {
            handleAdd(request, response, contextPath);
        }
    }

    // ── Handlers ──────────────────────────────────────────────────────────────

    private void handleAdd(HttpServletRequest request, HttpServletResponse response, String contextPath)
            throws IOException {

        String name        = trim(request.getParameter("name"));
        String slug        = trim(request.getParameter("slug"));
        String description = trim(request.getParameter("description"));
        String parentParam = request.getParameter("parentId");

        if (name.isEmpty() || slug.isEmpty()) {
            setFlash(request, null, "Name and Slug are required.");
            response.sendRedirect(contextPath + "/admin/categories");
            return;
        }

        Integer parentId = parseParentId(parentParam);
        Category cat = new Category(name, slug, description.isEmpty() ? null : description, parentId);

        if (categoryDAO.addCategory(cat)) {
            setFlash(request, "Category \"" + name + "\" added successfully.", null);
        } else {
            setFlash(request, null, "Failed to add category. The name or slug may already exist.");
        }
        response.sendRedirect(contextPath + "/admin/categories");
    }

    private void handleEdit(HttpServletRequest request, HttpServletResponse response, String contextPath)
            throws IOException {

        String idParam     = request.getParameter("id");
        String name        = trim(request.getParameter("name"));
        String slug        = trim(request.getParameter("slug"));
        String description = trim(request.getParameter("description"));
        String parentParam = request.getParameter("parentId");

        if (idParam == null || name.isEmpty() || slug.isEmpty()) {
            setFlash(request, null, "Invalid edit request.");
            response.sendRedirect(contextPath + "/admin/categories");
            return;
        }

        try {
            int id = Integer.parseInt(idParam);
            Integer parentId = parseParentId(parentParam);

            Category cat = new Category(name, slug, description.isEmpty() ? null : description, parentId);
            cat.setId(id);

            // would create an infinite loop in the breadcrumb traversal
            if (parentId != null && parentId == id) {
                setFlash(request, null, "A category cannot be its own parent.");
                response.sendRedirect(contextPath + "/admin/categories");
                return;
            }

            if (categoryDAO.updateCategory(cat)) {
                setFlash(request, "Category \"" + name + "\" updated successfully.", null);
            } else {
                setFlash(request, null, "Failed to update category. The name or slug may already exist.");
            }
        } catch (NumberFormatException e) {
            setFlash(request, null, "Invalid category ID.");
        }
        response.sendRedirect(contextPath + "/admin/categories");
    }

    private void handleDelete(HttpServletRequest request, HttpServletResponse response, String contextPath)
            throws IOException {

        String idParam = request.getParameter("id");
        if (idParam == null) {
            setFlash(request, null, "Invalid delete request.");
            response.sendRedirect(contextPath + "/admin/categories");
            return;
        }

        try {
            int id = Integer.parseInt(idParam);
            if (categoryDAO.deleteCategory(id)) {
                setFlash(request, "Category deleted.", null);
            } else {
                setFlash(request, null, "Category not found or could not be deleted.");
            }
        } catch (NumberFormatException e) {
            setFlash(request, null, "Invalid category ID.");
        }
        response.sendRedirect(contextPath + "/admin/categories");
    }

    // ── Utilities ─────────────────────────────────────────────────────────────

    private void setFlash(HttpServletRequest request, String success, String error) {
        HttpSession session = request.getSession();
        if (success != null) session.setAttribute("flashSuccess", success);
        if (error   != null) session.setAttribute("flashError",   error);
    }

    private String trim(String s) {
        return (s == null) ? "" : s.trim();
    }

    private Integer parseParentId(String param) {
        if (param == null || param.isBlank()) return null;
        try {
            int val = Integer.parseInt(param);
            return val > 0 ? val : null;
        } catch (NumberFormatException e) {
            return null;
        }
    }
}
