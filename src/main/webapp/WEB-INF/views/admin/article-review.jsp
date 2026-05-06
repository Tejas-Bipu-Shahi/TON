<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.thoughtsofnomads.model.User, com.thoughtsofnomads.model.Article,
                 java.text.SimpleDateFormat" %>
<%
    User    user        = (User)    session.getAttribute("user");
    Article article     = (Article) request.getAttribute("article");
    String  errorMsg    = (String)  request.getAttribute("errorMsg");
    String  userInitial = (user != null && user.getEmail() != null)
        ? String.valueOf(user.getEmail().charAt(0)).toUpperCase() : "A";

    SimpleDateFormat fmt = new SimpleDateFormat("MMM d, yyyy 'at' h:mm a");
    String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Review Article — Admin | Thoughts of Nomads</title>
    <link href="https://fonts.googleapis.com/css2?family=Epilogue:wght@400;600;700&family=Work+Sans:wght@400;500;600&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" rel="stylesheet"/>
    <style>
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
    body { font-family: 'Work Sans', sans-serif; background-color: #f0f2f5; color: #191c1d; -webkit-font-smoothing: antialiased; }
    a { text-decoration: none; color: inherit; }
    button { cursor: pointer; font-family: inherit; }
    .material-symbols-outlined { font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24; vertical-align: middle; }

    .admin-shell { display: flex; min-height: 100vh; }
    .admin-content { flex: 1; display: flex; flex-direction: column; min-width: 0; }

    .admin-topbar {
        background: #fff; border-bottom: 1px solid #e1e3e4;
        height: 68px; display: flex; align-items: center;
        justify-content: space-between; padding: 0 36px;
        position: sticky; top: 0; z-index: 10; flex-shrink: 0;
    }
    .topbar-left { display: flex; align-items: center; gap: 16px; }
    .topbar-back {
        display: inline-flex; align-items: center; gap: 6px;
        padding: 7px 14px; border-radius: 6px;
        border: 1px solid #e1e3e4; background: #f8f9fa;
        font-size: 12px; font-weight: 600; color: #45464e;
        text-transform: uppercase; letter-spacing: 0.07em;
        transition: background-color 0.15s, color 0.15s, border-color 0.15s;
    }
    .topbar-back:hover { background: #0e193e; color: #fff; border-color: #0e193e; }
    .topbar-back .material-symbols-outlined { font-size: 15px; }
    .topbar-title { font-family: 'Epilogue', sans-serif; font-size: 18px; font-weight: 700; color: #0e193e; }
    .topbar-profile { display: flex; align-items: center; gap: 12px; }
    .topbar-profile-name { font-size: 14px; font-weight: 600; color: #0e193e; }
    .topbar-profile-role { font-size: 11px; color: #76767f; text-transform: uppercase; letter-spacing: 0.09em; }
    .topbar-avatar { width: 38px; height: 38px; border-radius: 50%; background-color: #242e54; display: flex; align-items: center; justify-content: center; color: #fff; font-weight: 700; font-size: 14px; flex-shrink: 0; font-family: 'Epilogue', sans-serif; }

    .admin-main { flex: 1; padding: 36px; }

    .review-layout {
        display: grid;
        grid-template-columns: 1fr 320px;
        gap: 24px;
        align-items: start;
    }
    @media (max-width: 960px) { .review-layout { grid-template-columns: 1fr; } }

    /* Article preview */
    .article-card {
        background: #fff; border: 1px solid #e1e3e4; border-radius: 10px; overflow: hidden;
    }
    .article-meta-bar {
        padding: 20px 28px;
        border-bottom: 1px solid #f0f1f3;
        display: flex; flex-wrap: wrap; gap: 12px; align-items: center;
    }
    .meta-chip {
        display: inline-flex; align-items: center; gap: 5px;
        padding: 4px 12px; border-radius: 20px;
        background: #f0f2f5; font-size: 12px; font-weight: 600; color: #45464e;
    }
    .meta-chip .material-symbols-outlined { font-size: 14px; color: #76767f; }

    .badge {
        display: inline-flex; align-items: center; gap: 5px;
        padding: 3px 10px; border-radius: 20px;
        font-size: 11.5px; font-weight: 600;
    }
    .badge-dot { width: 6px; height: 6px; border-radius: 50%; flex-shrink: 0; }
    .badge-pending   { background: #fff8e1; color: #e65100; }
    .badge-pending .badge-dot   { background: #e65100; }
    .badge-published { background: #e8f5e9; color: #2e7d32; }
    .badge-published .badge-dot { background: #2e7d32; }
    .badge-rejected  { background: #fce4ec; color: #c62828; }
    .badge-rejected .badge-dot  { background: #c62828; }
    .badge-draft     { background: #f3f4f6; color: #5a5d63; }
    .badge-draft .badge-dot     { background: #9b9ea4; }

    .cover-image-wrap img { width: 100%; max-height: 360px; object-fit: cover; display: block; }

    .article-body { padding: 32px 36px; }
    .article-title-heading {
        font-family: 'Epilogue', sans-serif;
        font-size: 32px; font-weight: 700; color: #0e193e;
        line-height: 1.25; margin-bottom: 24px;
    }
    .article-content {
        font-size: 16px; line-height: 1.8; color: #2d2f31;
    }
    .article-content h1, .article-content h2, .article-content h3 {
        font-family: 'Epilogue', sans-serif; color: #0e193e;
        margin-top: 24px; margin-bottom: 10px;
    }
    .article-content p { margin-bottom: 16px; }
    .article-content ul, .article-content ol { margin: 0 0 16px 24px; }
    .article-content li { margin-bottom: 6px; }
    .article-content blockquote {
        border-left: 4px solid #0e193e; margin: 16px 0;
        padding: 10px 18px; background: #f8f9fa;
        color: #5a5d63; font-style: italic;
    }
    .article-content pre {
        background: #1e2030; color: #c0caf5;
        border-radius: 6px; padding: 16px; overflow-x: auto;
        font-size: 13.5px; margin-bottom: 16px;
    }
    .article-content img { max-width: 100%; border-radius: 6px; margin: 8px 0; }

    /* Action panel */
    .action-panel { display: flex; flex-direction: column; gap: 16px; }

    .panel-card {
        background: #fff; border: 1px solid #e1e3e4; border-radius: 10px; overflow: hidden;
    }
    .panel-header {
        padding: 13px 18px; border-bottom: 1px solid #f0f1f3;
        font-size: 11px; font-weight: 700; letter-spacing: 0.1em;
        text-transform: uppercase; color: #45464e;
        display: flex; align-items: center; gap: 7px;
    }
    .panel-header .material-symbols-outlined { font-size: 16px; color: #76767f; }
    .panel-body { padding: 16px 18px; }

    /* Info list */
    .info-row { display: flex; flex-direction: column; gap: 3px; padding: 9px 0; border-bottom: 1px solid #f0f2f5; }
    .info-row:last-child { border-bottom: none; }
    .info-label { font-size: 10.5px; font-weight: 700; color: #9b9ea4; text-transform: uppercase; letter-spacing: 0.08em; }
    .info-value { font-size: 13px; color: #2d2f31; font-weight: 500; }

    /* Error */
    .error-banner {
        background: #fce4ec; border: 1px solid #f48fb1; border-radius: 8px;
        padding: 11px 15px; display: flex; align-items: center; gap: 9px;
        font-size: 13px; color: #c62828; margin-bottom: 14px;
    }
    .error-banner .material-symbols-outlined { font-size: 18px; flex-shrink: 0; }

    /* Buttons */
    .btn-publish {
        display: flex; align-items: center; justify-content: center; gap: 7px;
        width: 100%; padding: 11px 16px; border-radius: 8px;
        border: none; background: #2e7d32; color: #fff;
        font-size: 13px; font-weight: 600;
        transition: background-color 0.15s;
    }
    .btn-publish:hover { background: #1b5e20; }

    .btn-reject {
        display: flex; align-items: center; justify-content: center; gap: 7px;
        width: 100%; padding: 11px 16px; border-radius: 8px;
        border: 1.5px solid #e53935; background: #fff; color: #c62828;
        font-size: 13px; font-weight: 600;
        transition: background-color 0.15s, color 0.15s;
    }
    .btn-reject:hover { background: #fce4ec; }
    .btn-reject .material-symbols-outlined, .btn-publish .material-symbols-outlined { font-size: 17px; }

    textarea.note-field {
        width: 100%; padding: 10px 12px; border-radius: 8px;
        border: 1px solid #d0d2d8; font-family: 'Work Sans', sans-serif;
        font-size: 13px; color: #191c1d; resize: vertical; min-height: 90px;
        outline: none; transition: border-color 0.15s; margin-bottom: 10px;
    }
    textarea.note-field:focus { border-color: #0e193e; }

    .reject-section { display: none; }
    .reject-section.open { display: block; }

    .btn-toggle-reject {
        display: flex; align-items: center; justify-content: center; gap: 7px;
        width: 100%; padding: 11px 16px; border-radius: 8px;
        border: 1.5px solid #e53935; background: #fff; color: #c62828;
        font-size: 13px; font-weight: 600;
        transition: background-color 0.15s;
    }
    .btn-toggle-reject:hover { background: #fce4ec; }
    .btn-toggle-reject .material-symbols-outlined { font-size: 17px; }

    .note-label { font-size: 11.5px; font-weight: 600; color: #45464e; margin-bottom: 6px; display: block; }
    .note-hint  { font-size: 11px; color: #9b9ea4; margin-bottom: 10px; }
    </style>
</head>
<body>
<div class="admin-shell">

    <jsp:include page="/WEB-INF/views/admin/includes/sidebar.jsp"/>

    <div class="admin-content">

        <header class="admin-topbar">
            <div class="topbar-left">
                <a href="<%= cp %>/admin/articles" class="topbar-back">
                    <span class="material-symbols-outlined">arrow_back</span>
                    Back
                </a>
                <span class="topbar-title">Review Article</span>
            </div>
            <div class="topbar-profile">
                <div>
                    <div class="topbar-profile-name">System Admin</div>
                    <div class="topbar-profile-role" style="text-align:right;">Administrator</div>
                </div>
                <div class="topbar-avatar"><%= userInitial %></div>
            </div>
        </header>

        <main class="admin-main">
            <div class="review-layout">

                <!-- Article preview -->
                <div class="article-card">
                    <div class="article-meta-bar">
                        <span class="badge badge-<%= article.getStatus().toLowerCase() %>">
                            <span class="badge-dot"></span>
                            <%= article.getStatusLabel() %>
                        </span>
                        <% if (article.getAuthorName() != null) { %>
                        <span class="meta-chip">
                            <span class="material-symbols-outlined">person</span>
                            <%= article.getAuthorName() %>
                        </span>
                        <% } %>
                        <% if (article.getCategoryName() != null) { %>
                        <span class="meta-chip">
                            <span class="material-symbols-outlined">folder_open</span>
                            <%= article.getCategoryName() %>
                        </span>
                        <% } %>
                        <% if (article.getUpdatedAt() != null) { %>
                        <span class="meta-chip" style="color:#76767f;">
                            <span class="material-symbols-outlined">schedule</span>
                            <%= fmt.format(article.getUpdatedAt()) %>
                        </span>
                        <% } %>
                    </div>

                    <% if (article.getCoverImage() != null) { %>
                    <div class="cover-image-wrap">
                        <img src="<%= cp %>/<%= article.getCoverImage() %>" alt="Cover"/>
                    </div>
                    <% } %>

                    <div class="article-body">
                        <h1 class="article-title-heading"><%= article.getTitle() %></h1>
                        <div class="article-content">
                            <%= article.getContent() %>
                        </div>
                    </div>
                </div>

                <!-- Action Panel -->
                <aside class="action-panel">

                    <!-- Info -->
                    <div class="panel-card">
                        <div class="panel-header">
                            <span class="material-symbols-outlined">info</span>
                            Article Info
                        </div>
                        <div class="panel-body">
                            <div class="info-row">
                                <span class="info-label">Author</span>
                                <span class="info-value"><%= article.getAuthorName() != null ? article.getAuthorName() : "—" %></span>
                            </div>
                            <div class="info-row">
                                <span class="info-label">Category</span>
                                <span class="info-value"><%= article.getCategoryName() != null ? article.getCategoryName() : "—" %></span>
                            </div>
                            <div class="info-row">
                                <span class="info-label">Submitted</span>
                                <span class="info-value"><%= article.getUpdatedAt() != null ? fmt.format(article.getUpdatedAt()) : "—" %></span>
                            </div>
                            <div class="info-row">
                                <span class="info-label">Status</span>
                                <span class="info-value"><%= article.getStatusLabel() %></span>
                            </div>
                            <% if (article.getReviewNote() != null) { %>
                            <div class="info-row">
                                <span class="info-label">Previous Note</span>
                                <span class="info-value" style="color:#c62828;"><%= article.getReviewNote() %></span>
                            </div>
                            <% } %>
                        </div>
                    </div>

                    <!-- Decision -->
                    <div class="panel-card">
                        <div class="panel-header">
                            <span class="material-symbols-outlined">gavel</span>
                            Decision
                        </div>
                        <div class="panel-body">

                            <% if (errorMsg != null) { %>
                            <div class="error-banner">
                                <span class="material-symbols-outlined">error</span>
                                <%= errorMsg %>
                            </div>
                            <% } %>

                            <!-- Publish form -->
                            <form method="post" action="<%= cp %>/admin/articles/review" id="publishForm">
                                <input type="hidden" name="articleId" value="<%= article.getArticleId() %>"/>
                                <input type="hidden" name="action" value="publish"/>
                                <button type="submit" class="btn-publish"
                                        onclick="return confirm('Publish this article? It will go live immediately.')">
                                    <span class="material-symbols-outlined">check_circle</span>
                                    Publish Article
                                </button>
                            </form>

                            <div style="margin: 12px 0; text-align:center; font-size:12px; color:#9b9ea4;">or</div>

                            <!-- Reject section -->
                            <button type="button" class="btn-toggle-reject" onclick="toggleReject(this)">
                                <span class="material-symbols-outlined">cancel</span>
                                Reject Article
                            </button>

                            <div class="reject-section" id="rejectSection">
                                <form method="post" action="<%= cp %>/admin/articles/review" style="margin-top:14px;">
                                    <input type="hidden" name="articleId" value="<%= article.getArticleId() %>"/>
                                    <input type="hidden" name="action" value="reject"/>
                                    <label class="note-label">Feedback for contributor <span style="color:#c62828;">*</span></label>
                                    <p class="note-hint">Explain what needs to be changed so the contributor can revise and resubmit.</p>
                                    <textarea name="reviewNote" class="note-field"
                                              placeholder="e.g. The article needs more detail in the introduction and should include at least 3 references…"
                                              required><% if (errorMsg != null) { %><% } %></textarea>
                                    <button type="submit" class="btn-reject">
                                        <span class="material-symbols-outlined">send</span>
                                        Send Rejection
                                    </button>
                                </form>
                            </div>

                        </div>
                    </div>

                </aside>
            </div>
        </main>
    </div>
</div>
<script>
function toggleReject(btn) {
    const section = document.getElementById('rejectSection');
    const isOpen = section.classList.toggle('open');
    btn.style.display = isOpen ? 'none' : 'flex';
    if (isOpen) section.querySelector('textarea').focus();
}
<% if (errorMsg != null) { %>
document.getElementById('rejectSection').classList.add('open');
document.querySelector('.btn-toggle-reject').style.display = 'none';
<% } %>
</script>
</body>
</html>
