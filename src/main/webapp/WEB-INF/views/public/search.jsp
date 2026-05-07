<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.thoughtsofnomads.model.Article, java.util.List, java.text.SimpleDateFormat" %>
<%
    String        query   = (String)       request.getAttribute("query");
    List<Article> results = (List<Article>) request.getAttribute("results");
    if (query == null) query = "";

    int count = results != null ? results.size() : 0;
    boolean hasResults = count > 0;
    boolean searched = !query.isBlank();

    SimpleDateFormat fmt = new SimpleDateFormat("MMM d, yyyy");
    String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Search<%= searched ? ": \"" + query + "\"" : "" %> — Thoughts of Nomads</title>
    <link href="https://fonts.googleapis.com/css2?family=Epilogue:wght@400;600;700&family=Work+Sans:wght@400;600&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
    <style>
        :root {
            --primary: #0e193e; --primary-container: #242e54; --on-primary: #ffffff;
            --secondary: #a23d30; --surface: #f8f9fa; --surface-container-lowest: #ffffff;
            --surface-container: #edeeef; --surface-variant: #e1e3e4;
            --on-surface: #191c1d; --on-surface-variant: #45464e;
            --background: #f8f9fa; --outline: #76767f; --outline-variant: #c6c5cf;
            --container-max: 1280px; --margin-desktop: 48px; --margin-mobile: 16px;
            --radius: 4px; --radius-xl: 12px;
        }
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Work Sans', sans-serif; background-color: var(--background); color: var(--on-surface); line-height: 1.5; -webkit-font-smoothing: antialiased; }
        a { text-decoration: none; color: inherit; }
        img { max-width: 100%; display: block; }
        .material-symbols-outlined { font-variation-settings: 'FILL' 0,'wght' 400,'GRAD' 0,'opsz' 24; vertical-align: middle; }

        .search-layout { display: flex; flex-direction: column; min-height: 100vh; }
        .search-main { flex-grow: 1; }

        .search-container { max-width: var(--container-max); margin: 0 auto; padding: 0 var(--margin-mobile); }
        @media (min-width: 768px) { .search-container { padding: 0 var(--margin-desktop); } }

        .search-header-section { background: var(--surface-container-lowest); padding: 32px 0 24px; border-bottom: 1px solid var(--surface-variant); }
        .breadcrumbs { display: flex; align-items: center; gap: 8px; font-size: 12px; color: var(--on-surface-variant); margin-bottom: 24px; }
        .breadcrumbs a:hover { color: var(--primary); text-decoration: underline; }
        .breadcrumb-icon { font-size: 14px; }
        .search-headline { margin-bottom: 24px; }
        .search-title { font-family: 'Epilogue', sans-serif; font-size: 32px; font-weight: 600; margin-bottom: 8px; }
        .search-subtitle { font-size: 15px; color: var(--on-surface-variant); }

        .search-refiner-bar { display: flex; background: var(--surface); border: 1px solid var(--surface-variant); border-radius: var(--radius); padding: 12px; }
        .search-form { position: relative; width: 100%; }
        .search-input-icon { position: absolute; left: 12px; top: 50%; transform: translateY(-50%); color: var(--on-surface-variant); font-size: 20px; }
        .search-input { width: 100%; padding: 12px 12px 12px 40px; background: var(--surface-container-lowest); border: 1px solid var(--outline-variant); border-radius: var(--radius); font-family: inherit; font-size: 14px; color: var(--on-surface); outline: none; transition: border-color 0.2s; }
        .search-input:focus { border-color: var(--primary); }
        .search-btn { padding: 11px 20px; background: var(--primary); color: var(--on-primary); border: none; border-radius: var(--radius); font-weight: 600; font-size: 13px; cursor: pointer; margin-left: 8px; white-space: nowrap; }
        .search-btn:hover { background: var(--primary-container); }

        .search-results-section { padding: 40px 0; }

        .article-grid { display: grid; grid-template-columns: 1fr; gap: 24px; }
        @media (min-width: 768px) { .article-grid { grid-template-columns: repeat(3, 1fr); } }

        .article-card { border: 1px solid var(--surface-variant); border-radius: var(--radius); background: var(--surface-container-lowest); transition: box-shadow 0.3s; display: flex; flex-direction: column; overflow: hidden; }
        .article-card:hover { box-shadow: 0 10px 25px rgba(0,0,0,0.1); }
        .card-image-wrapper { width: 100%; height: 200px; overflow: hidden; background: #e0e2e8; }
        .card-image { width: 100%; height: 100%; object-fit: cover; transition: transform 0.5s; }
        .article-card:hover .card-image { transform: scale(1.05); }
        .card-no-img { width: 100%; height: 100%; display: flex; align-items: center; justify-content: center; color: #9b9ea4; font-size: 36px; }
        .card-tag-overlay { position: absolute; top: 12px; left: 12px; background: rgba(255,255,255,0.95); padding: 4px 8px; border-radius: var(--radius); font-size: 10px; font-weight: 600; text-transform: uppercase; color: var(--on-surface); }
        .card-content { padding: 24px; display: flex; flex-direction: column; flex-grow: 1; }
        .card-title { font-family: 'Epilogue', sans-serif; font-size: 18px; font-weight: 600; margin-bottom: 8px; line-height: 1.3; }
        .card-meta { margin-top: auto; padding-top: 12px; font-size: 12px; color: var(--outline); }

        /* Empty state */
        .empty-state-wrapper { display: flex; justify-content: center; margin-bottom: 56px; }
        .empty-card { background: var(--surface-container-lowest); border: 1px solid var(--surface-variant); border-radius: var(--radius-xl); padding: 48px; max-width: 480px; text-align: center; display: flex; flex-direction: column; align-items: center; }
        .empty-icon-wrapper { background: var(--surface-container); width: 64px; height: 64px; border-radius: 50%; display: flex; align-items: center; justify-content: center; color: var(--on-surface-variant); margin-bottom: 20px; }
        .empty-title { font-family: 'Epilogue', sans-serif; font-size: 22px; font-weight: 600; margin-bottom: 10px; }
        .empty-subtitle { color: var(--on-surface-variant); margin-bottom: 24px; font-size: 14px; line-height: 1.55; }
        .btn-solid { background: var(--primary); color: var(--on-primary); border: none; padding: 12px 24px; border-radius: var(--radius); font-weight: 600; text-transform: uppercase; font-size: 12px; letter-spacing: 0.1em; display: inline-flex; align-items: center; gap: 8px; }
        .btn-solid:hover { background: var(--primary-container); }
    </style>
</head>
<body class="search-layout">
    <jsp:include page="/WEB-INF/views/includes/header.jsp"/>

    <main class="search-main">
        <section class="search-header-section">
            <div class="search-container">
                <nav class="breadcrumbs">
                    <a href="<%= cp %>/">Home</a>
                    <span class="material-symbols-outlined breadcrumb-icon">chevron_right</span>
                    <span>Search</span>
                </nav>

                <div class="search-headline">
                    <% if (searched) { %>
                    <h1 class="search-title">Results for: "<%= query %>"</h1>
                    <p class="search-subtitle"><%= count %> <%= count == 1 ? "story" : "stories" %> found</p>
                    <% } else { %>
                    <h1 class="search-title">Search</h1>
                    <p class="search-subtitle">Find stories, destinations, and journeys</p>
                    <% } %>
                </div>

                <form action="<%= cp %>/search" method="GET" class="search-refiner-bar">
                    <div class="search-form">
                        <span class="material-symbols-outlined search-input-icon">search</span>
                        <input name="q" class="search-input" placeholder="Search journeys, destinations..." type="text" value="<%= query %>"/>
                    </div>
                    <button type="submit" class="search-btn">Search</button>
                </form>
            </div>
        </section>

        <section class="search-results-section">
            <div class="search-container">
                <% if (!searched) { %>
                <div class="empty-state-wrapper">
                    <div class="empty-card">
                        <div class="empty-icon-wrapper">
                            <span class="material-symbols-outlined" style="font-size:28px;">travel_explore</span>
                        </div>
                        <h2 class="empty-title">Start Exploring</h2>
                        <p class="empty-subtitle">Enter a destination, topic, or keyword above to find stories from around the world.</p>
                        <a href="<%= cp %>/latest" class="btn-solid">
                            <span class="material-symbols-outlined" style="font-size:16px;">auto_stories</span>
                            Browse All Stories
                        </a>
                    </div>
                </div>
                <% } else if (!hasResults) { %>
                <div class="empty-state-wrapper">
                    <div class="empty-card">
                        <div class="empty-icon-wrapper">
                            <span class="material-symbols-outlined" style="font-size:28px;">location_off</span>
                        </div>
                        <h2 class="empty-title">Journey Not Found</h2>
                        <p class="empty-subtitle">No stories match "<%= query %>". Try a different keyword or explore all our journeys.</p>
                        <a href="<%= cp %>/latest" class="btn-solid">
                            <span class="material-symbols-outlined" style="font-size:16px;">home</span>
                            Browse Latest
                        </a>
                    </div>
                </div>
                <% } else { %>
                <div class="article-grid">
                    <% for (Article a : results) { %>
                    <a href="<%= cp %>/article?id=<%= a.getArticleId() %>" class="article-card">
                        <div class="card-image-wrapper" style="position:relative;">
                            <% if (a.getCoverImage() != null) { %>
                            <img class="card-image" src="<%= cp %>/<%= a.getCoverImage() %>" alt=""/>
                            <% } else { %>
                            <div class="card-no-img"><span class="material-symbols-outlined">article</span></div>
                            <% } %>
                            <% if (a.getCategoryName() != null) { %>
                            <div class="card-tag-overlay"><%= a.getCategoryName() %></div>
                            <% } %>
                        </div>
                        <div class="card-content">
                            <h2 class="card-title"><%= a.getTitle() %></h2>
                            <p class="card-meta">
                                <%= a.getAuthorName() != null ? a.getAuthorName() : "" %>
                                <% if (a.getPublishedAt() != null) { %> · <%= fmt.format(a.getPublishedAt()) %><% } %>
                                · <%= a.getReadTimeMinutes() %> min read
                            </p>
                        </div>
                    </a>
                    <% } %>
                </div>
                <% } %>
            </div>
        </section>
    </main>

    <jsp:include page="/WEB-INF/views/includes/footer.jsp"/>
</body>
</html>
