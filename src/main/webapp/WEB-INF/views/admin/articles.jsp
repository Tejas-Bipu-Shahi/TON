<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.thoughtsofnomads.model.User, com.thoughtsofnomads.model.Article,
                 java.util.List, java.text.SimpleDateFormat" %>
<%
    User   user         = (User)   session.getAttribute("user");
    String userInitial  = (user != null && user.getEmail() != null)
        ? String.valueOf(user.getEmail().charAt(0)).toUpperCase() : "A";

    List<Article> articles    = (List<Article>) request.getAttribute("articles");
    String        statusFilter = (String) request.getAttribute("statusFilter");
    if (statusFilter == null) statusFilter = "PENDING";

    int cntPending   = (Integer) request.getAttribute("countPending");
    int cntPublished = (Integer) request.getAttribute("countPublished");
    int cntRejected  = (Integer) request.getAttribute("countRejected");
    int cntDraft     = (Integer) request.getAttribute("countDraft");

    String flashSuccess = (String) session.getAttribute("flashSuccess");
    if (flashSuccess != null) session.removeAttribute("flashSuccess");

    SimpleDateFormat fmt = new SimpleDateFormat("MMM d, yyyy");
    String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Articles — Admin | Thoughts of Nomads</title>
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
    .topbar-title { font-family: 'Epilogue', sans-serif; font-size: 20px; font-weight: 700; color: #0e193e; letter-spacing: -0.01em; }
    .topbar-profile { display: flex; align-items: center; gap: 12px; }
    .topbar-profile-info { text-align: right; }
    .topbar-profile-name { font-size: 14px; font-weight: 600; color: #0e193e; line-height: 1.3; }
    .topbar-profile-role { font-size: 11px; color: #76767f; text-transform: uppercase; letter-spacing: 0.09em; }
    .topbar-avatar { width: 38px; height: 38px; border-radius: 50%; background-color: #242e54; display: flex; align-items: center; justify-content: center; color: #fff; font-weight: 700; font-size: 14px; flex-shrink: 0; font-family: 'Epilogue', sans-serif; }

    .admin-main { flex: 1; padding: 36px; }
    .admin-page-header { margin-bottom: 24px; }
    .admin-page-title { font-family: 'Epilogue', sans-serif; font-size: 26px; font-weight: 700; color: #0e193e; margin-bottom: 4px; }
    .admin-page-subtitle { font-size: 14px; color: #45464e; }

    /* Flash */
    .flash-success {
        background: #e8f5e9; border: 1px solid #a5d6a7; border-radius: 8px;
        padding: 12px 16px; display: flex; align-items: center; gap: 10px;
        font-size: 14px; color: #2e7d32; margin-bottom: 20px;
    }
    .flash-success .material-symbols-outlined { font-size: 20px; flex-shrink: 0; }

    /* Tabs */
    .tab-bar { display: flex; gap: 4px; margin-bottom: 20px; border-bottom: 2px solid #e1e3e4; }
    .tab-link {
        display: inline-flex; align-items: center; gap: 7px;
        padding: 10px 18px; font-size: 13px; font-weight: 600;
        color: #76767f; border-bottom: 2px solid transparent;
        margin-bottom: -2px; transition: color 0.15s, border-color 0.15s;
    }
    .tab-link:hover { color: #0e193e; }
    .tab-link.active { color: #0e193e; border-bottom-color: #a23d30; }
    .tab-count {
        display: inline-flex; align-items: center; justify-content: center;
        min-width: 20px; height: 20px; padding: 0 6px; border-radius: 10px;
        background: #e8e9ec; font-size: 11px; font-weight: 700; color: #45464e;
    }
    .tab-link.active .tab-count { background: #a23d30; color: #fff; }

    /* Search */
    .search-bar { position: relative; margin-bottom: 16px; }
    .search-icon { position: absolute; left: 12px; top: 50%; transform: translateY(-50%); color: #9b9ea4; font-size: 18px; pointer-events: none; }
    .search-input {
        width: 100%; padding: 10px 16px 10px 38px;
        border: 1px solid #e1e3e4; border-radius: 8px;
        background: #fff; font-family: 'Work Sans', sans-serif;
        font-size: 14px; color: #191c1d; outline: none; transition: border-color 0.15s;
    }
    .search-input:focus { border-color: #0e193e; }
    .search-input::placeholder { color: #b0b3ba; }

    /* Table */
    .table-card { background: #fff; border: 1px solid #e1e3e4; border-radius: 10px; overflow: hidden; }
    .table-wrap { overflow-x: auto; }
    table { width: 100%; border-collapse: collapse; }
    thead { background: #f8f9fa; }
    th {
        padding: 11px 16px; text-align: left;
        font-size: 11px; font-weight: 700; color: #76767f;
        text-transform: uppercase; letter-spacing: 0.08em;
        border-bottom: 1px solid #e1e3e4; white-space: nowrap;
    }
    td {
        padding: 14px 16px; font-size: 13.5px; color: #2d2f31;
        border-bottom: 1px solid #f0f2f5; vertical-align: middle;
    }
    tr:last-child td { border-bottom: none; }
    tbody tr:hover { background: #fafbfc; }

    .article-title-cell { max-width: 320px; }
    .article-title { font-weight: 600; color: #0e193e; line-height: 1.4; display: block; }
    .article-category { font-size: 11.5px; color: #76767f; margin-top: 3px; }

    /* Status badges */
    .badge {
        display: inline-flex; align-items: center; gap: 5px;
        padding: 3px 10px; border-radius: 20px;
        font-size: 11.5px; font-weight: 600; white-space: nowrap;
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

    .author-cell { font-size: 13px; color: #45464e; }

    .btn-review {
        display: inline-flex; align-items: center; gap: 5px;
        padding: 6px 14px; border-radius: 6px;
        background: #0e193e; color: #fff;
        font-size: 12px; font-weight: 600;
        transition: background-color 0.15s;
        white-space: nowrap;
    }
    .btn-review:hover { background: #1a2d5a; }
    .btn-review .material-symbols-outlined { font-size: 15px; }

    .empty-state {
        padding: 60px 36px; text-align: center; color: #76767f;
    }
    .empty-icon .material-symbols-outlined {
        font-size: 48px; color: #d0d2d8;
        font-variation-settings: 'FILL' 0, 'wght' 300, 'GRAD' 0, 'opsz' 48;
    }
    .empty-title { font-size: 16px; font-weight: 600; color: #45464e; margin: 12px 0 6px; }
    .empty-sub   { font-size: 13px; }
    </style>
</head>
<body>
<div class="admin-shell">

    <jsp:include page="/WEB-INF/views/admin/includes/sidebar.jsp"/>

    <div class="admin-content">

        <header class="admin-topbar">
            <span class="topbar-title">Articles</span>
            <div class="topbar-profile">
                <div class="topbar-profile-info">
                    <div class="topbar-profile-name"><%= adminDisplayName %></div>
                    <div class="topbar-profile-role">Administrator</div>
                </div>
                <div class="topbar-avatar"><%= userInitial %></div>
            </div>
        </header>

        <main class="admin-main">

            <div class="admin-page-header">
                <h1 class="admin-page-title">Article Review Queue</h1>
                <p class="admin-page-subtitle">Review, publish, or reject contributor submissions.</p>
            </div>

            <% if (flashSuccess != null) { %>
            <div class="flash-success">
                <span class="material-symbols-outlined">check_circle</span>
                <%= flashSuccess %>
            </div>
            <% } %>

            <!-- Tabs -->
            <div class="tab-bar">
                <a href="?status=PENDING"
                   class="tab-link <%= "PENDING".equals(statusFilter) ? "active" : "" %>">
                    <span class="material-symbols-outlined" style="font-size:16px;">pending_actions</span>
                    Pending
                    <span class="tab-count"><%= cntPending %></span>
                </a>
                <a href="?status=PUBLISHED"
                   class="tab-link <%= "PUBLISHED".equals(statusFilter) ? "active" : "" %>">
                    <span class="material-symbols-outlined" style="font-size:16px;">check_circle</span>
                    Published
                    <span class="tab-count"><%= cntPublished %></span>
                </a>
                <a href="?status=REJECTED"
                   class="tab-link <%= "REJECTED".equals(statusFilter) ? "active" : "" %>">
                    <span class="material-symbols-outlined" style="font-size:16px;">cancel</span>
                    Rejected
                    <span class="tab-count"><%= cntRejected %></span>
                </a>
                <a href="?status=DRAFT"
                   class="tab-link <%= "DRAFT".equals(statusFilter) ? "active" : "" %>">
                    <span class="material-symbols-outlined" style="font-size:16px;">edit_note</span>
                    Drafts
                    <span class="tab-count"><%= cntDraft %></span>
                </a>
                <a href="?status=ALL"
                   class="tab-link <%= "ALL".equals(statusFilter) ? "active" : "" %>">
                    All
                </a>
            </div>

            <div class="search-bar">
                <span class="material-symbols-outlined search-icon">search</span>
                <input type="text" id="articleSearch" class="search-input" placeholder="Search by title or author…" />
            </div>

            <div class="table-card">
                <div class="table-wrap">
                    <table>
                        <thead>
                            <tr>
                                <th>Title</th>
                                <th>Author</th>
                                <th>Status</th>
                                <th>Submitted</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                        <% if (articles == null || articles.isEmpty()) { %>
                            <tr><td colspan="5">
                                <div class="empty-state">
                                    <div class="empty-icon"><span class="material-symbols-outlined">inbox</span></div>
                                    <div class="empty-title">No articles here</div>
                                    <div class="empty-sub">Nothing to show for this filter yet.</div>
                                </div>
                            </td></tr>
                        <% } else { for (Article a : articles) {
                               String badgeClass = "badge-" + a.getStatus().toLowerCase();
                               String searchData = (a.getTitle() + " " + (a.getAuthorName() != null ? a.getAuthorName() : "") + " " + (a.getCategoryName() != null ? a.getCategoryName() : "")).toLowerCase();
                           %>
                            <tr data-search="<%= searchData %>">
                                <td class="article-title-cell">
                                    <span class="article-title"><%= a.getTitle() %></span>
                                    <% if (a.getCategoryName() != null) { %>
                                    <span class="article-category"><%= a.getCategoryName() %></span>
                                    <% } %>
                                </td>
                                <td class="author-cell"><%= a.getAuthorName() != null ? a.getAuthorName() : "—" %></td>
                                <td>
                                    <span class="badge <%= badgeClass %>">
                                        <span class="badge-dot"></span>
                                        <%= a.getStatusLabel() %>
                                    </span>
                                </td>
                                <td style="color:#76767f;font-size:12.5px;">
                                    <%= a.getUpdatedAt() != null ? fmt.format(a.getUpdatedAt()) : "—" %>
                                </td>
                                <td>
                                    <a href="<%= cp %>/admin/articles/review?id=<%= a.getArticleId() %>"
                                       class="btn-review">
                                        <span class="material-symbols-outlined">rate_review</span>
                                        Review
                                    </a>
                                </td>
                            </tr>
                        <% } } %>
                        </tbody>
                    </table>
                </div>
            </div>

        </main>
    </div>
</div>
<script>
(function () {
    var input = document.getElementById('articleSearch');
    if (!input) return;
    input.addEventListener('input', function () {
        var q = this.value.trim().toLowerCase();
        var rows = document.querySelectorAll('tbody tr[data-search]');
        rows.forEach(function (row) {
            row.style.display = (!q || row.dataset.search.indexOf(q) !== -1) ? '' : 'none';
        });
    });
})();
</script>
</body>
</html>
