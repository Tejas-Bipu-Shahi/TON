<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.thoughtsofnomads.model.User, com.thoughtsofnomads.model.Article, java.util.List, java.text.SimpleDateFormat" %>
<%
    User user = (User) session.getAttribute("user");
    String userInitial = (user != null && user.getEmail() != null)
        ? String.valueOf(user.getEmail().charAt(0)).toUpperCase()
        : "A";

    int totalArticles     = (Integer) request.getAttribute("totalArticles");
    int pendingCount      = (Integer) request.getAttribute("pendingCount");
    int newThisMonth      = (Integer) request.getAttribute("newThisMonth");
    int totalContributors = (Integer) request.getAttribute("totalContributors");
    int newContributors   = (Integer) request.getAttribute("newContributors");
    int totalCategories   = (Integer) request.getAttribute("totalCategories");
    int totalSubscribers  = (Integer) request.getAttribute("totalSubscribers");

    List<Article> pendingArticles = (List<Article>) request.getAttribute("pendingArticles");
    List<User>    recentUsers     = (List<User>)    request.getAttribute("recentUsers");

    SimpleDateFormat sdf = new SimpleDateFormat("d MMM yyyy");
    String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard — Admin | Thoughts of Nomads</title>
    <link href="https://fonts.googleapis.com/css2?family=Epilogue:wght@400;600;700&family=Work+Sans:wght@400;500;600&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" rel="stylesheet"/>
    <style>
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
    body {
        font-family: 'Work Sans', sans-serif;
        background-color: #f0f2f5;
        color: #191c1d;
        -webkit-font-smoothing: antialiased;
    }
    a { text-decoration: none; color: inherit; }
    button { cursor: pointer; font-family: inherit; }
    .material-symbols-outlined {
        font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
        vertical-align: middle;
    }

    /* Shell */
    .admin-shell { display: flex; min-height: 100vh; }
    .admin-content { flex: 1; display: flex; flex-direction: column; min-width: 0; }

    /* Top Bar */
    .admin-topbar {
        background-color: #ffffff;
        border-bottom: 1px solid #e1e3e4;
        height: 68px;
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 0 36px;
        position: sticky;
        top: 0;
        z-index: 10;
        flex-shrink: 0;
    }
    .topbar-title { font-family: 'Epilogue', sans-serif; font-size: 20px; font-weight: 700; color: #0e193e; letter-spacing: -0.01em; }
    .topbar-profile { display: flex; align-items: center; gap: 12px; }
    .topbar-profile-info { text-align: right; }
    .topbar-profile-name { font-size: 14px; font-weight: 600; color: #0e193e; line-height: 1.3; }
    .topbar-profile-role { font-size: 11px; color: #76767f; text-transform: uppercase; letter-spacing: 0.09em; }
    .topbar-avatar {
        width: 38px; height: 38px; border-radius: 50%; background-color: #242e54;
        display: flex; align-items: center; justify-content: center;
        color: #ffffff; font-weight: 700; font-size: 14px; flex-shrink: 0; font-family: 'Epilogue', sans-serif;
    }

    /* Main */
    .admin-main { flex: 1; padding: 36px; }
    .admin-page-header { margin-bottom: 28px; }
    .admin-page-title { font-family: 'Epilogue', sans-serif; font-size: 26px; font-weight: 700; color: #0e193e; margin-bottom: 4px; }
    .admin-page-subtitle { font-size: 14px; color: #45464e; }

    /* Metric Cards */
    .metrics-grid {
        display: grid;
        grid-template-columns: repeat(5, 1fr);
        gap: 20px;
        margin-bottom: 36px;
    }
    @media (max-width: 1200px) { .metrics-grid { grid-template-columns: repeat(3, 1fr); } }
    @media (max-width: 768px)  { .metrics-grid { grid-template-columns: repeat(2, 1fr); } }
    @media (max-width: 480px)  { .metrics-grid { grid-template-columns: 1fr; } }

    .metric-card {
        background-color: #ffffff;
        border: 1px solid #e1e3e4;
        border-radius: 10px;
        padding: 22px 24px;
        display: flex; flex-direction: column; gap: 14px;
        transition: box-shadow 0.2s ease, transform 0.2s ease;
    }
    .metric-card:hover { box-shadow: 0 4px 20px rgba(14,25,62,0.09); transform: translateY(-1px); }
    .metric-card-top { display: flex; align-items: flex-start; justify-content: space-between; }
    .metric-label { font-size: 11px; font-weight: 600; color: #76767f; text-transform: uppercase; letter-spacing: 0.1em; }
    .metric-icon { width: 38px; height: 38px; border-radius: 8px; display: flex; align-items: center; justify-content: center; flex-shrink: 0; }
    .metric-icon .material-symbols-outlined { font-size: 20px; font-variation-settings: 'FILL' 1, 'wght' 400, 'GRAD' 0, 'opsz' 20; }
    .icon-blue   { background-color: #e8eaf6; color: #242e54; }
    .icon-amber  { background-color: #fff8e1; color: #e65100; }
    .icon-green  { background-color: #e8f5e9; color: #2e7d32; }
    .icon-violet { background-color: #f3e5f5; color: #6a1b9a; }
    .icon-teal   { background-color: #e0f2f1; color: #00695c; }
    .metric-value { font-family: 'Epilogue', sans-serif; font-size: 38px; font-weight: 700; color: #0e193e; line-height: 1; }
    .metric-footer { display: flex; align-items: center; gap: 4px; font-size: 12px; color: #76767f; padding-top: 6px; border-top: 1px solid #f0f2f5; }
    .metric-footer.positive { color: #2e7d32; }
    .metric-footer .material-symbols-outlined { font-size: 14px; font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 20; }

    /* Dashboard grid */
    .dash-grid {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 24px;
    }
    @media (max-width: 900px) { .dash-grid { grid-template-columns: 1fr; } }

    /* Panel cards */
    .panel {
        background: #ffffff;
        border: 1px solid #e1e3e4;
        border-radius: 10px;
        overflow: hidden;
    }
    .panel-header {
        display: flex; align-items: center; justify-content: space-between;
        padding: 18px 24px;
        border-bottom: 1px solid #f0f2f5;
    }
    .panel-title { font-family: 'Epilogue', sans-serif; font-size: 15px; font-weight: 700; color: #0e193e; }
    .panel-action {
        font-size: 12px; font-weight: 600; color: #242e54;
        text-transform: uppercase; letter-spacing: 0.08em;
        transition: color 0.2s;
    }
    .panel-action:hover { color: #0e193e; }

    /* Table */
    .dash-table { width: 100%; border-collapse: collapse; }
    .dash-table th {
        text-align: left; padding: 10px 24px;
        font-size: 10px; font-weight: 700; text-transform: uppercase;
        letter-spacing: 0.1em; color: #76767f;
        background-color: #f8f9fa; border-bottom: 1px solid #e1e3e4;
    }
    .dash-table td { padding: 13px 24px; border-bottom: 1px solid #f0f2f5; font-size: 13px; vertical-align: middle; }
    .dash-table tr:last-child td { border-bottom: none; }
    .dash-table tr:hover td { background-color: #fafbfc; }

    .td-title { font-weight: 500; color: #0e193e; max-width: 200px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; }
    .td-meta  { color: #76767f; font-size: 12px; }
    .td-date  { color: #76767f; white-space: nowrap; }

    .badge {
        display: inline-block; padding: 3px 8px; border-radius: 4px;
        font-size: 10px; font-weight: 700; text-transform: uppercase; letter-spacing: 0.06em; white-space: nowrap;
    }
    .badge-pending  { background: #fff8e1; color: #e65100; }
    .badge-active   { background: #e8f5e9; color: #2e7d32; }
    .badge-disabled { background: #fce4ec; color: #b71c1c; }
    .badge-unverified { background: #f3e5f5; color: #6a1b9a; }
    .badge-contributor { background: #e8eaf6; color: #242e54; }
    .badge-admin    { background: #fff8e1; color: #e65100; }

    .btn-review {
        display: inline-flex; align-items: center; gap: 4px;
        padding: 5px 12px; border-radius: 4px; font-size: 11px; font-weight: 700;
        text-transform: uppercase; letter-spacing: 0.06em;
        background-color: #242e54; color: #ffffff;
        transition: background-color 0.2s;
    }
    .btn-review:hover { background-color: #0e193e; }
    .btn-review .material-symbols-outlined { font-size: 13px; }

    .empty-state { padding: 40px 24px; text-align: center; color: #76767f; font-size: 14px; }
    .empty-state .material-symbols-outlined { font-size: 36px; display: block; margin-bottom: 8px; color: #c6c5cf; }
    </style>
</head>
<body>
<div class="admin-shell">

    <jsp:include page="/WEB-INF/views/admin/includes/sidebar.jsp"/>

    <div class="admin-content">

        <header class="admin-topbar">
            <span class="topbar-title">Overview</span>
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
                <h1 class="admin-page-title">Dashboard</h1>
                <p class="admin-page-subtitle">Welcome back. Here's a live snapshot of your platform.</p>
            </div>

            <!-- Metric Cards -->
            <div class="metrics-grid">

                <div class="metric-card">
                    <div class="metric-card-top">
                        <span class="metric-label">Total Articles</span>
                        <div class="metric-icon icon-blue">
                            <span class="material-symbols-outlined">article</span>
                        </div>
                    </div>
                    <div class="metric-value"><%= totalArticles %></div>
                    <div class="metric-footer positive">
                        <span class="material-symbols-outlined">trending_up</span>
                        +<%= newThisMonth %> this month
                    </div>
                </div>

                <div class="metric-card">
                    <div class="metric-card-top">
                        <span class="metric-label">Pending Review</span>
                        <div class="metric-icon icon-amber">
                            <span class="material-symbols-outlined">pending_actions</span>
                        </div>
                    </div>
                    <div class="metric-value"><%= pendingCount %></div>
                    <div class="metric-footer">
                        <span class="material-symbols-outlined">schedule</span>
                        Awaiting approval
                    </div>
                </div>

                <div class="metric-card">
                    <div class="metric-card-top">
                        <span class="metric-label">Contributors</span>
                        <div class="metric-icon icon-green">
                            <span class="material-symbols-outlined">group</span>
                        </div>
                    </div>
                    <div class="metric-value"><%= totalContributors %></div>
                    <div class="metric-footer <%= newContributors > 0 ? "positive" : "" %>">
                        <span class="material-symbols-outlined"><%= newContributors > 0 ? "trending_up" : "people" %></span>
                        <% if (newContributors > 0) { %>+<%= newContributors %> this week<% } else { %>No new this week<% } %>
                    </div>
                </div>

                <div class="metric-card">
                    <div class="metric-card-top">
                        <span class="metric-label">Categories</span>
                        <div class="metric-icon icon-violet">
                            <span class="material-symbols-outlined">folder_open</span>
                        </div>
                    </div>
                    <div class="metric-value"><%= totalCategories %></div>
                    <div class="metric-footer">
                        <span class="material-symbols-outlined">layers</span>
                        Across all content
                    </div>
                </div>

                <div class="metric-card">
                    <div class="metric-card-top">
                        <span class="metric-label">Subscribers</span>
                        <div class="metric-icon icon-teal">
                            <span class="material-symbols-outlined">mail</span>
                        </div>
                    </div>
                    <div class="metric-value"><%= totalSubscribers %></div>
                    <div class="metric-footer">
                        <span class="material-symbols-outlined">mark_email_read</span>
                        Newsletter list
                    </div>
                </div>

            </div>

            <!-- Tables -->
            <div class="dash-grid">

                <!-- Pending Review Queue -->
                <div class="panel">
                    <div class="panel-header">
                        <span class="panel-title">Pending Review</span>
                        <a href="<%= cp %>/admin/articles?status=PENDING" class="panel-action">View all</a>
                    </div>
                    <% if (pendingArticles == null || pendingArticles.isEmpty()) { %>
                        <div class="empty-state">
                            <span class="material-symbols-outlined">task_alt</span>
                            No articles awaiting review
                        </div>
                    <% } else { %>
                        <table class="dash-table">
                            <thead>
                                <tr>
                                    <th>Title</th>
                                    <th>Author</th>
                                    <th>Submitted</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                            <% for (Article a : pendingArticles) { %>
                                <tr>
                                    <td class="td-title" title="<%= a.getTitle() %>"><%= a.getTitle() %></td>
                                    <td class="td-meta"><%= a.getAuthorName() != null ? a.getAuthorName() : "—" %></td>
                                    <td class="td-date"><%= a.getUpdatedAt() != null ? sdf.format(a.getUpdatedAt()) : "—" %></td>
                                    <td>
                                        <a href="<%= cp %>/admin/articles/review?id=<%= a.getArticleId() %>" class="btn-review">
                                            <span class="material-symbols-outlined">rate_review</span>
                                            Review
                                        </a>
                                    </td>
                                </tr>
                            <% } %>
                            </tbody>
                        </table>
                    <% } %>
                </div>

                <!-- Recent Registrations -->
                <div class="panel">
                    <div class="panel-header">
                        <span class="panel-title">Recent Registrations</span>
                        <a href="<%= cp %>/admin/users" class="panel-action">View all</a>
                    </div>
                    <% if (recentUsers == null || recentUsers.isEmpty()) { %>
                        <div class="empty-state">
                            <span class="material-symbols-outlined">person_off</span>
                            No users registered yet
                        </div>
                    <% } else { %>
                        <table class="dash-table">
                            <thead>
                                <tr>
                                    <th>Name</th>
                                    <th>Role</th>
                                    <th>Status</th>
                                    <th>Joined</th>
                                </tr>
                            </thead>
                            <tbody>
                            <% for (User u : recentUsers) {
                                String name = (u.getProfile() != null && u.getProfile().getFullName() != null && !u.getProfile().getFullName().isBlank())
                                    ? u.getProfile().getFullName() : u.getEmail();
                                String role   = u.getRole().name();
                                String status = u.getAccountStatus().name();
                                String statusClass = "active".equalsIgnoreCase(status) ? "badge-active"
                                    : "unverified".equalsIgnoreCase(status) ? "badge-unverified"
                                    : "badge-disabled";
                                String roleClass = "admin".equalsIgnoreCase(role) ? "badge-admin" : "badge-contributor";
                            %>
                                <tr>
                                    <td>
                                        <div style="font-weight:500;color:#0e193e;"><%= name %></div>
                                        <div class="td-meta"><%= u.getEmail() %></div>
                                    </td>
                                    <td><span class="badge <%= roleClass %>"><%= role %></span></td>
                                    <td><span class="badge <%= statusClass %>"><%= status %></span></td>
                                    <td class="td-date"><%= u.getCreatedAt() != null ? sdf.format(u.getCreatedAt()) : "—" %></td>
                                </tr>
                            <% } %>
                            </tbody>
                        </table>
                    <% } %>
                </div>

            </div>

        </main>
    </div>
</div>
</body>
</html>
