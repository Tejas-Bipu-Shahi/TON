package com.thoughtsofnomads.controller;

import com.thoughtsofnomads.dao.TagDAO;
import com.thoughtsofnomads.model.Tag;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/tags")
public class AdminTagsServlet extends HttpServlet {

    private final TagDAO tagDAO = new TagDAO();

    // ── GET — list all, optionally pre-fill form for edit ────────────────────

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Tag> tags = tagDAO.getAllTags();
        request.setAttribute("tags", tags);

        // Pre-fill edit form when ?editId=X is present
        String editIdParam = request.getParameter("editId");
        if (editIdParam != null && !editIdParam.isBlank()) {
            try {
                int editId = Integer.parseInt(editIdParam);
                Tag toEdit = tagDAO.getTagById(editId);
                if (toEdit != null) {
                    request.setAttribute("editTag", toEdit);
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

        request.setAttribute("adminPageTitle", "Tags");
        request.getRequestDispatcher("/WEB-INF/views/admin/tags.jsp").forward(request, response);
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

        String name = trim(request.getParameter("name"));
        String slug = trim(request.getParameter("slug"));

        if (name.isEmpty() || slug.isEmpty()) {
            setFlash(request, null, "Tag name and slug are required.");
            response.sendRedirect(contextPath + "/admin/tags");
            return;
        }

        Tag tag = new Tag(name, slug);
        if (tagDAO.addTag(tag)) {
            setFlash(request, "Tag \"" + name + "\" added successfully.", null);
        } else {
            setFlash(request, null, "Failed to add tag. The name or slug may already exist.");
        }
        response.sendRedirect(contextPath + "/admin/tags");
    }

    private void handleEdit(HttpServletRequest request, HttpServletResponse response, String contextPath)
            throws IOException {

        String idParam = request.getParameter("id");
        String name    = trim(request.getParameter("name"));
        String slug    = trim(request.getParameter("slug"));

        if (idParam == null || name.isEmpty() || slug.isEmpty()) {
            setFlash(request, null, "Invalid edit request.");
            response.sendRedirect(contextPath + "/admin/tags");
            return;
        }

        try {
            int id = Integer.parseInt(idParam);
            Tag tag = new Tag(name, slug);
            tag.setId(id);

            if (tagDAO.updateTag(tag)) {
                setFlash(request, "Tag \"" + name + "\" updated successfully.", null);
            } else {
                setFlash(request, null, "Failed to update tag. The name or slug may already exist.");
            }
        } catch (NumberFormatException e) {
            setFlash(request, null, "Invalid tag ID.");
        }
        response.sendRedirect(contextPath + "/admin/tags");
    }

    private void handleDelete(HttpServletRequest request, HttpServletResponse response, String contextPath)
            throws IOException {

        String idParam = request.getParameter("id");
        if (idParam == null) {
            setFlash(request, null, "Invalid delete request.");
            response.sendRedirect(contextPath + "/admin/tags");
            return;
        }

        try {
            int id = Integer.parseInt(idParam);
            if (tagDAO.deleteTag(id)) {
                setFlash(request, "Tag deleted.", null);
            } else {
                setFlash(request, null, "Tag not found or could not be deleted.");
            }
        } catch (NumberFormatException e) {
            setFlash(request, null, "Invalid tag ID.");
        }
        response.sendRedirect(contextPath + "/admin/tags");
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
}
