<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.thoughtsofnomads.model.Article, java.util.List, java.text.SimpleDateFormat" %>
<%
    List<Article> topPicks       = (List<Article>) request.getAttribute("topPicks");
    List<Article> latestArticles = (List<Article>) request.getAttribute("latestArticles");
    if (topPicks == null)       topPicks       = java.util.List.of();
    if (latestArticles == null) latestArticles = java.util.List.of();
    String cp = request.getContextPath();
    SimpleDateFormat fmt = new SimpleDateFormat("MMM d, yyyy");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <title>Thoughts of Nomads</title>
    <style>
        :root {
            --primary: #0e193e;
            --primary-container: #242e54;
            --on-primary: #ffffff;
            --surface: #f8f9fa;
            --surface-container-lowest: #ffffff;
            --surface-variant: #e1e3e4;
            --on-surface: #191c1d;
            --on-surface-variant: #45464e;
            --outline-variant: #c6c5cf;
            --container-max: 1280px;
            --margin-desktop: 48px;
            --margin-mobile: 16px;
            --radius: 4px;
        }

        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Work Sans', sans-serif; background-color: var(--surface); color: var(--on-surface); line-height: 1.5; -webkit-font-smoothing: antialiased; }
        a { text-decoration: none; color: inherit; }
        img { display: block; max-width: 100%; }

        /* ── HERO ──────────────────────────────────────────────── */
        .hero-header {
            width: 100%;
            background-color: #f1f1f1;
            padding: 40px var(--margin-mobile);
        }
        @media (min-width: 768px) { .hero-header { padding: 60px var(--margin-desktop); } }

        .hero-device-frame {
            max-width: var(--container-max);
            margin: 0 auto;
            background-color: #1a1c1e;
            padding: 20px;
            border-radius: 24px;
            box-shadow: 0 20px 50px rgba(0,0,0,0.15);
        }

        .hero-inner-content {
            position: relative;
            height: 500px;
            border-radius: 8px;
            overflow: hidden;
        }

        .hero-image { width: 100%; height: 100%; object-fit: cover; }
        .hero-overlay {
            position: absolute; inset: 0;
            background: linear-gradient(to bottom, rgba(0,0,0,0.2) 0%, rgba(0,0,0,0.6) 100%);
            display: flex; flex-direction: column; justify-content: center; padding: 48px;
        }

        .hero-title {
            font-family: 'Epilogue', sans-serif;
            font-size: clamp(32px, 5vw, 64px);
            font-weight: 700; color: #ffffff; margin-bottom: 24px;
        }

        .hero-search-form { position: relative; width: 100%; max-width: 500px; }
        .search-icon { position: absolute; left: 16px; top: 50%; transform: translateY(-50%); color: var(--on-surface-variant); }
        .hero-search-input {
            width: 100%; padding: 16px 16px 16px 48px; border: none; border-radius: 4px;
            font-size: 16px; outline: none; background-color: #ffffff;
        }
        .hero-subtitle { color: rgba(255,255,255,0.8); font-size: 12px; text-transform: uppercase; letter-spacing: 0.1em; margin-top: 12px; }

        /* ── SECTIONS ──────────────────────────────────────────── */
        .home-section { max-width: var(--container-max); margin: 0 auto; padding: 64px var(--margin-mobile); }
        @media (min-width: 768px) { .home-section { padding: 80px var(--margin-desktop); } }

        .section-header { display: flex; align-items: baseline; justify-content: space-between; margin-bottom: 40px; }
        .section-title { font-family: 'Epilogue', sans-serif; font-size: 32px; font-weight: 700; color: #1a1c1e; }
        .section-link { font-size: 13px; font-weight: 600; color: var(--primary); text-transform: uppercase; letter-spacing: 0.08em; }
        .section-link:hover { text-decoration: underline; }

        /* ── ARTICLE CARDS ─────────────────────────────────────── */
        .article-grid { display: grid; grid-template-columns: 1fr; gap: 32px; }
        @media (min-width: 640px) { .article-grid { grid-template-columns: repeat(2, 1fr); } }
        @media (min-width: 1024px) { .article-grid { grid-template-columns: repeat(3, 1fr); } }

        .article-card {
            display: flex; flex-direction: column; cursor: pointer;
            text-decoration: none; color: inherit;
        }
        .card-image-wrapper { width: 100%; aspect-ratio: 16 / 11; overflow: hidden; margin-bottom: 20px; border: 1px solid var(--surface-variant); }
        .card-image { width: 100%; height: 100%; object-fit: cover; transition: transform 0.4s ease; }
        .article-card:hover .card-image { transform: scale(1.05); }
        .card-no-image {
            width: 100%; height: 100%;
            background: #e8eaf0;
            display: flex; align-items: center; justify-content: center;
            color: #9ba3c0;
        }
        .card-no-image .material-symbols-outlined { font-size: 48px; font-variation-settings: 'FILL' 0, 'wght' 300, 'GRAD' 0, 'opsz' 48; }

        .card-content { display: flex; flex-direction: column; gap: 12px; }
        .card-tag {
            font-size: 10px; font-weight: 700; text-transform: uppercase; letter-spacing: 0.1em;
            color: #d18900; background-color: #fff9eb; padding: 4px 10px; border-radius: 2px; width: max-content;
        }
        .card-title { font-family: 'Epilogue', sans-serif; font-size: 22px; font-weight: 600; color: #1a1c1e; line-height: 1.3; }
        .card-meta { font-size: 11px; font-weight: 700; color: #888888; text-transform: uppercase; letter-spacing: 0.05em; margin-top: 4px; }

        /* ── EMPTY STATES ──────────────────────────────────────── */
        .empty-state { text-align: center; padding: 48px 24px; color: #76767f; }
        .empty-state .material-symbols-outlined { font-size: 48px; color: #d0d2d8; font-variation-settings: 'FILL' 0, 'wght' 300, 'GRAD' 0, 'opsz' 48; }
        .empty-title { font-size: 16px; font-weight: 600; color: #45464e; margin: 12px 0 6px; }
    </style>
    <link href="https://fonts.googleapis.com/css2?family=Epilogue:wght@400;600;700&family=Work+Sans:wght@400;500;600&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet" />
</head>

<body>
    <jsp:include page="/WEB-INF/views/includes/header.jsp" />

    <!-- Hero -->
    <header class="hero-header">
        <div class="hero-device-frame">
            <div class="hero-inner-content">
                <img alt="Scenic mountain road" class="hero-image"
                     src="https://lh3.googleusercontent.com/aida-public/AB6AXuAx0KvZtVOsZeiePSzu3IW7UmdrLENlMC0OFKAKdfmzAOFE363Enj_leN19hImv4ifwFCoSojk2Jb2Hm69Wb6_52yqHhq8UhojRpelj_gPTcD5hn8-eYglCk_3UxR9gnW9ZELHwdxdBaAaW2L-4GwjOruJ2r8nhWNhIlbvG9WlN0AjXAHiXBaP3aQXg5hTMmEAw9ECdHwfUT9EngIGWnDh6ht1q3vT4IlSbamk2KGwPx76VNAkSm8QO8UKAww378qTRAUoMEqv81jw" />
                <div class="hero-overlay">
                    <h1 class="hero-title">Your Next Adventure Awaits</h1>
                    <form action="<%= cp %>/search" method="GET" class="hero-search-form">
                        <span class="material-symbols-outlined search-icon">search</span>
                        <input class="hero-search-input" placeholder="Where to next?" type="text" name="q" />
                    </form>
                    <p class="hero-subtitle">Search by destination, author, or category</p>
                </div>
            </div>
        </div>
    </header>

    <!-- Top Picks -->
    <% if (!topPicks.isEmpty()) { %>
    <section class="home-section">
        <div class="section-header">
            <h2 class="section-title">Top Picks</h2>
        </div>
        <div class="article-grid">
            <% for (Article a : topPicks) { %>
            <a class="article-card" href="<%= cp %>/article?id=<%= a.getArticleId() %>">
                <div class="card-image-wrapper">
                    <% if (a.getCoverImage() != null && !a.getCoverImage().isBlank()) { %>
                    <img alt="" class="card-image" src="<%= cp %>/<%= a.getCoverImage() %>" />
                    <% } else { %>
                    <div class="card-no-image"><span class="material-symbols-outlined">article</span></div>
                    <% } %>
                </div>
                <div class="card-content">
                    <% if (a.getCategoryName() != null) { %>
                    <span class="card-tag"><%= a.getCategoryName() %></span>
                    <% } %>
                    <h3 class="card-title"><%= a.getTitle() %></h3>
                    <% if (a.getAuthorName() != null) { %>
                    <p class="card-meta">By <%= a.getAuthorName() %></p>
                    <% } %>
                </div>
            </a>
            <% } %>
        </div>
    </section>
    <% } %>

    <!-- Latest Stories -->
    <section class="home-section" style="<%= topPicks.isEmpty() ? "" : "padding-top: 0;" %>">
        <div class="section-header">
            <h2 class="section-title">Latest Stories</h2>
            <a class="section-link" href="<%= cp %>/latest">View all &rarr;</a>
        </div>
        <% if (latestArticles.isEmpty()) { %>
        <div class="empty-state">
            <span class="material-symbols-outlined">travel_explore</span>
            <div class="empty-title">No stories yet</div>
            <p>Check back soon — new journeys are on the way.</p>
        </div>
        <% } else { %>
        <div class="article-grid">
            <% for (Article a : latestArticles) { %>
            <a class="article-card" href="<%= cp %>/article?id=<%= a.getArticleId() %>">
                <div class="card-image-wrapper">
                    <% if (a.getCoverImage() != null && !a.getCoverImage().isBlank()) { %>
                    <img alt="" class="card-image" src="<%= cp %>/<%= a.getCoverImage() %>" />
                    <% } else { %>
                    <div class="card-no-image"><span class="material-symbols-outlined">article</span></div>
                    <% } %>
                </div>
                <div class="card-content">
                    <% if (a.getCategoryName() != null) { %>
                    <span class="card-tag"><%= a.getCategoryName() %></span>
                    <% } %>
                    <h3 class="card-title"><%= a.getTitle() %></h3>
                    <p class="card-meta">
                        <% if (a.getPublishedAt() != null) { %>
                        <%= fmt.format(a.getPublishedAt()) %>
                        <% } else if (a.getAuthorName() != null) { %>
                        By <%= a.getAuthorName() %>
                        <% } %>
                    </p>
                </div>
            </a>
            <% } %>
        </div>
        <% } %>
    </section>

    <jsp:include page="/WEB-INF/views/includes/footer.jsp" />
</body>
</html>
