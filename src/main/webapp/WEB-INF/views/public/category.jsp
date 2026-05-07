<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.thoughtsofnomads.model.Article, com.thoughtsofnomads.model.Category,
                 java.util.List, java.text.SimpleDateFormat" %>
<%
    Category       category      = (Category)       request.getAttribute("category");
    Category       parentCat     = (Category)       request.getAttribute("parentCategory");
    List<Article>  articles      = (List<Article>)  request.getAttribute("articles");
    List<Category> subcategories = (List<Category>) request.getAttribute("subcategories");
    List<Category> allCategories = (List<Category>) request.getAttribute("allCategories");

    if (articles      == null) articles      = java.util.List.of();
    if (subcategories == null) subcategories = java.util.List.of();

    SimpleDateFormat fmt = new SimpleDateFormat("MMM d, yyyy");
    String cp    = request.getContextPath();
    boolean hasSubs     = !subcategories.isEmpty();
    boolean hasArticles = !articles.isEmpty();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title><%= category.getName() %> — Thoughts of Nomads</title>
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
        img { max-width: 100%; display: block; }
        .material-symbols-outlined { font-variation-settings: 'FILL' 0,'wght' 400,'GRAD' 0,'opsz' 24; vertical-align: middle; }

        .page-layout { display: flex; flex-direction: column; min-height: 100vh; }
        .page-main { flex: 1; max-width: var(--container-max); margin: 0 auto; width: 100%; padding: 48px var(--margin-mobile); display: flex; flex-direction: column; gap: 48px; }
        @media (min-width: 768px) { .page-main { padding: 48px var(--margin-desktop); } }

        /* ── Header ──────────────────────────────────────────────────────── */
        .breadcrumbs { display: flex; align-items: center; flex-wrap: wrap; gap: 6px; font-size: 11px; font-weight: 600; color: var(--on-surface-variant); text-transform: uppercase; letter-spacing: 0.1em; margin-bottom: 16px; }
        .breadcrumbs a:hover { color: var(--primary); text-decoration: underline; }
        .breadcrumb-icon { font-size: 14px; }
        .cat-title { font-family: 'Epilogue', sans-serif; font-size: 36px; font-weight: 700; color: var(--primary); text-transform: uppercase; margin-bottom: 8px; }
        .cat-meta  { font-size: 14px; color: var(--on-surface-variant); margin-bottom: 12px; }
        .cat-desc  { font-size: 15px; color: var(--on-surface-variant); max-width: 700px; line-height: 1.6; }

        /* ── Other category chips ────────────────────────────────────────── */
        .other-cats { display: flex; flex-wrap: wrap; gap: 8px; }
        .cat-chip { padding: 6px 16px; background: var(--surface); color: var(--on-surface); border: 1px solid var(--outline-variant); font-size: 10px; font-weight: 600; text-transform: uppercase; letter-spacing: 0.1em; border-radius: 9999px; transition: all 0.2s; }
        .cat-chip:hover { background: var(--primary); color: var(--on-primary); border-color: var(--primary); }

        /* ── Section heading ─────────────────────────────────────────────── */
        .section-heading { font-family: 'Epilogue', sans-serif; font-size: 22px; font-weight: 700; color: var(--on-surface); margin-bottom: 24px; display: flex; align-items: center; gap: 10px; }
        .section-count { font-size: 13px; font-weight: 600; color: var(--on-surface-variant); background: var(--surface-container); padding: 3px 10px; border-radius: 20px; }

        /* ── Subcategory cards ───────────────────────────────────────────── */
        .sub-grid { display: grid; grid-template-columns: 1fr; gap: 14px; }
        @media (min-width: 560px)  { .sub-grid { grid-template-columns: repeat(2, 1fr); } }
        @media (min-width: 900px)  { .sub-grid { grid-template-columns: repeat(3, 1fr); } }
        @media (min-width: 1200px) { .sub-grid { grid-template-columns: repeat(4, 1fr); } }

        .sub-card {
            background: var(--surface); border: 1px solid var(--surface-variant); border-radius: 8px;
            padding: 22px 20px; display: flex; flex-direction: column; gap: 8px;
            transition: box-shadow 0.2s, border-color 0.2s, transform 0.2s;
        }
        .sub-card:hover { box-shadow: 0 8px 24px rgba(14,25,62,0.09); border-color: #b0b6cc; transform: translateY(-2px); }
        .sub-card-icon { width: 36px; height: 36px; border-radius: 8px; background: #eef0f8; display: flex; align-items: center; justify-content: center; margin-bottom: 2px; }
        .sub-card-icon .material-symbols-outlined { font-size: 18px; color: var(--primary); font-variation-settings: 'FILL' 1,'wght' 400,'GRAD' 0,'opsz' 20; }
        .sub-card-name { font-family: 'Epilogue', sans-serif; font-size: 16px; font-weight: 700; color: var(--primary); line-height: 1.3; }
        .sub-card-desc { font-size: 12px; color: var(--on-surface-variant); line-height: 1.5; flex: 1; }
        .sub-card-footer { display: flex; align-items: center; justify-content: space-between; margin-top: 4px; }
        .sub-card-count { font-size: 11px; font-weight: 700; color: #a26b1c; background: #fff9eb; padding: 3px 10px; border-radius: 20px; }
        .sub-card-arrow { font-size: 16px; color: #b0b6cc; transition: color 0.2s, transform 0.2s; }
        .sub-card:hover .sub-card-arrow { color: var(--primary); transform: translateX(3px); }

        /* ── Article grid ────────────────────────────────────────────────── */
        .articles-grid { display: grid; grid-template-columns: 1fr; gap: 24px; }
        @media (min-width: 640px)  { .articles-grid { grid-template-columns: repeat(2, 1fr); } }
        @media (min-width: 1024px) { .articles-grid { grid-template-columns: repeat(3, 1fr); } }

        .article-card { background: var(--surface); border: 1px solid var(--surface-variant); border-radius: var(--radius); display: flex; flex-direction: column; overflow: hidden; transition: box-shadow 0.3s; }
        .article-card:hover { box-shadow: 0 10px 25px rgba(0,0,0,0.08); }
        .card-img-wrap  { width: 100%; height: 200px; overflow: hidden; background: #e0e2e8; }
        .card-img       { width: 100%; height: 100%; object-fit: cover; transition: transform 0.5s; }
        .article-card:hover .card-img { transform: scale(1.05); }
        .card-no-img    { width: 100%; height: 100%; display: flex; align-items: center; justify-content: center; color: #9b9ea4; }
        .card-no-img .material-symbols-outlined { font-size: 40px; font-variation-settings: 'FILL' 0,'wght' 300,'GRAD' 0,'opsz' 40; }
        .card-body      { padding: 22px; display: flex; flex-direction: column; flex: 1; gap: 8px; }
        .card-tag       { align-self: flex-start; background: var(--surface-container); color: var(--on-surface); padding: 3px 8px; border-radius: var(--radius); font-size: 10px; font-weight: 600; letter-spacing: 0.1em; text-transform: uppercase; }
        .card-title     { font-family: 'Epilogue', sans-serif; font-size: 17px; font-weight: 600; color: var(--on-surface); line-height: 1.3; }
        .card-footer    { margin-top: auto; padding-top: 12px; border-top: 1px solid var(--surface-variant); }
        .card-author    { font-size: 12px; font-weight: 600; color: var(--on-surface); }
        .card-date      { font-size: 12px; color: var(--on-surface-variant); }

        /* ── Divider ─────────────────────────────────────────────────────── */
        .section-divider { border: none; border-top: 1px solid var(--surface-variant); margin: 0; }

        /* ── Empty ───────────────────────────────────────────────────────── */
        .empty-state { text-align: center; padding: 80px 32px; color: var(--on-surface-variant); }
        .empty-state .material-symbols-outlined { font-size: 52px; color: #d0d2d8; display: block; margin-bottom: 16px; font-variation-settings: 'FILL' 0,'wght' 300,'GRAD' 0,'opsz' 48; }
        .empty-title { font-size: 18px; font-weight: 600; color: var(--on-surface); margin-bottom: 8px; }
    </style>
</head>
<body class="page-layout">
    <jsp:include page="/WEB-INF/views/includes/header.jsp"/>

    <main class="page-main">

        <!-- ── Header ─────────────────────────────────────────────────────── -->
        <section>
            <nav class="breadcrumbs">
                <a href="<%= cp %>/">Home</a>
                <span class="material-symbols-outlined breadcrumb-icon">chevron_right</span>
                <a href="<%= cp %>/categories">Categories</a>
                <% if (parentCat != null) { %>
                <span class="material-symbols-outlined breadcrumb-icon">chevron_right</span>
                <a href="<%= cp %>/category?id=<%= parentCat.getId() %>"><%= parentCat.getName() %></a>
                <% } %>
                <span class="material-symbols-outlined breadcrumb-icon">chevron_right</span>
                <span><%= category.getName() %></span>
            </nav>
            <h1 class="cat-title"><%= category.getName() %></h1>
            <p class="cat-meta">
                <% if (hasSubs) { %>
                    <%= subcategories.size() %> sub-topic<%= subcategories.size() == 1 ? "" : "s" %>
                    <% if (hasArticles) { %> &middot; <%= articles.size() %> direct <%= articles.size() == 1 ? "story" : "stories" %><% } %>
                <% } else { %>
                    <%= articles.size() %> <%= articles.size() == 1 ? "story" : "stories" %>
                <% } %>
            </p>
            <% if (category.getDescription() != null && !category.getDescription().isBlank()) { %>
            <p class="cat-desc"><%= category.getDescription() %></p>
            <% } %>
        </section>

        <!-- ── Other categories row ───────────────────────────────────────── -->
        <% if (allCategories != null && !allCategories.isEmpty()) { %>
        <div class="other-cats">
            <% for (Category c : allCategories) {
                if (c.getId() == category.getId()) continue;
                if (c.isSubcategory()) continue; %>
            <a href="<%= cp %>/category?id=<%= c.getId() %>" class="cat-chip"><%= c.getName() %></a>
            <% } %>
        </div>
        <% } %>

        <!-- ── Subcategories ──────────────────────────────────────────────── -->
        <% if (hasSubs) { %>
        <section>
            <h2 class="section-heading">
                Explore Topics
                <span class="section-count"><%= subcategories.size() %></span>
            </h2>
            <div class="sub-grid">
                <% for (Category sub : subcategories) { %>
                <a href="<%= cp %>/category?id=<%= sub.getId() %>" class="sub-card">
                    <div class="sub-card-icon">
                        <span class="material-symbols-outlined">folder_open</span>
                    </div>
                    <div class="sub-card-name"><%= sub.getName() %></div>
                    <% if (sub.getDescription() != null && !sub.getDescription().isBlank()) { %>
                    <div class="sub-card-desc"><%= sub.getDescription() %></div>
                    <% } %>
                    <div class="sub-card-footer">
                        <span class="sub-card-count">
                            <%= sub.getArticleCount() %> <%= sub.getArticleCount() == 1 ? "story" : "stories" %>
                        </span>
                        <span class="material-symbols-outlined sub-card-arrow">arrow_forward</span>
                    </div>
                </a>
                <% } %>
            </div>
        </section>
        <% } %>

        <!-- ── Articles directly in this category ────────────────────────── -->
        <% if (hasArticles) { %>
        <% if (hasSubs) { %><hr class="section-divider"/><% } %>
        <section>
            <h2 class="section-heading">
                <%= hasSubs ? "Stories in " + category.getName() : "Stories" %>
                <span class="section-count"><%= articles.size() %></span>
            </h2>
            <div class="articles-grid">
                <% for (Article a : articles) { %>
                <a href="<%= cp %>/article?id=<%= a.getArticleId() %>" class="article-card">
                    <div class="card-img-wrap">
                        <% if (a.getCoverImage() != null && !a.getCoverImage().isBlank()) { %>
                        <img class="card-img" src="<%= cp %>/<%= a.getCoverImage() %>" alt=""/>
                        <% } else { %>
                        <div class="card-no-img"><span class="material-symbols-outlined">article</span></div>
                        <% } %>
                    </div>
                    <div class="card-body">
                        <span class="card-tag"><%= category.getName() %></span>
                        <h2 class="card-title"><%= a.getTitle() %></h2>
                        <div class="card-footer">
                            <div class="card-author"><%= a.getAuthorName() != null ? a.getAuthorName() : "" %></div>
                            <div class="card-date">
                                <%= a.getPublishedAt() != null ? fmt.format(a.getPublishedAt()) : "" %>
                                <% if (a.getReadTimeMinutes() > 0) { %> &middot; <%= a.getReadTimeMinutes() %> min read<% } %>
                            </div>
                        </div>
                    </div>
                </a>
                <% } %>
            </div>
        </section>
        <% } %>

        <!-- ── Truly empty (no subs, no articles) ────────────────────────── -->
        <% if (!hasSubs && !hasArticles) { %>
        <div class="empty-state">
            <span class="material-symbols-outlined">travel_explore</span>
            <div class="empty-title">No stories yet in <%= category.getName() %></div>
            <p>Check back soon — contributors are writing!</p>
        </div>
        <% } %>

    </main>

    <jsp:include page="/WEB-INF/views/includes/footer.jsp"/>
</body>
</html>
