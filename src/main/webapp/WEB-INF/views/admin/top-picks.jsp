<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.thoughtsofnomads.model.User, com.thoughtsofnomads.model.Article,
                 java.util.List, java.util.Set, java.text.SimpleDateFormat" %>
<%
    User   user        = (User) session.getAttribute("user");
    String userInitial = (user != null && user.getEmail() != null)
        ? String.valueOf(user.getEmail().charAt(0)).toUpperCase() : "A";

    List<Article> topPicks     = (List<Article>) request.getAttribute("topPicks");
    List<Article> allPublished = (List<Article>) request.getAttribute("allPublished");
    int topPickCount           = (Integer) request.getAttribute("topPickCount");
    Set<Integer>  topPickIds   = (Set<Integer>)  request.getAttribute("topPickIds");

    String flashSuccess = (String) session.getAttribute("flashSuccess");
    String flashError   = (String) session.getAttribute("flashError");
    if (flashSuccess != null) session.removeAttribute("flashSuccess");
    if (flashError   != null) session.removeAttribute("flashError");

    SimpleDateFormat fmt = new SimpleDateFormat("MMM d, yyyy");
    String cp = request.getContextPath();
    boolean isFull = topPickCount >= 3;

    String adminDisplayName = (user != null && user.getEmail() != null)
        ? user.getEmail().substring(0, user.getEmail().contains("@") ? user.getEmail().indexOf("@") : user.getEmail().length())
        : "Admin";
    adminDisplayName = adminDisplayName.isEmpty() ? "Admin"
        : Character.toUpperCase(adminDisplayName.charAt(0)) + adminDisplayName.substring(1);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Top Picks — Admin | Thoughts of Nomads</title>
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
    .topbar-title { font-family: 'Epilogue', sans-serif; font-size: 20px; font-weight: 700; color: #0e193e; }
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
    .flash-success, .flash-error {
        border-radius: 8px; padding: 12px 16px;
        display: flex; align-items: center; gap: 10px;
        font-size: 14px; margin-bottom: 20px;
    }
    .flash-success { background: #e8f5e9; border: 1px solid #a5d6a7; color: #2e7d32; }
    .flash-error   { background: #fce4ec; border: 1px solid #ef9a9a; color: #c62828; }
    .flash-success .material-symbols-outlined,
    .flash-error   .material-symbols-outlined { font-size: 20px; flex-shrink: 0; }

    /* Slot counter */
    .slot-bar {
        display: flex; align-items: center; gap: 12px;
        margin-bottom: 28px;
    }
    .slot-label { font-size: 13px; font-weight: 600; color: #45464e; }
    .slot-pips { display: flex; gap: 6px; }
    .slot-pip {
        width: 28px; height: 8px; border-radius: 4px;
        background: #e1e3e4; transition: background 0.2s;
    }
    .slot-pip.filled { background: #a23d30; }

    /* Picks grid */
    .picks-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(260px, 1fr)); gap: 20px; margin-bottom: 48px; }

    .pick-card {
        background: #fff; border: 1px solid #e1e3e4; border-radius: 10px;
        overflow: hidden; display: flex; flex-direction: column;
    }
    .pick-card-img { width: 100%; height: 140px; object-fit: cover; display: block; }
    .pick-card-no-img {
        width: 100%; height: 140px; background: #e8eaf0;
        display: flex; align-items: center; justify-content: center; color: #9ba3c0;
    }
    .pick-card-no-img .material-symbols-outlined { font-size: 40px; font-variation-settings: 'FILL' 0, 'wght' 300, 'GRAD' 0, 'opsz' 40; }
    .pick-card-body { padding: 14px 16px; flex: 1; display: flex; flex-direction: column; gap: 6px; }
    .pick-card-category { font-size: 10px; font-weight: 700; text-transform: uppercase; letter-spacing: 0.1em; color: #a26b1c; }
    .pick-card-title { font-family: 'Epilogue', sans-serif; font-size: 15px; font-weight: 600; color: #0e193e; line-height: 1.3; flex: 1; }
    .pick-card-author { font-size: 12px; color: #76767f; }

    .pick-card-footer { padding: 10px 16px; border-top: 1px solid #f0f2f5; display: flex; justify-content: flex-end; }
    .btn-remove {
        display: inline-flex; align-items: center; gap: 5px;
        padding: 6px 14px; border-radius: 6px; border: 1px solid #ef9a9a;
        background: #fce4ec; color: #c62828;
        font-size: 12px; font-weight: 600;
        transition: background 0.15s;
    }
    .btn-remove:hover { background: #f8bbd0; }
    .btn-remove .material-symbols-outlined { font-size: 15px; }

    .pick-slot-empty {
        background: #fff; border: 2px dashed #d0d2d8; border-radius: 10px;
        height: 230px; display: flex; flex-direction: column;
        align-items: center; justify-content: center; gap: 8px;
        color: #adb0bb;
    }
    .pick-slot-empty .material-symbols-outlined { font-size: 36px; font-variation-settings: 'FILL' 0, 'wght' 300, 'GRAD' 0, 'opsz' 36; }
    .pick-slot-empty-label { font-size: 13px; font-weight: 500; }

    /* Section heading */
    .section-heading { font-family: 'Epilogue', sans-serif; font-size: 18px; font-weight: 700; color: #0e193e; margin-bottom: 16px; }

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
        padding: 13px 16px; font-size: 13.5px; color: #2d2f31;
        border-bottom: 1px solid #f0f2f5; vertical-align: middle;
    }
    tr:last-child td { border-bottom: none; }
    tbody tr:hover { background: #fafbfc; }

    .article-title-cell { max-width: 320px; }
    .article-title { font-weight: 600; color: #0e193e; line-height: 1.4; display: block; }
    .article-category { font-size: 11.5px; color: #76767f; margin-top: 3px; }

    .btn-add {
        display: inline-flex; align-items: center; gap: 5px;
        padding: 6px 14px; border-radius: 6px;
        background: #0e193e; color: #fff;
        font-size: 12px; font-weight: 600; border: none;
        transition: background 0.15s; white-space: nowrap;
    }
    .btn-add:hover { background: #1a2d5a; }
    .btn-add:disabled { background: #c6c8d0; color: #888; cursor: not-allowed; }
    .btn-add .material-symbols-outlined { font-size: 15px; }

    .badge-picked {
        display: inline-flex; align-items: center; gap: 5px;
        padding: 4px 10px; border-radius: 20px; font-size: 11.5px; font-weight: 600;
        background: #fff9eb; color: #a26b1c; white-space: nowrap;
    }
    .badge-picked .material-symbols-outlined { font-size: 14px; }

    .empty-state { padding: 60px 36px; text-align: center; color: #76767f; }
    .empty-icon .material-symbols-outlined { font-size: 48px; color: #d0d2d8; font-variation-settings: 'FILL' 0, 'wght' 300, 'GRAD' 0, 'opsz' 48; }
    .empty-title { font-size: 16px; font-weight: 600; color: #45464e; margin: 12px 0 6px; }
    </style>
</head>
<body>
<div class="admin-shell">

    <jsp:include page="/WEB-INF/views/admin/includes/sidebar.jsp"/>

    <div class="admin-content">

        <header class="admin-topbar">
            <span class="topbar-title">Top Picks</span>
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
                <h1 class="admin-page-title">Top Picks</h1>
                <p class="admin-page-subtitle">Choose up to 3 published articles to feature on the homepage.</p>
            </div>

            <% if (flashSuccess != null) { %>
            <div class="flash-success">
                <span class="material-symbols-outlined">check_circle</span>
                <%= flashSuccess %>
            </div>
            <% } %>
            <% if (flashError != null) { %>
            <div class="flash-error">
                <span class="material-symbols-outlined">error</span>
                <%= flashError %>
            </div>
            <% } %>

            <!-- Slot counter -->
            <div class="slot-bar">
                <span class="slot-label"><%= topPickCount %> / 3 slots used</span>
                <div class="slot-pips">
                    <div class="slot-pip<%= topPickCount >= 1 ? " filled" : "" %>"></div>
                    <div class="slot-pip<%= topPickCount >= 2 ? " filled" : "" %>"></div>
                    <div class="slot-pip<%= topPickCount >= 3 ? " filled" : "" %>"></div>
                </div>
            </div>

            <!-- Current picks -->
            <h2 class="section-heading">Current Top Picks</h2>
            <div class="picks-grid">
                <% for (Article a : topPicks) { %>
                <div class="pick-card">
                    <% if (a.getCoverImage() != null && !a.getCoverImage().isBlank()) { %>
                    <img class="pick-card-img" src="<%= cp %>/<%= a.getCoverImage() %>" alt=""/>
                    <% } else { %>
                    <div class="pick-card-no-img"><span class="material-symbols-outlined">article</span></div>
                    <% } %>
                    <div class="pick-card-body">
                        <% if (a.getCategoryName() != null) { %>
                        <div class="pick-card-category"><%= a.getCategoryName() %></div>
                        <% } %>
                        <div class="pick-card-title"><%= a.getTitle() %></div>
                        <% if (a.getAuthorName() != null) { %>
                        <div class="pick-card-author">By <%= a.getAuthorName() %></div>
                        <% } %>
                    </div>
                    <div class="pick-card-footer">
                        <form method="post" action="<%= cp %>/admin/top-picks">
                            <input type="hidden" name="action" value="remove"/>
                            <input type="hidden" name="articleId" value="<%= a.getArticleId() %>"/>
                            <button class="btn-remove" type="submit">
                                <span class="material-symbols-outlined">close</span>
                                Remove
                            </button>
                        </form>
                    </div>
                </div>
                <% } %>

                <% for (int i = topPickCount; i < 3; i++) { %>
                <div class="pick-slot-empty">
                    <span class="material-symbols-outlined">add_circle</span>
                    <span class="pick-slot-empty-label">Empty slot</span>
                </div>
                <% } %>
            </div>

            <!-- All published articles -->
            <h2 class="section-heading">Published Articles</h2>
            <% if (allPublished == null || allPublished.isEmpty()) { %>
            <div class="table-card">
                <div class="empty-state">
                    <div class="empty-icon"><span class="material-symbols-outlined">article</span></div>
                    <div class="empty-title">No published articles</div>
                    <p>Publish some articles first to add them to Top Picks.</p>
                </div>
            </div>
            <% } else { %>
            <div class="table-card">
                <div class="table-wrap">
                    <table>
                        <thead>
                            <tr>
                                <th>Article</th>
                                <th>Author</th>
                                <th>Published</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Article a : allPublished) {
                                boolean isPick = topPickIds != null && topPickIds.contains(a.getArticleId());
                            %>
                            <tr>
                                <td class="article-title-cell">
                                    <span class="article-title"><%= a.getTitle() %></span>
                                    <% if (a.getCategoryName() != null) { %>
                                    <span class="article-category"><%= a.getCategoryName() %></span>
                                    <% } %>
                                </td>
                                <td style="font-size:13px; color:#45464e;">
                                    <%= a.getAuthorName() != null ? a.getAuthorName() : "—" %>
                                </td>
                                <td style="font-size:13px; color:#45464e; white-space:nowrap;">
                                    <%= a.getPublishedAt() != null ? fmt.format(a.getPublishedAt()) : "—" %>
                                </td>
                                <td>
                                    <% if (isPick) { %>
                                    <span class="badge-picked">
                                        <span class="material-symbols-outlined">star</span>
                                        Featured
                                    </span>
                                    <% } else { %>
                                    <form method="post" action="<%= cp %>/admin/top-picks" style="display:inline;">
                                        <input type="hidden" name="action" value="add"/>
                                        <input type="hidden" name="articleId" value="<%= a.getArticleId() %>"/>
                                        <button class="btn-add" type="submit" <%= isFull ? "disabled" : "" %>>
                                            <span class="material-symbols-outlined">add</span>
                                            <%= isFull ? "Slots full" : "Add to Top Picks" %>
                                        </button>
                                    </form>
                                    <% } %>
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
            <% } %>

        </main>
    </div>
</div>
</body>
</html>
