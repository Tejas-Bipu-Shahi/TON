<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.thoughtsofnomads.model.User, com.thoughtsofnomads.model.UserProfile,
                 com.thoughtsofnomads.model.Article, java.util.List, java.text.SimpleDateFormat" %>
<%
    User        user         = (User)        session.getAttribute("user");
    UserProfile profile      = (UserProfile) request.getAttribute("userProfile");
    List<Article> recent     = (List<Article>) request.getAttribute("recentArticles");

    int statTotal     = (Integer) request.getAttribute("statTotal");
    int statPublished = (Integer) request.getAttribute("statPublished");
    int statPending   = (Integer) request.getAttribute("statPending");
    int statDraft     = (Integer) request.getAttribute("statDraft");

    String fullName  = (profile != null && profile.getFullName() != null) ? profile.getFullName() : "Contributor";
    String initials  = (profile != null) ? profile.getInitials() : "?";
    String firstName = fullName.trim().split("\\s+")[0];
    String bio       = (profile != null && profile.getBio() != null) ? profile.getBio() : null;

    SimpleDateFormat dateFmt = new SimpleDateFormat("MMM d, yyyy");
    String joinedDate = (user.getCreatedAt() != null) ? dateFmt.format(user.getCreatedAt()) : "";
    String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Dashboard — Thoughts of Nomads</title>
    <link href="https://fonts.googleapis.com/css2?family=Epilogue:wght@400;600;700&family=Work+Sans:wght@400;500;600&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" rel="stylesheet"/>
    <style>
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
    body { font-family: 'Work Sans', sans-serif; background-color: #f8f9fa; color: #191c1d; -webkit-font-smoothing: antialiased; }
    a { text-decoration: none; color: inherit; }
    button { cursor: pointer; font-family: inherit; }
    .material-symbols-outlined { font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24; vertical-align: middle; line-height: 1; }

    /* ── Member Topbar ───────────────────────────────────── */
    .member-topbar {
        position: sticky; top: 0; z-index: 100;
        background: #ffffff; border-bottom: 1px solid #e1e3e4;
        height: 56px; display: flex; align-items: center;
        justify-content: space-between; padding: 0 48px; gap: 16px;
    }
    @media (max-width: 767px) { .member-topbar { padding: 0 20px; } }

    .topbar-back {
        display: inline-flex; align-items: center; gap: 6px;
        padding: 6px 14px; border-radius: 20px;
        border: 1px solid #e1e3e4; background: #f8f9fa;
        font-size: 12px; font-weight: 600; color: #45464e;
        text-transform: uppercase; letter-spacing: 0.07em;
        transition: background-color 0.15s ease, color 0.15s ease, border-color 0.15s ease;
        white-space: nowrap;
    }
    .topbar-back:hover { background-color: #0e193e; color: #fff; border-color: #0e193e; }
    .topbar-back .material-symbols-outlined { font-size: 15px; }

    .topbar-brand {
        font-family: 'Epilogue', sans-serif; font-size: 15px; font-weight: 700;
        color: #0e193e; text-transform: uppercase; letter-spacing: 0.1em;
        position: absolute; left: 50%; transform: translateX(-50%);
    }
    @media (max-width: 600px) { .topbar-brand { display: none; } }

    .topbar-user { display: flex; align-items: center; gap: 10px; }
    .topbar-name { font-size: 13px; font-weight: 600; color: #0e193e; }
    @media (max-width: 480px) { .topbar-name { display: none; } }

    .topbar-avatar {
        width: 32px; height: 32px; border-radius: 50%;
        background-color: #00695c; flex-shrink: 0;
        display: flex; align-items: center; justify-content: center;
        font-family: 'Epilogue', sans-serif; font-size: 11px; font-weight: 700; color: #fff;
    }
    .topbar-logout {
        display: flex; align-items: center; justify-content: center;
        width: 32px; height: 32px; border-radius: 6px; color: #76767f;
        transition: background-color 0.15s ease, color 0.15s ease;
    }
    .topbar-logout:hover { background-color: #fce4ec; color: #c62828; }
    .topbar-logout .material-symbols-outlined { font-size: 18px; }

    /* ── Welcome Hero ────────────────────────────────────── */
    .dash-hero {
        background-color: #0e193e;
        background-image: linear-gradient(135deg, #0e193e 0%, #1f2d5a 100%);
        padding: 36px 0;
    }
    .dash-hero-inner {
        max-width: 1100px; margin: 0 auto;
        padding: 0 48px;
        display: flex; align-items: center; gap: 20px;
    }
    @media (max-width: 767px) { .dash-hero-inner { padding: 0 20px; } }

    .hero-avatar {
        width: 60px; height: 60px; border-radius: 50%; flex-shrink: 0;
        background-color: #00695c;
        display: flex; align-items: center; justify-content: center;
        font-family: 'Epilogue', sans-serif; font-size: 20px; font-weight: 700;
        color: #fff; letter-spacing: 0.02em;
        border: 2px solid rgba(255,255,255,0.2);
    }
    .hero-text { flex: 1; min-width: 0; }
    .hero-greeting {
        font-family: 'Epilogue', sans-serif; font-size: 24px; font-weight: 700;
        color: #ffffff; margin-bottom: 6px;
    }
    .hero-meta {
        display: flex; align-items: center; gap: 10px; flex-wrap: wrap;
        font-size: 13px; color: rgba(255,255,255,0.55);
    }
    .hero-chip {
        padding: 2px 9px; border-radius: 12px;
        background-color: rgba(255,255,255,0.12);
        font-size: 10.5px; font-weight: 600; letter-spacing: 0.08em;
        text-transform: uppercase; color: rgba(255,255,255,0.8);
    }
    .hero-actions { display: flex; gap: 10px; flex-shrink: 0; }
    .btn-hero-primary {
        display: inline-flex; align-items: center; gap: 6px;
        padding: 9px 18px; border-radius: 5px;
        background-color: #ffffff; color: #0e193e;
        font-size: 12px; font-weight: 700; letter-spacing: 0.07em; text-transform: uppercase;
        border: none; transition: opacity 0.15s ease;
    }
    .btn-hero-primary:hover { opacity: 0.9; }
    .btn-hero-primary .material-symbols-outlined { font-size: 16px; }

    /* ── Container ───────────────────────────────────────── */
    .dash-container { max-width: 1100px; margin: 0 auto; padding: 28px 48px 56px; }
    @media (max-width: 767px) { .dash-container { padding: 20px 20px 48px; } }

    /* ── Stats Grid ──────────────────────────────────────── */
    .stats-grid {
        display: grid; grid-template-columns: repeat(4, 1fr); gap: 16px; margin-bottom: 24px;
    }
    @media (max-width: 900px) { .stats-grid { grid-template-columns: repeat(2, 1fr); } }
    @media (max-width: 480px) { .stats-grid { grid-template-columns: 1fr 1fr; } }

    .stat-card {
        background: #fff; border: 1px solid #e1e3e4; border-radius: 8px;
        padding: 20px; display: flex; flex-direction: column; gap: 10px;
        transition: box-shadow 0.18s ease, transform 0.18s ease;
    }
    .stat-card:hover { box-shadow: 0 4px 16px rgba(14,25,62,0.09); transform: translateY(-1px); }
    .stat-card-top { display: flex; align-items: flex-start; justify-content: space-between; }
    .stat-label { font-size: 11px; font-weight: 600; color: #76767f; text-transform: uppercase; letter-spacing: 0.09em; }
    .stat-icon {
        width: 34px; height: 34px; border-radius: 7px; flex-shrink: 0;
        display: flex; align-items: center; justify-content: center;
    }
    .stat-icon .material-symbols-outlined { font-size: 17px; font-variation-settings: 'FILL' 1, 'wght' 400, 'GRAD' 0, 'opsz' 20; }
    .icon-blue   { background-color: #e8eaf6; color: #283593; }
    .icon-green  { background-color: #e8f5e9; color: #2e7d32; }
    .icon-amber  { background-color: #fff3e0; color: #e65100; }
    .icon-gray   { background-color: #f3f4f5; color: #45464e; }
    .stat-value  { font-family: 'Epilogue', sans-serif; font-size: 34px; font-weight: 700; color: #0e193e; line-height: 1; }
    .stat-sub    { font-size: 12px; color: #76767f; }

    /* ── Main Grid ───────────────────────────────────────── */
    .dash-grid { display: grid; grid-template-columns: 2fr 1fr; gap: 20px; align-items: start; }
    @media (max-width: 860px) { .dash-grid { grid-template-columns: 1fr; } }

    /* ── Card shell ──────────────────────────────────────── */
    .card { background: #fff; border: 1px solid #e1e3e4; border-radius: 8px; }
    .card-header {
        display: flex; align-items: center; justify-content: space-between;
        padding: 15px 20px; border-bottom: 1px solid #e1e3e4;
    }
    .card-header-left { display: flex; align-items: center; gap: 9px; }
    .card-header .material-symbols-outlined {
        font-size: 17px; color: #242e54;
        font-variation-settings: 'FILL' 1, 'wght' 400, 'GRAD' 0, 'opsz' 20;
    }
    .card-title { font-family: 'Epilogue', sans-serif; font-size: 14px; font-weight: 700; color: #0e193e; }
    .card-link   { font-size: 12px; font-weight: 600; color: #45464e; text-decoration: underline; text-underline-offset: 3px; transition: color 0.15s; }
    .card-link:hover { color: #0e193e; }

    /* ── Articles Table ──────────────────────────────────── */
    .art-table { width: 100%; border-collapse: collapse; font-size: 13.5px; }
    .art-table th {
        padding: 9px 16px; text-align: left; font-size: 11px; font-weight: 600;
        color: #76767f; text-transform: uppercase; letter-spacing: 0.09em;
        background-color: #f8f9fa; border-bottom: 1px solid #e1e3e4; white-space: nowrap;
    }
    .art-table td { padding: 12px 16px; border-bottom: 1px solid #f0f2f5; vertical-align: middle; }
    .art-table tbody tr:last-child td { border-bottom: none; }
    .art-table tbody tr:hover { background-color: #fafbfc; }
    .art-title  { font-weight: 600; color: #0e193e; line-height: 1.35; max-width: 260px; }
    .art-cat    { font-size: 12px; color: #76767f; margin-top: 2px; }
    .art-date   { font-size: 12.5px; color: #76767f; white-space: nowrap; }

    /* Status badges */
    .badge {
        display: inline-flex; align-items: center; gap: 4px;
        padding: 3px 9px; border-radius: 20px; font-size: 11.5px; font-weight: 600;
        white-space: nowrap; letter-spacing: 0.02em;
    }
    .badge .material-symbols-outlined { font-size: 12px; font-variation-settings: 'FILL' 1, 'wght' 500, 'GRAD' 0, 'opsz' 20; }
    .badge-published { background-color: #e8f5e9; color: #2e7d32; }
    .badge-draft     { background-color: #e3f2fd; color: #1565c0; }
    .badge-pending   { background-color: #fff3e0; color: #e65100; }
    .badge-rejected  { background-color: #fce4ec; color: #c62828; }

    /* Action button */
    .btn-table-action {
        display: inline-flex; align-items: center; justify-content: center;
        width: 30px; height: 30px; border-radius: 5px; border: none;
        background: transparent; color: #76767f;
        transition: background-color 0.15s ease, color 0.15s ease;
    }
    .btn-table-action:hover { background-color: #e8eaf6; color: #0e193e; }
    .btn-table-action .material-symbols-outlined { font-size: 17px; font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 20; }

    /* Empty state */
    .empty-state { padding: 48px 24px; text-align: center; color: #76767f; }
    .empty-state .material-symbols-outlined { font-size: 36px; display: block; margin-bottom: 10px; opacity: 0.3; }
    .empty-state p { font-size: 14px; margin-bottom: 16px; }
    .btn-empty { display: inline-flex; align-items: center; gap: 6px; padding: 8px 18px; background-color: #0e193e; color: #fff; border-radius: 5px; font-size: 12px; font-weight: 600; text-transform: uppercase; letter-spacing: 0.07em; transition: opacity 0.15s; }
    .btn-empty:hover { opacity: 0.85; }

    /* ── Sidebar Cards ───────────────────────────────────── */
    .sidebar-stack { display: flex; flex-direction: column; gap: 16px; }

    /* Profile card */
    .profile-card { background: #fff; border: 1px solid #e1e3e4; border-radius: 8px; padding: 24px; text-align: center; }
    .profile-avatar {
        width: 62px; height: 62px; border-radius: 50%;
        background-color: #00695c; display: flex; align-items: center; justify-content: center;
        margin: 0 auto 14px;
        font-family: 'Epilogue', sans-serif; font-size: 20px; font-weight: 700; color: #fff;
    }
    .profile-name   { font-family: 'Epilogue', sans-serif; font-size: 16px; font-weight: 700; color: #0e193e; margin-bottom: 3px; }
    .profile-email  { font-size: 12.5px; color: #76767f; margin-bottom: 12px; }
    .profile-bio    {
        font-size: 13px; color: #45464e; line-height: 1.55; margin-bottom: 16px;
        display: -webkit-box; -webkit-line-clamp: 3; -webkit-box-orient: vertical; overflow: hidden;
    }
    .profile-divider { border: none; border-top: 1px solid #f0f2f5; margin: 0 0 14px; }
    .btn-outline-sm {
        display: block; width: 100%; padding: 8px 14px;
        border: 1px solid #c6c5cf; border-radius: 5px;
        font-size: 12px; font-weight: 600; color: #45464e; text-align: center;
        text-transform: uppercase; letter-spacing: 0.07em;
        transition: background-color 0.15s ease, color 0.15s ease;
    }
    .btn-outline-sm:hover { background-color: #f3f4f5; color: #0e193e; }

    /* Quick actions card */
    .actions-card { background: #fff; border: 1px solid #e1e3e4; border-radius: 8px; padding: 18px 20px; }
    .actions-label { font-size: 10.5px; font-weight: 600; color: #76767f; text-transform: uppercase; letter-spacing: 0.1em; margin-bottom: 12px; }
    .btn-primary-full {
        display: flex; align-items: center; justify-content: center; gap: 7px; width: 100%;
        padding: 10px 16px; background-color: #0e193e; color: #fff; border: none; border-radius: 5px;
        font-family: 'Work Sans', sans-serif; font-size: 12px; font-weight: 600;
        text-transform: uppercase; letter-spacing: 0.08em; margin-bottom: 8px;
        transition: background-color 0.15s ease;
    }
    .btn-primary-full:hover { background-color: #242e54; }
    .btn-primary-full .material-symbols-outlined { font-size: 16px; font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 20; }
    .action-link {
        display: flex; align-items: center; gap: 9px; padding: 9px 8px; border-radius: 5px;
        font-size: 13.5px; font-weight: 500; color: #45464e;
        transition: background-color 0.15s ease, color 0.15s ease;
    }
    .action-link:hover { background-color: #f3f4f5; color: #0e193e; }
    .action-link .material-symbols-outlined { font-size: 18px; color: #76767f; }
    .action-link:hover .material-symbols-outlined { color: #0e193e; }
    </style>
</head>
<body>

    <!-- ── Member Topbar ────────────────────────────────────────── -->
    <header class="member-topbar">
        <a href="<%= cp %>/" class="topbar-back">
            <span class="material-symbols-outlined">arrow_back</span>
            View Site
        </a>
        <div class="topbar-brand">Thoughts of Nomads</div>
        <div class="topbar-user">
            <span class="topbar-name"><%= fullName %></span>
            <div class="topbar-avatar"><%= initials %></div>
            <a href="<%= cp %>/auth/logout" class="topbar-logout" title="Sign out">
                <span class="material-symbols-outlined">logout</span>
            </a>
        </div>
    </header>

    <!-- ── Welcome Hero ─────────────────────────────────────────── -->
    <section class="dash-hero">
        <div class="dash-hero-inner">
            <div class="hero-avatar"><%= initials %></div>
            <div class="hero-text">
                <h1 class="hero-greeting">Welcome back, <%= firstName %>!</h1>
                <div class="hero-meta">
                    <span class="hero-chip">Contributor</span>
                    <% if (!joinedDate.isEmpty()) { %>
                    <span>Member since <%= joinedDate %></span>
                    <% } %>
                </div>
            </div>
            <div class="hero-actions">
                <a href="<%= cp %>/member/articles/new" class="btn-hero-primary">
                    <span class="material-symbols-outlined">edit_document</span>
                    New Article
                </a>
            </div>
        </div>
    </section>

    <div class="dash-container">

        <!-- ── Stats ────────────────────────────────────────────── -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-card-top">
                    <span class="stat-label">Total Articles</span>
                    <div class="stat-icon icon-blue"><span class="material-symbols-outlined">article</span></div>
                </div>
                <div class="stat-value"><%= statTotal %></div>
                <div class="stat-sub">All time</div>
            </div>
            <div class="stat-card">
                <div class="stat-card-top">
                    <span class="stat-label">Published</span>
                    <div class="stat-icon icon-green"><span class="material-symbols-outlined">check_circle</span></div>
                </div>
                <div class="stat-value"><%= statPublished %></div>
                <div class="stat-sub">Live on site</div>
            </div>
            <div class="stat-card">
                <div class="stat-card-top">
                    <span class="stat-label">In Review</span>
                    <div class="stat-icon icon-amber"><span class="material-symbols-outlined">pending_actions</span></div>
                </div>
                <div class="stat-value"><%= statPending %></div>
                <div class="stat-sub">Awaiting approval</div>
            </div>
            <div class="stat-card">
                <div class="stat-card-top">
                    <span class="stat-label">Drafts</span>
                    <div class="stat-icon icon-gray"><span class="material-symbols-outlined">draft</span></div>
                </div>
                <div class="stat-value"><%= statDraft %></div>
                <div class="stat-sub">In progress</div>
            </div>
        </div>

        <!-- ── Main Grid ─────────────────────────────────────────── -->
        <div class="dash-grid">

            <!-- Recent Articles -->
            <div class="card">
                <div class="card-header">
                    <div class="card-header-left">
                        <span class="material-symbols-outlined">history</span>
                        <span class="card-title">Recent Articles</span>
                    </div>
                    <a href="<%= cp %>/member/articles" class="card-link">View all</a>
                </div>

                <% if (recent == null || recent.isEmpty()) { %>
                <div class="empty-state">
                    <span class="material-symbols-outlined">edit_document</span>
                    <p>You haven't written anything yet.</p>
                    <a href="<%= cp %>/member/articles/new" class="btn-empty">
                        <span class="material-symbols-outlined">add</span>
                        Write your first article
                    </a>
                </div>
                <% } else { %>
                <div style="overflow-x:auto;">
                    <table class="art-table">
                        <thead>
                            <tr>
                                <th>Article</th>
                                <th>Status</th>
                                <th>Updated</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                        <% for (Article art : recent) {
                               String statusClass = "badge-" + art.getStatus().toLowerCase();
                               String statusIcon  = art.isPublished() ? "check_circle"
                                                  : art.isPending()   ? "schedule"
                                                  : art.isRejected()  ? "cancel"
                                                  :                     "edit_note";
                        %>
                            <tr>
                                <td>
                                    <div class="art-title"><%= art.getTitle() %></div>
                                    <% if (art.getCategoryName() != null) { %>
                                    <div class="art-cat">
                                        <span class="material-symbols-outlined" style="font-size:12px;vertical-align:middle;">folder_open</span>
                                        <%= art.getCategoryName() %>
                                    </div>
                                    <% } %>
                                </td>
                                <td>
                                    <span class="badge <%= statusClass %>">
                                        <span class="material-symbols-outlined"><%= statusIcon %></span>
                                        <%= art.getStatusLabel() %>
                                    </span>
                                </td>
                                <td class="art-date">
                                    <%= art.getUpdatedAt() != null ? dateFmt.format(art.getUpdatedAt()) : "—" %>
                                </td>
                                <td>
                                    <a href="<%= cp %>/member/articles/edit?id=<%= art.getArticleId() %>"
                                       class="btn-table-action" title="Edit">
                                        <span class="material-symbols-outlined">edit</span>
                                    </a>
                                </td>
                            </tr>
                        <% } %>
                        </tbody>
                    </table>
                </div>
                <% } %>
            </div>

            <!-- Sidebar -->
            <div class="sidebar-stack">

                <!-- Profile card -->
                <div class="profile-card">
                    <div class="profile-avatar"><%= initials %></div>
                    <div class="profile-name"><%= fullName %></div>
                    <div class="profile-email"><%= user.getEmail() %></div>
                    <% if (bio != null && !bio.isBlank()) { %>
                    <p class="profile-bio"><%= bio %></p>
                    <% } %>
                    <hr class="profile-divider"/>
                    <a href="<%= cp %>/member/profile" class="btn-outline-sm">Edit Profile</a>
                </div>

                <!-- Quick actions -->
                <div class="actions-card">
                    <p class="actions-label">Quick Actions</p>
                    <a href="<%= cp %>/member/articles/new" class="btn-primary-full">
                        <span class="material-symbols-outlined">add</span>
                        Write New Article
                    </a>
                    <a href="<%= cp %>/member/articles" class="action-link">
                        <span class="material-symbols-outlined">article</span>
                        My Articles
                    </a>
                    <a href="<%= cp %>/member/profile" class="action-link">
                        <span class="material-symbols-outlined">manage_accounts</span>
                        Profile Settings
                    </a>
                    <a href="<%= cp %>/" class="action-link">
                        <span class="material-symbols-outlined">public</span>
                        View Live Site
                    </a>
                    <a href="<%= cp %>/auth/logout" class="action-link" style="color:#c62828;">
                        <span class="material-symbols-outlined" style="color:#c62828;">logout</span>
                        Sign Out
                    </a>
                </div>

            </div><!-- sidebar -->

        </div><!-- dash-grid -->

    </div><!-- dash-container -->


</body>
</html>
