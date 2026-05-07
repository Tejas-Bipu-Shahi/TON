<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.thoughtsofnomads.model.Category, java.util.List" %>
<%
    List<Category> categories = (List<Category>) request.getAttribute("categories");
    if (categories == null) categories = java.util.List.of();
    String cp = request.getContextPath();

    // Separate parents and children
    List<Category> parents  = new java.util.ArrayList<>();
    List<Category> children = new java.util.ArrayList<>();
    for (Category c : categories) {
        if (c.isSubcategory()) children.add(c);
        else parents.add(c);
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Categories — Thoughts of Nomads</title>
    <link href="https://fonts.googleapis.com/css2?family=Epilogue:wght@400;600;700&family=Work+Sans:wght@400;500;600&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
    <style>
        :root {
            --primary: #0e193e; --primary-container: #242e54; --on-primary: #ffffff;
            --surface: #ffffff; --surface-container: #f3f4f5; --surface-variant: #e1e3e4;
            --on-surface: #191c1d; --on-surface-variant: #45464e;
            --background: #f8f9fa; --outline-variant: #c6c5cf;
            --container-max: 1280px; --margin-desktop: 48px; --margin-mobile: 16px; --radius: 4px;
        }
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Work Sans', sans-serif; background: var(--background); color: var(--on-surface); line-height: 1.5; -webkit-font-smoothing: antialiased; }
        a { text-decoration: none; color: inherit; }
        .material-symbols-outlined { font-variation-settings: 'FILL' 0,'wght' 400,'GRAD' 0,'opsz' 24; vertical-align: middle; }

        .page-layout { display: flex; flex-direction: column; min-height: 100vh; }
        .page-main { flex: 1; max-width: var(--container-max); margin: 0 auto; width: 100%; padding: 48px var(--margin-mobile); }
        @media (min-width: 768px) { .page-main { padding: 48px var(--margin-desktop); } }

        /* Header */
        .page-header { margin-bottom: 48px; }
        .breadcrumbs { display: flex; align-items: center; gap: 8px; font-size: 11px; font-weight: 600; color: var(--on-surface-variant); text-transform: uppercase; letter-spacing: 0.1em; margin-bottom: 16px; }
        .breadcrumbs a:hover { color: var(--primary); text-decoration: underline; }
        .breadcrumb-icon { font-size: 14px; }
        .page-title { font-family: 'Epilogue', sans-serif; font-size: 36px; font-weight: 700; color: var(--on-surface); text-transform: uppercase; margin-bottom: 8px; }
        .page-subtitle { font-size: 15px; color: var(--on-surface-variant); }

        /* Category grid */
        .section-label { font-family: 'Epilogue', sans-serif; font-size: 13px; font-weight: 700; color: var(--on-surface-variant); text-transform: uppercase; letter-spacing: 0.12em; margin-bottom: 20px; }
        .cat-grid { display: grid; grid-template-columns: 1fr; gap: 16px; margin-bottom: 48px; }
        @media (min-width: 560px)  { .cat-grid { grid-template-columns: repeat(2, 1fr); } }
        @media (min-width: 900px)  { .cat-grid { grid-template-columns: repeat(3, 1fr); } }
        @media (min-width: 1200px) { .cat-grid { grid-template-columns: repeat(4, 1fr); } }

        /* Category card */
        .cat-card {
            background: var(--surface);
            border: 1px solid var(--surface-variant);
            border-radius: 8px;
            padding: 28px 24px;
            display: flex; flex-direction: column; gap: 10px;
            transition: box-shadow 0.2s, border-color 0.2s, transform 0.2s;
            position: relative;
        }
        .cat-card:hover {
            box-shadow: 0 8px 24px rgba(14,25,62,0.10);
            border-color: #b0b6cc;
            transform: translateY(-2px);
        }
        .cat-card-icon {
            width: 40px; height: 40px; border-radius: 8px;
            background: #eef0f8;
            display: flex; align-items: center; justify-content: center;
            margin-bottom: 4px;
        }
        .cat-card-icon .material-symbols-outlined { font-size: 20px; color: var(--primary); font-variation-settings: 'FILL' 1,'wght' 400,'GRAD' 0,'opsz' 24; }
        .cat-card-name { font-family: 'Epilogue', sans-serif; font-size: 17px; font-weight: 700; color: var(--primary); line-height: 1.3; }
        .cat-card-desc { font-size: 13px; color: var(--on-surface-variant); line-height: 1.6; flex: 1; }
        .cat-card-footer { display: flex; align-items: center; justify-content: space-between; margin-top: 6px; }
        .cat-card-count {
            font-size: 11px; font-weight: 700; text-transform: uppercase; letter-spacing: 0.08em;
            color: #a26b1c; background: #fff9eb; padding: 3px 10px; border-radius: 20px;
        }
        .cat-card-arrow { font-size: 18px; color: #b0b6cc; transition: color 0.2s, transform 0.2s; }
        .cat-card:hover .cat-card-arrow { color: var(--primary); transform: translateX(3px); }

        /* Sub-category strip */
        .sub-card {
            background: var(--surface);
            border: 1px solid var(--surface-variant);
            border-radius: 8px;
            padding: 18px 20px;
            display: flex; align-items: center; gap: 14px;
            transition: box-shadow 0.2s, border-color 0.2s;
        }
        .sub-card:hover { box-shadow: 0 4px 14px rgba(14,25,62,0.08); border-color: #b0b6cc; }
        .sub-card-parent { font-size: 10px; font-weight: 700; color: var(--on-surface-variant); text-transform: uppercase; letter-spacing: 0.1em; }
        .sub-card-name { font-family: 'Epilogue', sans-serif; font-size: 15px; font-weight: 600; color: var(--primary); }
        .sub-card-count { margin-left: auto; font-size: 11px; font-weight: 700; color: #a26b1c; background: #fff9eb; padding: 3px 10px; border-radius: 20px; white-space: nowrap; }

        /* Empty */
        .empty-state { text-align: center; padding: 100px 32px; color: var(--on-surface-variant); }
        .empty-state .material-symbols-outlined { font-size: 56px; color: #d0d2d8; display: block; margin-bottom: 16px; font-variation-settings: 'FILL' 0,'wght' 300,'GRAD' 0,'opsz' 48; }
        .empty-title { font-size: 18px; font-weight: 600; color: var(--on-surface); margin-bottom: 8px; }
    </style>
</head>
<body class="page-layout">
    <jsp:include page="/WEB-INF/views/includes/header.jsp"/>

    <main class="page-main">

        <div class="page-header">
            <nav class="breadcrumbs">
                <a href="<%= cp %>/">Home</a>
                <span class="material-symbols-outlined breadcrumb-icon">chevron_right</span>
                <span>Categories</span>
            </nav>
            <h1 class="page-title">Categories</h1>
            <p class="page-subtitle">Explore stories by topic — <%= categories.size() %> <%= categories.size() == 1 ? "category" : "categories" %> to discover</p>
        </div>

        <% if (categories.isEmpty()) { %>
        <div class="empty-state">
            <span class="material-symbols-outlined">folder_open</span>
            <div class="empty-title">No categories yet</div>
            <p>Check back soon — the editorial team is setting things up.</p>
        </div>

        <% } else { %>

        <!-- Main categories -->
        <% if (!parents.isEmpty()) { %>
        <p class="section-label">Browse Topics</p>
        <div class="cat-grid">
            <% for (Category c : parents) { %>
            <a href="<%= cp %>/category?id=<%= c.getId() %>" class="cat-card">
                <div class="cat-card-icon">
                    <span class="material-symbols-outlined">folder_open</span>
                </div>
                <div class="cat-card-name"><%= c.getName() %></div>
                <% if (c.getDescription() != null && !c.getDescription().isBlank()) { %>
                <div class="cat-card-desc"><%= c.getDescription() %></div>
                <% } %>
                <div class="cat-card-footer">
                    <span class="cat-card-count">
                        <%= c.getArticleCount() %> <%= c.getArticleCount() == 1 ? "story" : "stories" %>
                    </span>
                    <span class="material-symbols-outlined cat-card-arrow">arrow_forward</span>
                </div>
            </a>
            <% } %>
        </div>
        <% } %>

        <!-- Subcategories -->
        <% if (!children.isEmpty()) { %>
        <p class="section-label">Sub-topics</p>
        <div class="cat-grid">
            <% for (Category c : children) { %>
            <a href="<%= cp %>/category?id=<%= c.getId() %>" class="sub-card">
                <div>
                    <% if (c.getParentName() != null) { %>
                    <div class="sub-card-parent"><%= c.getParentName() %></div>
                    <% } %>
                    <div class="sub-card-name"><%= c.getName() %></div>
                </div>
                <span class="sub-card-count">
                    <%= c.getArticleCount() %> <%= c.getArticleCount() == 1 ? "story" : "stories" %>
                </span>
            </a>
            <% } %>
        </div>
        <% } %>

        <% } %>
    </main>

    <jsp:include page="/WEB-INF/views/includes/footer.jsp"/>
</body>
</html>
