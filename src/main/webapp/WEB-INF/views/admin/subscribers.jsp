<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.thoughtsofnomads.model.User, com.thoughtsofnomads.model.Subscriber,
                 com.thoughtsofnomads.model.Article, java.util.List, java.text.SimpleDateFormat" %>
<%
    User   user        = (User) session.getAttribute("user");
    String userInitial = (user != null && user.getEmail() != null)
        ? String.valueOf(user.getEmail().charAt(0)).toUpperCase() : "A";

    List<Subscriber> subscribers = (List<Subscriber>) request.getAttribute("subscribers");
    List<Article>  allPublished  = (List<Article>)   request.getAttribute("allPublished");
    int subCount                 = (Integer)          request.getAttribute("subCount");

    String flashSuccess = (String) session.getAttribute("flashSuccess");
    String flashError   = (String) session.getAttribute("flashError");
    if (flashSuccess != null) session.removeAttribute("flashSuccess");
    if (flashError   != null) session.removeAttribute("flashError");

    SimpleDateFormat fmt = new SimpleDateFormat("MMM d, yyyy");
    String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Subscribers — Admin | Thoughts of Nomads</title>
    <link href="https://fonts.googleapis.com/css2?family=Epilogue:wght@400;600;700&family=Work+Sans:wght@400;500;600&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" rel="stylesheet"/>
    <style>
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
    body { font-family: 'Work Sans', sans-serif; background-color: #f0f2f5; color: #191c1d; -webkit-font-smoothing: antialiased; }
    a { text-decoration: none; color: inherit; }
    button { cursor: pointer; font-family: inherit; }
    select { font-family: inherit; }
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
    .topbar-profile-name { font-size: 14px; font-weight: 600; color: #0e193e; line-height: 1.3; }
    .topbar-profile-role { font-size: 11px; color: #76767f; text-transform: uppercase; letter-spacing: 0.09em; text-align:right; }
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

    /* Stats */
    .stat-card {
        background: #fff; border: 1px solid #e1e3e4; border-radius: 10px;
        padding: 20px 24px; display: flex; align-items: center; gap: 16px;
        margin-bottom: 28px; width: fit-content;
    }
    .stat-icon { width: 44px; height: 44px; border-radius: 10px; background: #eef0f8; display: flex; align-items: center; justify-content: center; }
    .stat-icon .material-symbols-outlined { font-size: 22px; color: #0e193e; font-variation-settings: 'FILL' 1, 'wght' 400, 'GRAD' 0, 'opsz' 24; }
    .stat-value { font-family: 'Epilogue', sans-serif; font-size: 28px; font-weight: 700; color: #0e193e; line-height: 1; }
    .stat-label { font-size: 12px; color: #76767f; margin-top: 3px; }

    /* Two-col layout */
    .page-grid { display: grid; grid-template-columns: 1fr 360px; gap: 24px; align-items: start; }
    @media (max-width: 1100px) { .page-grid { grid-template-columns: 1fr; } }

    /* Table */
    .table-card { background: #fff; border: 1px solid #e1e3e4; border-radius: 10px; overflow: hidden; }
    .table-wrap { overflow-x: auto; }
    table { width: 100%; border-collapse: collapse; }
    thead { background: #f8f9fa; }
    th { padding: 11px 16px; text-align: left; font-size: 11px; font-weight: 700; color: #76767f; text-transform: uppercase; letter-spacing: 0.08em; border-bottom: 1px solid #e1e3e4; white-space: nowrap; }
    td { padding: 13px 16px; font-size: 13.5px; color: #2d2f31; border-bottom: 1px solid #f0f2f5; vertical-align: middle; }
    tr:last-child td { border-bottom: none; }
    tbody tr:hover { background: #fafbfc; }

    .email-cell { font-weight: 500; color: #0e193e; }

    .btn-delete {
        display: inline-flex; align-items: center; gap: 4px;
        padding: 5px 12px; border-radius: 6px; border: 1px solid #ef9a9a;
        background: #fce4ec; color: #c62828; font-size: 12px; font-weight: 600;
        transition: background 0.15s;
    }
    .btn-delete:hover { background: #f8bbd0; }
    .btn-delete .material-symbols-outlined { font-size: 14px; }

    /* Send newsletter panel */
    .send-panel { background: #fff; border: 1px solid #e1e3e4; border-radius: 10px; overflow: hidden; }
    .send-panel-header {
        padding: 14px 20px; border-bottom: 1px solid #f0f1f3;
        display: flex; align-items: center; gap: 8px;
        font-size: 11px; font-weight: 700; letter-spacing: 0.1em; text-transform: uppercase; color: #45464e;
    }
    .send-panel-header .material-symbols-outlined { font-size: 17px; color: #76767f; }
    .send-panel-body { padding: 20px; }
    .send-label { font-size: 13px; font-weight: 600; color: #191c1d; margin-bottom: 8px; display: block; }
    .send-hint  { font-size: 12px; color: #76767f; margin-bottom: 16px; line-height: 1.5; }

    .article-select {
        width: 100%; padding: 10px 12px; border-radius: 8px;
        border: 1px solid #d0d2d8; font-size: 13px; color: #191c1d;
        outline: none; margin-bottom: 14px; background: #fff;
        transition: border-color 0.15s;
    }
    .article-select:focus { border-color: #0e193e; }

    .btn-send {
        display: flex; align-items: center; justify-content: center; gap: 7px;
        width: 100%; padding: 11px 16px; border-radius: 8px; border: none;
        background: #0e193e; color: #fff; font-size: 13px; font-weight: 600;
        transition: background 0.15s;
    }
    .btn-send:hover { background: #1a2d5a; }
    .btn-send:disabled { background: #c6c8d0; cursor: not-allowed; }
    .btn-send .material-symbols-outlined { font-size: 17px; }

    /* Empty state */
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
            <span class="topbar-title">Subscribers</span>
            <div class="topbar-profile">
                <div>
                    <div class="topbar-profile-name">System Admin</div>
                    <div class="topbar-profile-role">Administrator</div>
                </div>
                <div class="topbar-avatar"><%= userInitial %></div>
            </div>
        </header>

        <main class="admin-main">

            <div class="admin-page-header">
                <h1 class="admin-page-title">Newsletter Subscribers</h1>
                <p class="admin-page-subtitle">Manage your subscriber list and send newsletters.</p>
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

            <!-- Stat -->
            <div class="stat-card">
                <div class="stat-icon"><span class="material-symbols-outlined">mail</span></div>
                <div>
                    <div class="stat-value"><%= subCount %></div>
                    <div class="stat-label">Active Subscriber<%= subCount == 1 ? "" : "s" %></div>
                </div>
            </div>

            <div class="page-grid">

                <!-- Subscriber table -->
                <div class="table-card">
                    <% if (subscribers == null || subscribers.isEmpty()) { %>
                    <div class="empty-state">
                        <div class="empty-icon"><span class="material-symbols-outlined">mail_outline</span></div>
                        <div class="empty-title">No subscribers yet</div>
                        <p>Subscribers will appear here once people sign up via the newsletter form.</p>
                    </div>
                    <% } else { %>
                    <div class="table-wrap">
                        <table>
                            <thead>
                                <tr>
                                    <th>Email</th>
                                    <th>Subscribed</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                                <% for (Subscriber s : subscribers) { %>
                                <tr>
                                    <td class="email-cell"><%= s.getEmail() %></td>
                                    <td style="font-size:13px;color:#76767f;white-space:nowrap;">
                                        <%= s.getSubscribedAt() != null ? fmt.format(s.getSubscribedAt()) : "—" %>
                                    </td>
                                    <td>
                                        <form method="post" action="<%= cp %>/admin/subscribers"
                                              onsubmit="return confirm('Remove this subscriber?')">
                                            <input type="hidden" name="action" value="delete"/>
                                            <input type="hidden" name="id" value="<%= s.getSubscriberId() %>"/>
                                            <button class="btn-delete" type="submit">
                                                <span class="material-symbols-outlined">delete</span>
                                                Remove
                                            </button>
                                        </form>
                                    </td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                    <% } %>
                </div>

                <!-- Send newsletter panel -->
                <div class="send-panel">
                    <div class="send-panel-header">
                        <span class="material-symbols-outlined">send</span>
                        Send Newsletter
                    </div>
                    <div class="send-panel-body">
                        <span class="send-label">Pick an article</span>
                        <p class="send-hint">Choose a published article and send it as an email newsletter to all <%= subCount %> subscriber<%= subCount == 1 ? "" : "s" %>.</p>
                        <% if (allPublished == null || allPublished.isEmpty()) { %>
                        <p style="font-size:13px;color:#76767f;">No published articles available.</p>
                        <% } else { %>
                        <form method="post" action="<%= cp %>/admin/subscribers">
                            <input type="hidden" name="action" value="send"/>
                            <select class="article-select" name="articleId" required>
                                <option value="">— Select an article —</option>
                                <% for (Article a : allPublished) { %>
                                <option value="<%= a.getArticleId() %>"><%= a.getTitle() %></option>
                                <% } %>
                            </select>
                            <button class="btn-send" type="submit" <%= subCount == 0 ? "disabled" : "" %>>
                                <span class="material-symbols-outlined">send</span>
                                Send to All Subscribers
                            </button>
                        </form>
                        <% } %>
                    </div>
                </div>

            </div>
        </main>
    </div>
</div>
</body>
</html>
