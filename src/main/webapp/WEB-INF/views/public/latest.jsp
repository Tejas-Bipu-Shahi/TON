<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.thoughtsofnomads.model.Article, com.thoughtsofnomads.model.Category,
                 com.thoughtsofnomads.model.Tag, java.util.List, java.text.SimpleDateFormat" %>
<%
    List<Article>  articles    = (List<Article>)  request.getAttribute("articles");
    List<Category> categories  = (List<Category>) request.getAttribute("categories");
    List<Tag>      tags        = (List<Tag>)      request.getAttribute("tags");
    int currentPage = (Integer) request.getAttribute("currentPage");
    int totalPages  = (Integer) request.getAttribute("totalPages");
    int total       = (Integer) request.getAttribute("total");

    Article featured = (articles != null && !articles.isEmpty()) ? articles.get(0) : null;
    List<Article> rest = (articles != null && articles.size() > 1) ? articles.subList(1, articles.size()) : List.of();

    SimpleDateFormat fmt = new SimpleDateFormat("MMM d, yyyy");
    String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Latest Journeys — Thoughts of Nomads</title>
    <link href="https://fonts.googleapis.com/css2?family=Epilogue:wght@400;600;700&family=Work+Sans:wght@400;600&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
    <style>
        :root {
            --primary: #0e193e; --primary-container: #242e54; --on-primary: #ffffff;
            --secondary: #a23d30; --surface: #ffffff; --surface-container-lowest: #ffffff;
            --surface-container: #f3f4f5; --surface-variant: #e1e3e4;
            --on-surface: #191c1d; --on-surface-variant: #45464e;
            --background: #f8f9fa; --outline: #76767f; --outline-variant: #c6c5cf;
            --accent-yellow: #f5a623; --container-max: 1280px;
            --margin-desktop: 48px; --margin-mobile: 16px; --radius: 4px;
        }
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Work Sans', sans-serif; background-color: var(--background); color: var(--on-surface); line-height: 1.5; -webkit-font-smoothing: antialiased; }
        a { text-decoration: none; color: inherit; }
        img { max-width: 100%; display: block; }
        button { cursor: pointer; font-family: inherit; background: none; border: none; }
        .material-symbols-outlined { font-variation-settings: 'FILL' 0,'wght' 400,'GRAD' 0,'opsz' 24; vertical-align: middle; }

        .latest-layout { display: flex; flex-direction: column; min-height: 100vh; }
        .latest-main { flex-grow: 1; max-width: var(--container-max); margin: 0 auto; padding: 48px var(--margin-mobile); width: 100%; }
        @media (min-width: 768px) { .latest-main { padding: 48px var(--margin-desktop); } }

        .latest-header { margin-bottom: 48px; }
        .breadcrumbs { display: flex; align-items: center; gap: 8px; font-size: 10px; font-weight: 600; color: var(--on-surface-variant); text-transform: uppercase; letter-spacing: 0.1em; margin-bottom: 16px; }
        .breadcrumb-link:hover { color: var(--primary); text-decoration: underline; }
        .breadcrumb-icon { font-size: 14px; }
        .breadcrumb-current { color: var(--primary); }
        .latest-title { font-family: 'Epilogue', sans-serif; font-size: 36px; font-weight: 700; color: var(--on-surface); margin-bottom: 24px; text-transform: uppercase; }
        .latest-subtitle { font-size: 14px; color: var(--on-surface-variant); }

        .category-filters { display: flex; flex-wrap: wrap; gap: 8px; margin-bottom: 36px; }
        .cat-chip { padding: 7px 18px; background: var(--surface-container-lowest); color: var(--on-surface); border: 1px solid var(--outline-variant); font-size: 10px; font-weight: 600; text-transform: uppercase; letter-spacing: 0.1em; border-radius: 9999px; transition: all 0.2s; }
        .cat-chip:hover { background: var(--surface-container); }

        /* Featured */
        .featured-section { margin-bottom: 56px; }
        .featured-card { display: grid; grid-template-columns: 1fr; background: var(--surface-container-lowest); border-radius: var(--radius); border: 1px solid var(--surface-variant); overflow: hidden; transition: box-shadow 0.3s; }
        @media (min-width: 1024px) { .featured-card { grid-template-columns: 1.5fr 1fr; } }
        .featured-card:hover { box-shadow: 0 4px 20px rgba(36,46,84,0.08); }
        .featured-image-wrapper { height: 300px; background: #1a1a2e; }
        @media (min-width: 1024px) { .featured-image-wrapper { height: 100%; min-height: 400px; } }
        .featured-image { width: 100%; height: 100%; object-fit: cover; }
        .featured-no-img { width: 100%; height: 100%; display: flex; align-items: center; justify-content: center; color: #5a5d80; font-size: 64px; }
        .featured-content { padding: 32px; display: flex; flex-direction: column; justify-content: center; }
        @media (min-width: 1024px) { .featured-content { padding: 48px; } }
        .featured-label { background: #fcebd2; color: #a26b1c; padding: 4px 12px; font-size: 10px; font-weight: 700; border-radius: var(--radius); text-transform: uppercase; letter-spacing: 0.1em; display: inline-block; margin-bottom: 16px; align-self: flex-start; }
        .featured-category { font-size: 10px; font-weight: 600; color: var(--on-surface); text-transform: uppercase; letter-spacing: 0.1em; margin-bottom: 16px; }
        .featured-title { font-family: 'Epilogue', sans-serif; font-size: 28px; font-weight: 600; color: var(--on-surface); margin-bottom: 16px; line-height: 1.2; }
        @media (min-width: 768px) { .featured-title { font-size: 32px; } }
        .featured-meta { font-size: 12px; color: var(--on-surface-variant); margin-bottom: 28px; }
        .btn-read-full { display: block; background: var(--primary-container); color: var(--on-primary); font-size: 12px; font-weight: 600; text-transform: uppercase; letter-spacing: 0.1em; padding: 14px; border-radius: var(--radius); transition: background-color 0.2s; text-align: center; }
        .btn-read-full:hover { background: var(--primary); }

        /* Grid */
        .content-grid-layout { display: grid; grid-template-columns: 1fr; gap: 48px; }
        @media (min-width: 1024px) { .content-grid-layout { grid-template-columns: 2fr 1fr; } }
        .articles-grid { display: grid; grid-template-columns: 1fr; gap: 24px; margin-bottom: 36px; }
        @media (min-width: 768px) { .articles-grid { grid-template-columns: repeat(2, 1fr); } }

        .standard-card { background: var(--surface-container-lowest); border-radius: var(--radius); border: 1px solid var(--surface-variant); display: flex; flex-direction: column; overflow: hidden; transition: box-shadow 0.3s; }
        .standard-card:hover { box-shadow: 0 4px 20px rgba(36,46,84,0.08); }
        .card-img-wrapper { height: 200px; overflow: hidden; background: #e0e2e8; }
        .card-img { width: 100%; height: 100%; object-fit: cover; transition: transform 0.5s; }
        .standard-card:hover .card-img { transform: scale(1.05); }
        .card-no-img { width: 100%; height: 100%; display: flex; align-items: center; justify-content: center; color: #9b9ea4; font-size: 36px; }
        .card-content { padding: 24px; flex-grow: 1; display: flex; flex-direction: column; }
        .card-tag { display: inline-block; padding: 4px 8px; background: var(--surface-container); color: var(--on-surface); font-size: 9px; font-weight: 600; border-radius: var(--radius); text-transform: uppercase; letter-spacing: 0.1em; align-self: flex-start; margin-bottom: 14px; }
        .card-title { font-family: 'Epilogue', sans-serif; font-size: 18px; font-weight: 600; color: var(--on-surface); margin-bottom: 12px; line-height: 1.3; }
        .card-footer { display: flex; align-items: center; gap: 10px; margin-top: auto; padding-top: 14px; border-top: 1px solid var(--surface-variant); font-size: 10px; color: var(--on-surface); font-weight: 700; letter-spacing: 0.08em; }

        /* Empty state */
        .empty-state { text-align: center; padding: 80px 32px; color: var(--on-surface-variant); }
        .empty-state .material-symbols-outlined { font-size: 56px; color: #d0d2d8; display: block; margin-bottom: 16px; }
        .empty-title { font-size: 18px; font-weight: 600; color: var(--on-surface); margin-bottom: 8px; }

        /* Pagination */
        .pagination { display: flex; justify-content: center; align-items: center; gap: 6px; padding-top: 32px; border-top: 1px solid var(--surface-variant); }
        .page-btn { border: 1px solid var(--outline-variant); color: var(--on-surface-variant); padding: 6px 14px; border-radius: var(--radius); font-size: 12px; font-weight: 600; transition: all 0.2s; display: flex; align-items: center; gap: 4px; }
        .page-btn:hover { background: var(--surface-variant); color: var(--on-surface); }
        .page-btn.active { background: var(--primary-container); color: var(--on-primary); border-color: var(--primary-container); }
        .page-btn.disabled { opacity: 0.4; pointer-events: none; }

        /* Sidebar */
        .sidebar-sticky { position: sticky; top: 100px; display: flex; flex-direction: column; gap: 24px; }
        .widget { background: var(--surface-container-lowest); padding: 24px; border-radius: var(--radius); border: 1px solid var(--surface-variant); }
        .widget-title { font-size: 14px; font-weight: 600; color: var(--on-surface); margin-bottom: 16px; }
        .widget-search { position: relative; }
        .widget-search-icon { position: absolute; left: 12px; top: 50%; transform: translateY(-50%); color: var(--outline); font-size: 20px; }
        .widget-search-input { width: 100%; background: var(--surface-container-lowest); border: 1px solid var(--outline-variant); border-radius: var(--radius); padding: 10px 12px 10px 40px; font-size: 14px; color: var(--on-surface); outline: none; font-family: inherit; }
        .widget-search-input:focus { border-color: var(--primary-container); }
        .widget-tags { display: flex; flex-wrap: wrap; gap: 8px; }
        .tag-link { padding: 6px 12px; background: var(--background); color: var(--on-surface-variant); font-size: 11px; border-radius: var(--radius); border: 1px solid var(--surface-variant); }
        .tag-link:hover { background: var(--surface-variant); color: var(--on-surface); }
        .widget-newsletter { background: var(--primary-container); color: var(--on-primary); padding: 28px; border-radius: var(--radius); text-align: center; }
        .newsletter-icon { font-size: 28px; color: var(--accent-yellow); margin-bottom: 12px; }
        .newsletter-title { font-family: 'Epilogue', sans-serif; font-size: 20px; font-weight: 600; margin-bottom: 10px; }
        .newsletter-desc { font-size: 13px; color: #dce1ff; margin-bottom: 20px; line-height: 1.5; }
        .newsletter-input { width: 100%; background: rgba(255,255,255,0.1); border: 1px solid rgba(255,255,255,0.2); border-radius: var(--radius); padding: 11px; margin-bottom: 10px; color: var(--on-primary); outline: none; font-family: inherit; }
        .newsletter-input::placeholder { color: rgba(255,255,255,0.6); }
        .newsletter-btn { width: 100%; background: var(--accent-yellow); color: #462b00; font-size: 12px; font-weight: 700; text-transform: uppercase; letter-spacing: 0.1em; padding: 11px; border-radius: var(--radius); border: none; cursor: pointer; }
    </style>
</head>
<body class="latest-layout">
    <jsp:include page="/WEB-INF/views/includes/header.jsp"/>

    <main class="latest-main">
        <header class="latest-header">
            <div class="breadcrumbs">
                <a class="breadcrumb-link" href="<%= cp %>/">Home</a>
                <span class="material-symbols-outlined breadcrumb-icon">chevron_right</span>
                <span class="breadcrumb-current">Latest</span>
            </div>
            <h1 class="latest-title">Latest Journeys</h1>
            <% if (total > 0) { %>
            <p class="latest-subtitle"><%= total %> published <%= total == 1 ? "story" : "stories" %></p>
            <% } %>
        </header>

        <!-- Category filter chips -->
        <% if (categories != null && !categories.isEmpty()) { %>
        <div class="category-filters">
            <% for (Category cat : categories) { if (cat.getParentId() == null) { %>
            <a href="<%= cp %>/category?id=<%= cat.getId() %>" class="cat-chip"><%= cat.getName() %></a>
            <% } } %>
        </div>
        <% } %>

        <% if (featured == null) { %>
        <div class="empty-state">
            <span class="material-symbols-outlined">travel_explore</span>
            <div class="empty-title">No stories yet</div>
            <p>Check back soon — new journeys are on the way.</p>
        </div>
        <% } else { %>

        <!-- Featured -->
        <section class="featured-section">
            <a href="<%= cp %>/article?id=<%= featured.getArticleId() %>" class="featured-card">
                <div class="featured-image-wrapper">
                    <% if (featured.getCoverImage() != null) { %>
                    <img class="featured-image" src="<%= cp %>/<%= featured.getCoverImage() %>" alt=""/>
                    <% } else { %>
                    <div class="featured-no-img"><span class="material-symbols-outlined">article</span></div>
                    <% } %>
                </div>
                <div class="featured-content">
                    <span class="featured-label">Just Published</span>
                    <% if (featured.getCategoryName() != null) { %>
                    <div class="featured-category"><%= featured.getCategoryName() %></div>
                    <% } %>
                    <h2 class="featured-title"><%= featured.getTitle() %></h2>
                    <div class="featured-meta">
                        <%= featured.getAuthorName() != null ? featured.getAuthorName() : "" %>
                        <% if (featured.getPublishedAt() != null) { %>
                        · <%= fmt.format(featured.getPublishedAt()) %>
                        <% } %>
                        · <%= featured.getReadTimeMinutes() %> min read
                    </div>
                    <span class="btn-read-full">Read Full Journey</span>
                </div>
            </a>
        </section>

        <!-- Grid + sidebar -->
        <div class="content-grid-layout">
            <div>
                <% if (!rest.isEmpty()) { %>
                <div class="articles-grid">
                    <% for (Article a : rest) { %>
                    <a href="<%= cp %>/article?id=<%= a.getArticleId() %>" class="standard-card">
                        <div class="card-img-wrapper">
                            <% if (a.getCoverImage() != null) { %>
                            <img class="card-img" src="<%= cp %>/<%= a.getCoverImage() %>" alt=""/>
                            <% } else { %>
                            <div class="card-no-img"><span class="material-symbols-outlined">article</span></div>
                            <% } %>
                        </div>
                        <div class="card-content">
                            <% if (a.getCategoryName() != null) { %>
                            <span class="card-tag"><%= a.getCategoryName() %></span>
                            <% } %>
                            <h3 class="card-title"><%= a.getTitle() %></h3>
                            <div class="card-footer">
                                <%= a.getAuthorName() != null ? a.getAuthorName().toUpperCase() : "" %>
                                · <%= a.getReadTimeMinutes() %> MIN READ
                            </div>
                        </div>
                    </a>
                    <% } %>
                </div>
                <% } %>

                <!-- Pagination -->
                <% if (totalPages > 1) { %>
                <div class="pagination">
                    <% if (currentPage > 1) { %>
                    <a href="?page=<%= currentPage - 1 %>" class="page-btn">
                        <span class="material-symbols-outlined" style="font-size:16px;">chevron_left</span> Prev
                    </a>
                    <% } else { %>
                    <span class="page-btn disabled">
                        <span class="material-symbols-outlined" style="font-size:16px;">chevron_left</span> Prev
                    </span>
                    <% } %>
                    <% for (int p = 1; p <= totalPages; p++) { %>
                    <a href="?page=<%= p %>" class="page-btn <%= p == currentPage ? "active" : "" %>"><%= p %></a>
                    <% } %>
                    <% if (currentPage < totalPages) { %>
                    <a href="?page=<%= currentPage + 1 %>" class="page-btn">
                        Next <span class="material-symbols-outlined" style="font-size:16px;">chevron_right</span>
                    </a>
                    <% } else { %>
                    <span class="page-btn disabled">
                        Next <span class="material-symbols-outlined" style="font-size:16px;">chevron_right</span>
                    </span>
                    <% } %>
                </div>
                <% } %>
            </div>

            <!-- Sidebar -->
            <aside>
                <div class="sidebar-sticky">
                    <div class="widget">
                        <h3 class="widget-title">Search Archive</h3>
                        <form method="get" action="<%= cp %>/search" class="widget-search">
                            <span class="material-symbols-outlined widget-search-icon">search</span>
                            <input class="widget-search-input" name="q" placeholder="Keywords, destinations..." type="text"/>
                        </form>
                    </div>
                    <% if (tags != null && !tags.isEmpty()) { %>
                    <div class="widget">
                        <h3 class="widget-title">Browse by Tag</h3>
                        <div class="widget-tags">
                            <% for (Tag tag : tags) { %>
                            <a class="tag-link" href="<%= cp %>/search?q=<%= tag.getName() %>">#<%= tag.getName() %></a>
                            <% } %>
                        </div>
                    </div>
                    <% } %>
                    <div class="widget-newsletter">
                        <span class="material-symbols-outlined newsletter-icon">mail</span>
                        <h3 class="newsletter-title">Join the Tribe</h3>
                        <p class="newsletter-desc">Dispatches from the road, editorial insights, and exclusive guides.</p>
                        <input class="newsletter-input" id="latestNLEmail" placeholder="Your email address" type="email"/>
                        <button class="newsletter-btn" id="latestNLBtn">Subscribe</button>
                        <p id="latestNLMsg" style="display:none;margin-top:10px;font-size:12px;font-weight:600;"></p>
                    </div>
                </div>
            </aside>
        </div>
        <% } %>
    </main>

    <jsp:include page="/WEB-INF/views/includes/footer.jsp"/>
    <script>
    (function() {
        var btn   = document.getElementById('latestNLBtn');
        var input = document.getElementById('latestNLEmail');
        var msg   = document.getElementById('latestNLMsg');
        if (!btn) return;
        btn.addEventListener('click', function() {
            var email = input.value.trim();
            if (!email) return;
            btn.disabled = true; btn.textContent = 'Subscribing...';
            fetch('<%= cp %>/subscribe', {
                method: 'POST',
                headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                body: 'email=' + encodeURIComponent(email)
            })
            .then(function(r) { return r.json(); })
            .then(function(data) {
                if (data.success) {
                    input.style.display = 'none'; btn.style.display = 'none';
                    msg.style.color = '#a8d5b5'; msg.textContent = "You're subscribed!";
                    msg.style.display = 'block';
                } else {
                    msg.style.color = '#ffb3b3';
                    msg.textContent = data.error || 'Something went wrong.';
                    msg.style.display = 'block';
                    btn.disabled = false; btn.textContent = 'Subscribe';
                }
            })
            .catch(function() {
                msg.style.color = '#ffb3b3'; msg.textContent = 'Connection error. Try again.';
                msg.style.display = 'block';
                btn.disabled = false; btn.textContent = 'Subscribe';
            });
        });
    })();
    </script>
</body>
</html>
