<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.thoughtsofnomads.model.User, com.thoughtsofnomads.model.UserProfile,
                 com.thoughtsofnomads.model.Article, java.util.List, java.text.SimpleDateFormat" %>
<%
    User        user    = (User)        session.getAttribute("user");
    UserProfile profile = (UserProfile) request.getAttribute("userProfile");
    List<Article> articles = (List<Article>) request.getAttribute("articles");

    String fullName = (profile != null && profile.getFullName() != null) ? profile.getFullName() : "Contributor";
    String initials = (profile != null) ? profile.getInitials() : "?";

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
    <title>My Articles — Thoughts of Nomads</title>
    <link href="https://fonts.googleapis.com/css2?family=Epilogue:wght@400;600;700&family=Work+Sans:wght@400;500;600&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" rel="stylesheet"/>
    <style>
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
    body { font-family: 'Work Sans', sans-serif; background-color: #f8f9fa; color: #191c1d; -webkit-font-smoothing: antialiased; min-height: 100vh; display: flex; flex-direction: column; }
    a { text-decoration: none; color: inherit; }
    button { cursor: pointer; font-family: inherit; }
    .material-symbols-outlined { font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24; vertical-align: middle; line-height: 1; }

    /* Topbar */
    .member-topbar {
        position: sticky; top: 0; z-index: 100;
        background: #fff; border-bottom: 1px solid #e1e3e4;
        height: 56px; display: flex; align-items: center;
        justify-content: space-between; padding: 0 48px; gap: 16px; flex-shrink: 0;
    }
    @media (max-width: 767px) { .member-topbar { padding: 0 20px; } }
    .topbar-back {
        display: inline-flex; align-items: center; gap: 6px;
        padding: 6px 14px; border-radius: 20px;
        border: 1px solid #e1e3e4; background: #f8f9fa;
        font-size: 12px; font-weight: 600; color: #45464e;
        text-transform: uppercase; letter-spacing: 0.07em;
        transition: background-color 0.15s, color 0.15s, border-color 0.15s; white-space: nowrap;
    }
    .topbar-back:hover { background: #0e193e; color: #fff; border-color: #0e193e; }
    .topbar-back .material-symbols-outlined { font-size: 15px; }
    .topbar-brand { font-family: 'Epilogue', sans-serif; font-size: 15px; font-weight: 700; color: #0e193e; text-transform: uppercase; letter-spacing: 0.1em; position: absolute; left: 50%; transform: translateX(-50%); }
    @media (max-width: 600px) { .topbar-brand { display: none; } }
    .topbar-user { display: flex; align-items: center; gap: 10px; }
    .topbar-name { font-size: 13px; font-weight: 600; color: #0e193e; }
    @media (max-width: 480px) { .topbar-name { display: none; } }
    .topbar-avatar { width: 32px; height: 32px; border-radius: 50%; background-color: #00695c; flex-shrink: 0; display: flex; align-items: center; justify-content: center; font-family: 'Epilogue', sans-serif; font-size: 11px; font-weight: 700; color: #fff; }
    .topbar-logout { display: flex; align-items: center; justify-content: center; width: 32px; height: 32px; border-radius: 6px; color: #76767f; transition: background-color 0.15s, color 0.15s; }
    .topbar-logout:hover { background: #fce4ec; color: #c62828; }
    .topbar-logout .material-symbols-outlined { font-size: 18px; }

    /* Main */
    .main-container { flex: 1; max-width: 900px; margin: 0 auto; padding: 32px 48px 60px; width: 100%; }
    @media (max-width: 767px) { .main-container { padding: 20px 20px 60px; } }

    .page-header {
        display: flex; align-items: center; justify-content: space-between;
        margin-bottom: 24px; flex-wrap: wrap; gap: 12px;
    }
    .page-title { font-family: 'Epilogue', sans-serif; font-size: 24px; font-weight: 700; color: #0e193e; }
    .btn-new {
        display: inline-flex; align-items: center; gap: 7px;
        padding: 9px 18px; border-radius: 8px;
        background: #0e193e; color: #fff;
        font-size: 13px; font-weight: 600;
        transition: background-color 0.15s;
    }
    .btn-new:hover { background: #1a2d5a; }
    .btn-new .material-symbols-outlined { font-size: 17px; }

    /* Flash */
    .flash-success {
        background: #e8f5e9; border: 1px solid #a5d6a7; border-radius: 8px;
        padding: 12px 16px; display: flex; align-items: center; gap: 10px;
        font-size: 14px; color: #2e7d32; margin-bottom: 20px;
    }
    .flash-success .material-symbols-outlined { font-size: 20px; flex-shrink: 0; }

    /* Cards */
    .article-list { display: flex; flex-direction: column; gap: 12px; }

    .article-item {
        background: #fff; border: 1px solid #e1e3e4; border-radius: 10px;
        padding: 18px 20px; transition: box-shadow 0.15s;
    }
    .article-item:hover { box-shadow: 0 2px 12px rgba(14,25,62,0.08); }

    .article-item-top { display: flex; align-items: flex-start; justify-content: space-between; gap: 12px; margin-bottom: 8px; }
    .article-item-title { font-family: 'Epilogue', sans-serif; font-size: 16px; font-weight: 700; color: #0e193e; line-height: 1.35; }
    .article-item-meta { display: flex; align-items: center; gap: 14px; flex-wrap: wrap; font-size: 12.5px; color: #76767f; margin-bottom: 10px; }
    .meta-sep { width: 3px; height: 3px; border-radius: 50%; background: #c0c2c8; flex-shrink: 0; }

    /* Badges */
    .badge { display: inline-flex; align-items: center; gap: 5px; padding: 3px 10px; border-radius: 20px; font-size: 11.5px; font-weight: 600; white-space: nowrap; }
    .badge-dot { width: 6px; height: 6px; border-radius: 50%; flex-shrink: 0; }
    .badge-pending   { background: #fff8e1; color: #e65100; }
    .badge-pending .badge-dot   { background: #e65100; }
    .badge-published { background: #e8f5e9; color: #2e7d32; }
    .badge-published .badge-dot { background: #2e7d32; }
    .badge-rejected  { background: #fce4ec; color: #c62828; }
    .badge-rejected .badge-dot  { background: #c62828; }
    .badge-draft     { background: #f3f4f6; color: #5a5d63; }
    .badge-draft .badge-dot     { background: #9b9ea4; }

    /* Rejection note */
    .rejection-note {
        background: #fff5f5; border: 1px solid #ffc5c5; border-radius: 8px;
        padding: 12px 14px; margin-top: 10px;
        display: flex; gap: 10px; align-items: flex-start;
    }
    .rejection-note .material-symbols-outlined { font-size: 18px; color: #c62828; flex-shrink: 0; margin-top: 1px; }
    .rejection-note-body { flex: 1; }
    .rejection-note-label { font-size: 11px; font-weight: 700; color: #c62828; text-transform: uppercase; letter-spacing: 0.08em; margin-bottom: 4px; }
    .rejection-note-text { font-size: 13px; color: #5a5d63; line-height: 1.55; }

    /* Actions */
    .article-actions { display: flex; gap: 8px; flex-wrap: wrap; margin-top: 12px; }

    .btn-edit {
        display: inline-flex; align-items: center; gap: 5px;
        padding: 6px 14px; border-radius: 6px;
        background: #0e193e; color: #fff;
        font-size: 12px; font-weight: 600;
        transition: background-color 0.15s;
    }
    .btn-edit:hover { background: #1a2d5a; }
    .btn-edit .material-symbols-outlined { font-size: 14px; }

    .btn-resubmit {
        display: inline-flex; align-items: center; gap: 5px;
        padding: 6px 14px; border-radius: 6px;
        background: #e65100; color: #fff;
        font-size: 12px; font-weight: 600;
        transition: background-color 0.15s;
    }
    .btn-resubmit:hover { background: #bf360c; }
    .btn-resubmit .material-symbols-outlined { font-size: 14px; }

    /* Empty state */
    .empty-state { text-align: center; padding: 64px 32px; color: #76767f; }
    .empty-icon .material-symbols-outlined { font-size: 52px; color: #d0d2d8; font-variation-settings: 'FILL' 0, 'wght' 300, 'GRAD' 0, 'opsz' 48; }
    .empty-title { font-size: 17px; font-weight: 600; color: #45464e; margin: 14px 0 6px; }
    .empty-sub { font-size: 13px; }
    </style>
</head>
<body>

<nav class="member-topbar">
    <a href="<%= cp %>/member/dashboard" class="topbar-back">
        <span class="material-symbols-outlined">arrow_back</span>
        Dashboard
    </a>
    <span class="topbar-brand">Thoughts of Nomads</span>
    <div class="topbar-user">
        <span class="topbar-name"><%= fullName %></span>
        <div class="topbar-avatar"><%= initials %></div>
        <a href="<%= cp %>/auth/logout" class="topbar-logout" title="Sign out">
            <span class="material-symbols-outlined">logout</span>
        </a>
    </div>
</nav>

<div class="main-container">

    <div class="page-header">
        <h1 class="page-title">My Articles</h1>
        <a href="<%= cp %>/member/articles/new" class="btn-new">
            <span class="material-symbols-outlined">add</span>
            New Article
        </a>
    </div>

    <% if (flashSuccess != null) { %>
    <div class="flash-success">
        <span class="material-symbols-outlined">check_circle</span>
        <%= flashSuccess %>
    </div>
    <% } %>

    <% if (articles == null || articles.isEmpty()) { %>
    <div class="empty-state">
        <div class="empty-icon"><span class="material-symbols-outlined">article</span></div>
        <div class="empty-title">No articles yet</div>
        <div class="empty-sub">Start writing and submit your first article for review.</div>
    </div>
    <% } else { %>
    <div class="article-list">
    <% for (Article a : articles) {
           String badgeClass = "badge-" + a.getStatus().toLowerCase();
    %>
        <div class="article-item">
            <div class="article-item-top">
                <span class="article-item-title"><%= a.getTitle() %></span>
                <span class="badge <%= badgeClass %>">
                    <span class="badge-dot"></span>
                    <%= a.getStatusLabel() %>
                </span>
            </div>
            <div class="article-item-meta">
                <% if (a.getCategoryName() != null) { %>
                <span><span class="material-symbols-outlined" style="font-size:13px;vertical-align:middle;">folder_open</span> <%= a.getCategoryName() %></span>
                <span class="meta-sep"></span>
                <% } %>
                <span>Updated <%= a.getUpdatedAt() != null ? fmt.format(a.getUpdatedAt()) : "—" %></span>
            </div>

            <% if (a.isRejected() && a.getReviewNote() != null) { %>
            <div class="rejection-note">
                <span class="material-symbols-outlined">feedback</span>
                <div class="rejection-note-body">
                    <div class="rejection-note-label">Reviewer Feedback</div>
                    <div class="rejection-note-text"><%= a.getReviewNote() %></div>
                </div>
            </div>
            <% } %>

            <% if (a.isPending()) { %>
            <div class="article-actions">
                <span style="font-size:12.5px;color:#e65100;display:flex;align-items:center;gap:5px;">
                    <span class="material-symbols-outlined" style="font-size:15px;">hourglass_empty</span>
                    Awaiting review — no edits while under review
                </span>
            </div>
            <% } else if (a.isPublished()) { %>
            <div class="article-actions">
                <span style="font-size:12.5px;color:#2e7d32;display:flex;align-items:center;gap:5px;">
                    <span class="material-symbols-outlined" style="font-size:15px;">check_circle</span>
                    Published and live
                </span>
            </div>
            <% } else if (a.isDraft() || a.isRejected()) { %>
            <div class="article-actions">
                <a href="<%= cp %>/member/articles/edit?id=<%= a.getArticleId() %>" class="btn-edit">
                    <span class="material-symbols-outlined">edit</span>
                    Edit
                </a>
                <% if (a.isRejected()) { %>
                <a href="<%= cp %>/member/articles/edit?id=<%= a.getArticleId() %>" class="btn-resubmit">
                    <span class="material-symbols-outlined">replay</span>
                    Edit &amp; Resubmit
                </a>
                <% } %>
            </div>
            <% } %>
        </div>
    <% } %>
    </div>
    <% } %>

</div>
</body>
</html>
