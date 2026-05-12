package com.thoughtsofnomads.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.Set;
import java.util.UUID;

@WebServlet("/member/upload/image")
@MultipartConfig(maxFileSize = 5 * 1024 * 1024, maxRequestSize = 6 * 1024 * 1024)
public class ImageUploadServlet extends HttpServlet {

    // only allow image formats — no SVG or PDFs
    private static final Set<String> ALLOWED_EXTS = Set.of(".jpg", ".jpeg", ".png", ".gif", ".webp");

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // belt-and-suspenders check — RoleFilter already blocks non-logged-in users on /member/*
        if (request.getSession(false) == null
                || request.getSession(false).getAttribute("user") == null) {
            sendError(response, 401, "Unauthorized");
            return;
        }

        Part part = request.getPart("image");
        if (part == null || part.getSize() == 0) {
            sendError(response, 400, "No image provided");
            return;
        }

        String originalName = part.getSubmittedFileName();
        if (originalName == null) {
            sendError(response, 400, "No filename");
            return;
        }

        String ext = originalName.contains(".")
                ? originalName.substring(originalName.lastIndexOf('.')).toLowerCase()
                : "";

        if (!ALLOWED_EXTS.contains(ext)) {
            sendError(response, 400, "File type not allowed");
            return;
        }

        String uploadsDir = getServletContext().getRealPath("")
                + java.io.File.separator + "uploads"
                + java.io.File.separator + "content";
        Files.createDirectories(Paths.get(uploadsDir));

        // UUID avoids filename collisions without needing a database sequence
        String filename = UUID.randomUUID().toString() + ext;

        try (InputStream in = part.getInputStream()) {
            Files.copy(in, Paths.get(uploadsDir, filename), StandardCopyOption.REPLACE_EXISTING);
        }

        // return just the URL — the editor (TipTap) embeds it as an <img> tag
        String url = request.getContextPath() + "/uploads/content/" + filename;

        response.setContentType("application/json;charset=UTF-8");
        response.setStatus(200);
        response.getWriter().write("{\"url\":\"" + url + "\"}");
    }

    private void sendError(HttpServletResponse response, int status, String msg) throws IOException {
        response.setContentType("application/json;charset=UTF-8");
        response.setStatus(status);
        response.getWriter().write("{\"error\":\"" + msg + "\"}");
    }
}
