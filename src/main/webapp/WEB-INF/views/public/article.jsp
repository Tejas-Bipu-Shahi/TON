<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.thoughtsofnomads.model.Article, com.thoughtsofnomads.model.Tag,
                 java.util.List, java.text.SimpleDateFormat" %>
<%
    Article article = (Article) request.getAttribute("article");
    List<Article> related = (List<Article>) request.getAttribute("related");
    SimpleDateFormat fmt = new SimpleDateFormat("MMM d, yyyy");
    String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title><%= article.getTitle() %> — Thoughts of Nomads</title>
    <link href="https://fonts.googleapis.com/css2?family=Epilogue:wght@400;600;700&family=Work+Sans:wght@400;600&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
    <style>
        :root {
            --primary: #0e193e; --primary-container: #242e54; --on-primary: #ffffff;
            --surface: #ffffff; --surface-container-lowest: #ffffff;
            --surface-container: #f8f9fa; --surface-variant: #e1e3e4;
            --on-surface: #191c1d; --on-surface-variant: #45464e;
            --background: #f8f9fa; --outline: #76767f; --outline-variant: #c6c5cf;
            --accent-orange: #a26b1c; --container-max: 1280px;
            --margin-desktop: 48px; --margin-mobile: 16px; --radius: 4px;
        }
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Work Sans', sans-serif; background-color: var(--background); color: var(--on-surface); line-height: 1.5; -webkit-font-smoothing: antialiased; }
        a { text-decoration: none; color: inherit; }
        img { max-width: 100%; display: block; }
        button { cursor: pointer; font-family: inherit; background: none; border: none; }
        .material-symbols-outlined { font-variation-settings: 'FILL' 0,'wght' 400,'GRAD' 0,'opsz' 24; vertical-align: middle; }

        .reading-progress-bar { position: fixed; top: 0; left: 0; height: 4px; background-color: #d18900; width: 0; z-index: 1000; transition: width 0.1s; }

        .article-layout { display: flex; flex-direction: column; min-height: 100vh; }
        .article-main { flex-grow: 1; max-width: var(--container-max); margin: 0 auto; width: 100%; padding: 48px var(--margin-mobile); }
        @media (min-width: 768px) { .article-main { padding: 48px var(--margin-desktop); } }

        .article-grid { display: grid; grid-template-columns: 1fr; gap: 48px; }
        @media (min-width: 1024px) { .article-grid { grid-template-columns: 2fr 1fr; } }

        .article-body { display: flex; flex-direction: column; width: 100%; }

        .article-hero { position: relative; border-radius: var(--radius); overflow: hidden; margin-bottom: 24px; background: #1a1a2e; }
        .article-hero-img { width: 100%; height: auto; aspect-ratio: 16/9; object-fit: cover; }
        .article-hero-overlay { position: absolute; inset: 0; background: linear-gradient(to top, rgba(0,0,0,0.8) 0%, rgba(0,0,0,0) 60%); display: flex; flex-direction: column; justify-content: flex-end; padding: 32px; }
        @media (max-width: 767px) { .article-hero-overlay { padding: 16px; } }
        .article-hero-tag { font-family: 'Work Sans', sans-serif; font-size: 10px; font-weight: 700; background-color: rgba(255,255,255,0.9); color: var(--primary); padding: 4px 12px; border-radius: var(--radius); display: inline-block; text-transform: uppercase; letter-spacing: 0.1em; align-self: flex-start; margin-bottom: 16px; }
        .article-hero-title { font-family: 'Epilogue', sans-serif; font-size: 36px; font-weight: 700; color: #fff; line-height: 1.2; margin: 0; }
        @media (max-width: 767px) { .article-hero-title { font-size: 24px; } }

        .article-title-plain { font-family: 'Epilogue', sans-serif; font-size: 32px; font-weight: 700; color: var(--on-surface); line-height: 1.25; margin-bottom: 24px; }

        .article-meta { display: flex; align-items: center; gap: 16px; margin-bottom: 40px; padding-bottom: 24px; border-bottom: 1px solid var(--surface-variant); }
        .article-meta-avatar-init { width: 48px; height: 48px; border-radius: 50%; background: #00695c; display: flex; align-items: center; justify-content: center; font-family: 'Epilogue', sans-serif; font-size: 18px; font-weight: 700; color: #fff; flex-shrink: 0; overflow: hidden; }
        .article-meta-avatar-init img { width: 100%; height: 100%; object-fit: cover; }
        .article-meta-info { display: flex; flex-direction: column; }
        .article-author-name { font-size: 14px; font-weight: 600; color: var(--on-surface); margin-bottom: 4px; }
        .article-meta-details { display: flex; align-items: center; font-size: 12px; color: var(--on-surface-variant); gap: 8px; }
        .meta-dot { width: 4px; height: 4px; background-color: var(--outline-variant); border-radius: 50%; }

        .article-content { font-size: 16px; color: var(--on-surface-variant); line-height: 1.8; }
        .article-content p { margin-bottom: 24px; }
        .article-content h1, .article-content h2 { font-family: 'Epilogue', sans-serif; font-size: 24px; font-weight: 600; color: var(--on-surface); margin: 40px 0 16px; }
        .article-content h3 { font-family: 'Epilogue', sans-serif; font-size: 20px; font-weight: 600; color: var(--on-surface); margin: 32px 0 12px; }
        .article-content blockquote { border-left: 4px solid #d18900; padding-left: 24px; margin: 32px 0; font-family: 'Epilogue', sans-serif; font-size: 20px; font-style: italic; color: var(--on-surface); }
        .article-content pre { background: #1e2030; color: #c0caf5; border-radius: 6px; padding: 16px; overflow-x: auto; margin-bottom: 24px; }
        .article-content ul, .article-content ol { margin: 0 0 24px 24px; }
        .article-content li { margin-bottom: 8px; }
        .article-content img { max-width: 100%; border-radius: var(--radius); margin: 24px 0; border: 1px solid var(--surface-variant); }

        .article-author-box { margin-top: 48px; padding: 24px; background-color: var(--surface-container-lowest); border: 1px solid var(--surface-variant); border-radius: var(--radius); display: flex; flex-direction: column; gap: 16px; }
        @media (min-width: 640px) { .article-author-box { flex-direction: row; align-items: flex-start; } }
        .author-box-avatar { width: 64px; height: 64px; border-radius: 8px; background: #0e193e; display: flex; align-items: center; justify-content: center; font-family: 'Epilogue', sans-serif; font-size: 22px; font-weight: 700; color: #fff; flex-shrink: 0; overflow: hidden; }
        .author-box-avatar img { width: 100%; height: 100%; object-fit: cover; }
        .author-box-info { display: flex; flex-direction: column; }
        .author-box-name { font-family: 'Epilogue', sans-serif; font-size: 18px; font-weight: 600; color: var(--on-surface); margin-bottom: 8px; }
        .author-box-bio { font-size: 14px; color: var(--on-surface-variant); line-height: 1.6; }

        .article-tags { display: flex; flex-wrap: wrap; gap: 8px; margin-top: 24px; }
        .article-tag { padding: 6px 12px; background-color: var(--surface-variant); color: var(--on-surface-variant); font-size: 11px; font-weight: 600; border-radius: var(--radius); text-transform: uppercase; letter-spacing: 0.1em; }
        .article-tag:hover { background-color: #d0d2d8; }

        .sidebar-sticky { position: sticky; top: 100px; display: flex; flex-direction: column; gap: 24px; }
        .sidebar-widget { background-color: var(--surface-container-lowest); padding: 24px; border: 1px solid var(--surface-variant); border-radius: var(--radius); }
        .sidebar-search { position: relative; }
        .sidebar-search-icon { position: absolute; left: 12px; top: 50%; transform: translateY(-50%); color: var(--outline); font-size: 20px; }
        .sidebar-search-input { width: 100%; background-color: var(--surface-container-lowest); border: 1px solid var(--outline-variant); border-radius: var(--radius); padding: 10px 12px 10px 40px; font-size: 14px; color: var(--on-surface); outline: none; font-family: inherit; }
        .sidebar-search-input:focus { border-color: var(--primary-container); }
        .sidebar-newsletter { background-color: var(--primary-container); color: var(--on-primary); padding: 32px; border-radius: var(--radius); text-align: center; }
        .sidebar-newsletter-icon { font-size: 32px; color: #f5a623; margin-bottom: 16px; }
        .sidebar-newsletter-title { font-family: 'Epilogue', sans-serif; font-size: 20px; font-weight: 600; margin-bottom: 12px; }
        .sidebar-newsletter-desc { font-size: 14px; color: #dce1ff; margin-bottom: 24px; line-height: 1.5; }
        .sidebar-newsletter-input { width: 100%; background-color: rgba(255,255,255,0.1); border: 1px solid rgba(255,255,255,0.2); border-radius: var(--radius); padding: 12px; margin-bottom: 12px; color: var(--on-primary); outline: none; font-size: 14px; font-family: inherit; }
        .sidebar-newsletter-input::placeholder { color: rgba(255,255,255,0.6); }
        .sidebar-newsletter-btn { width: 100%; background-color: #fff; color: var(--primary-container); font-size: 12px; font-weight: 700; text-transform: uppercase; letter-spacing: 0.1em; padding: 12px; border: none; border-radius: var(--radius); cursor: pointer; }
        .sidebar-newsletter-btn:hover { background-color: var(--surface-variant); }

        .related-section { background-color: var(--surface-container); padding: 64px 16px; border-top: 1px solid var(--surface-variant); }
        .related-container { max-width: var(--container-max); margin: 0 auto; }
        @media (min-width: 768px) { .related-section { padding: 64px 48px; } }
        .related-title { font-family: 'Epilogue', sans-serif; font-size: 24px; font-weight: 600; color: var(--on-surface); margin-bottom: 32px; }
        .related-grid { display: grid; grid-template-columns: 1fr; gap: 24px; }
        @media (min-width: 768px) { .related-grid { grid-template-columns: repeat(3, 1fr); } }

        .standard-card { background-color: var(--surface-container-lowest); border-radius: var(--radius); border: 1px solid var(--surface-variant); overflow: hidden; display: flex; flex-direction: column; transition: box-shadow 0.3s; }
        .standard-card:hover { box-shadow: 0 4px 20px rgba(36,46,84,0.08); }
        .card-img-wrapper { height: 200px; overflow: hidden; background: #e0e2e8; }
        .card-img { width: 100%; height: 100%; object-fit: cover; transition: transform 0.5s; }
        .standard-card:hover .card-img { transform: scale(1.05); }
        .card-no-img { width: 100%; height: 100%; display: flex; align-items: center; justify-content: center; color: #9b9ea4; font-size: 36px; }
        .card-content { padding: 24px; display: flex; flex-direction: column; flex-grow: 1; }
        .card-category-tag { font-size: 10px; font-weight: 700; color: var(--accent-orange); text-transform: uppercase; letter-spacing: 0.1em; margin-bottom: 12px; }
        .card-title { font-family: 'Epilogue', sans-serif; font-size: 18px; font-weight: 600; color: var(--on-surface); margin-bottom: 12px; line-height: 1.3; }
        .card-meta { font-size: 11px; color: var(--on-surface-variant); margin-top: auto; padding-top: 12px; border-top: 1px solid var(--surface-variant); }
    </style>
</head>
<body class="article-layout">

    <div class="reading-progress-bar" id="progressBar"></div>

    <jsp:include page="/WEB-INF/views/includes/header.jsp"/>

    <main class="article-main">
        <div class="article-grid">

            <!-- Article Body -->
            <article class="article-body">

                <% if (article.getCoverImage() != null) { %>
                <div class="article-hero">
                    <img class="article-hero-img" src="<%= cp %>/<%= article.getCoverImage() %>" alt="Cover"/>
                    <div class="article-hero-overlay">
                        <% if (article.getCategoryName() != null) { %>
                        <span class="article-hero-tag"><%= article.getCategoryName() %></span>
                        <% } %>
                        <h1 class="article-hero-title"><%= article.getTitle() %></h1>
                    </div>
                </div>
                <% } else { %>
                <h1 class="article-title-plain"><%= article.getTitle() %></h1>
                <% } %>

                <div class="article-meta">
                    <%
                        String authorName = article.getAuthorName() != null ? article.getAuthorName() : "Author";
                        String initial = String.valueOf(authorName.charAt(0)).toUpperCase();
                        String profilePic = article.getAuthorProfilePicture();
                    %>
                    <div class="article-meta-avatar-init">
                        <% if (profilePic != null && !profilePic.isBlank()) { %>
                            <img src="<%= cp %>/<%= profilePic %>" alt="<%= authorName %>"/>
                        <% } else { %><%= initial %><% } %>
                    </div>
                    <div class="article-meta-info">
                        <span class="article-author-name"><%= authorName %></span>
                        <div class="article-meta-details">
                            <% if (article.getPublishedAt() != null) { %>
                            <span><%= fmt.format(article.getPublishedAt()) %></span>
                            <span class="meta-dot"></span>
                            <% } %>
                            <span><%= article.getReadTimeMinutes() %> min read</span>
                        </div>
                    </div>
                </div>

                <div class="article-content">
                    <%= article.getContent() %>
                </div>

                <% if (article.getAuthorName() != null) { %>
                <div class="article-author-box">
                    <div class="author-box-avatar">
                        <% if (profilePic != null && !profilePic.isBlank()) { %>
                            <img src="<%= cp %>/<%= profilePic %>" alt="<%= authorName %>"/>
                        <% } else { %><%= initial %><% } %>
                    </div>
                    <div class="author-box-info">
                        <h3 class="author-box-name"><%= authorName %></h3>
                        <% if (article.getAuthorBio() != null && !article.getAuthorBio().isBlank()) { %>
                        <p class="author-box-bio"><%= article.getAuthorBio() %></p>
                        <% } else { %>
                        <p class="author-box-bio">Contributor at Thoughts of Nomads.</p>
                        <% } %>
                    </div>
                </div>
                <% } %>

                <% if (!article.getTags().isEmpty()) { %>
                <div class="article-tags">
                    <% for (Tag tag : article.getTags()) { %>
                    <a href="<%= cp %>/search?q=<%= tag.getName() %>" class="article-tag">#<%= tag.getName() %></a>
                    <% } %>
                </div>
                <% } %>
            </article>

            <!-- Sidebar -->
            <aside>
                <div class="sidebar-sticky">
                    <div class="sidebar-widget">
                        <form method="get" action="<%= cp %>/search" class="sidebar-search">
                            <span class="material-symbols-outlined sidebar-search-icon">search</span>
                            <input class="sidebar-search-input" name="q" placeholder="Search stories..." type="text"/>
                        </form>
                    </div>
                    <div class="sidebar-newsletter">
                        <span class="material-symbols-outlined sidebar-newsletter-icon">mail</span>
                        <h4 class="sidebar-newsletter-title">Join the Tribe</h4>
                        <p class="sidebar-newsletter-desc">Get editorial dispatches from the world's remote corners.</p>
                        <input class="sidebar-newsletter-input" id="sidebarNLEmail" placeholder="Your email address" type="email"/>
                        <button class="sidebar-newsletter-btn" id="sidebarNLBtn">Subscribe</button>
                        <p id="sidebarNLMsg" style="display:none;margin-top:10px;font-size:12px;font-weight:600;"></p>
                    </div>
                </div>
            </aside>
        </div>
    </main>

    <% if (related != null && !related.isEmpty()) { %>
    <section class="related-section">
        <div class="related-container">
            <h3 class="related-title">More from <%= article.getCategoryName() != null ? article.getCategoryName() : "Us" %></h3>
            <div class="related-grid">
                <% for (Article r : related) { %>
                <a href="<%= cp %>/article?id=<%= r.getArticleId() %>" class="standard-card">
                    <div class="card-img-wrapper">
                        <% if (r.getCoverImage() != null) { %>
                        <img class="card-img" src="<%= cp %>/<%= r.getCoverImage() %>" alt=""/>
                        <% } else { %>
                        <div class="card-no-img"><span class="material-symbols-outlined">article</span></div>
                        <% } %>
                    </div>
                    <div class="card-content">
                        <% if (r.getCategoryName() != null) { %>
                        <span class="card-category-tag"><%= r.getCategoryName() %></span>
                        <% } %>
                        <h4 class="card-title"><%= r.getTitle() %></h4>
                        <span class="card-meta">
                            <%= r.getAuthorName() != null ? r.getAuthorName() : "" %>
                            <% if (r.getPublishedAt() != null) { %> · <%= fmt.format(r.getPublishedAt()) %><% } %>
                        </span>
                    </div>
                </a>
                <% } %>
            </div>
        </div>
    </section>
    <% } %>

    <jsp:include page="/WEB-INF/views/includes/footer.jsp"/>

    <script>
    window.addEventListener('scroll', function() {
        const doc = document.documentElement;
        const scrolled = doc.scrollTop;
        const total = doc.scrollHeight - doc.clientHeight;
        document.getElementById('progressBar').style.width = (total > 0 ? (scrolled / total * 100) : 0) + '%';
    });
    (function() {
        var btn   = document.getElementById('sidebarNLBtn');
        var input = document.getElementById('sidebarNLEmail');
        var msg   = document.getElementById('sidebarNLMsg');
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
