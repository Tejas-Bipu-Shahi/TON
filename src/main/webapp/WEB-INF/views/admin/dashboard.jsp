<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.thoughtsofnomads.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    String userInitial = (user != null && user.getEmail() != null)
        ? String.valueOf(user.getEmail().charAt(0)).toUpperCase()
        : "A";
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
    /* ── Resets ──────────────────────────────────────────────── */
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

    /* ── Shell ───────────────────────────────────────────────── */
    .admin-shell {
        display: flex;
        min-height: 100vh;
    }

    .admin-content {
        flex: 1;
        display: flex;
        flex-direction: column;
        min-width: 0;
    }

    /* ── Top Bar ─────────────────────────────────────────────── */
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

    .topbar-title {
        font-family: 'Epilogue', sans-serif;
        font-size: 20px;
        font-weight: 700;
        color: #0e193e;
        letter-spacing: -0.01em;
    }

    .topbar-profile {
        display: flex;
        align-items: center;
        gap: 12px;
    }

    .topbar-profile-info { text-align: right; }

    .topbar-profile-name {
        font-size: 14px;
        font-weight: 600;
        color: #0e193e;
        line-height: 1.3;
    }

    .topbar-profile-role {
        font-size: 11px;
        color: #76767f;
        text-transform: uppercase;
        letter-spacing: 0.09em;
    }

    .topbar-avatar {
        width: 38px;
        height: 38px;
        border-radius: 50%;
        background-color: #242e54;
        display: flex;
        align-items: center;
        justify-content: center;
        color: #ffffff;
        font-weight: 700;
        font-size: 14px;
        flex-shrink: 0;
        font-family: 'Epilogue', sans-serif;
    }

    /* ── Main Area ───────────────────────────────────────────── */
    .admin-main {
        flex: 1;
        padding: 36px;
    }

    .admin-page-header {
        margin-bottom: 28px;
    }

    .admin-page-title {
        font-family: 'Epilogue', sans-serif;
        font-size: 26px;
        font-weight: 700;
        color: #0e193e;
        margin-bottom: 4px;
    }

    .admin-page-subtitle {
        font-size: 14px;
        color: #45464e;
    }

    /* ── Metric Cards ────────────────────────────────────────── */
    .metrics-grid {
        display: grid;
        grid-template-columns: repeat(4, 1fr);
        gap: 20px;
        margin-bottom: 36px;
    }

    @media (max-width: 1100px) { .metrics-grid { grid-template-columns: repeat(2, 1fr); } }
    @media (max-width: 560px)  { .metrics-grid { grid-template-columns: 1fr; } }

    .metric-card {
        background-color: #ffffff;
        border: 1px solid #e1e3e4;
        border-radius: 10px;
        padding: 22px 24px;
        display: flex;
        flex-direction: column;
        gap: 14px;
        transition: box-shadow 0.2s ease, transform 0.2s ease;
    }

    .metric-card:hover {
        box-shadow: 0 4px 20px rgba(14,25,62,0.09);
        transform: translateY(-1px);
    }

    .metric-card-top {
        display: flex;
        align-items: flex-start;
        justify-content: space-between;
    }

    .metric-label {
        font-size: 11px;
        font-weight: 600;
        color: #76767f;
        text-transform: uppercase;
        letter-spacing: 0.1em;
    }

    .metric-icon {
        width: 38px;
        height: 38px;
        border-radius: 8px;
        display: flex;
        align-items: center;
        justify-content: center;
        flex-shrink: 0;
    }

    .metric-icon .material-symbols-outlined {
        font-size: 20px;
        font-variation-settings: 'FILL' 1, 'wght' 400, 'GRAD' 0, 'opsz' 20;
    }

    .icon-blue   { background-color: #e8eaf6; color: #242e54; }
    .icon-amber  { background-color: #fff8e1; color: #e65100; }
    .icon-green  { background-color: #e8f5e9; color: #2e7d32; }
    .icon-violet { background-color: #f3e5f5; color: #6a1b9a; }

    .metric-value {
        font-family: 'Epilogue', sans-serif;
        font-size: 38px;
        font-weight: 700;
        color: #0e193e;
        line-height: 1;
    }

    .metric-footer {
        display: flex;
        align-items: center;
        gap: 4px;
        font-size: 12px;
        color: #76767f;
        padding-top: 6px;
        border-top: 1px solid #f0f2f5;
    }

    .metric-footer.positive { color: #2e7d32; }

    .metric-footer .material-symbols-outlined {
        font-size: 14px;
        font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 20;
    }
    </style>
</head>
<body>
<div class="admin-shell">

    <jsp:include page="/WEB-INF/views/admin/includes/sidebar.jsp"/>

    <div class="admin-content">

        <!-- Top Bar -->
        <header class="admin-topbar">
            <span class="topbar-title">Overview</span>
            <div class="topbar-profile">
                <div class="topbar-profile-info">
                    <div class="topbar-profile-name">System Admin</div>
                    <div class="topbar-profile-role">Administrator</div>
                </div>
                <div class="topbar-avatar"><%= userInitial %></div>
            </div>
        </header>

        <!-- Main -->
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
                    <div class="metric-value">128</div>
                    <div class="metric-footer positive">
                        <span class="material-symbols-outlined">trending_up</span>
                        +12 this month
                    </div>
                </div>

                <div class="metric-card">
                    <div class="metric-card-top">
                        <span class="metric-label">Pending Review</span>
                        <div class="metric-icon icon-amber">
                            <span class="material-symbols-outlined">pending_actions</span>
                        </div>
                    </div>
                    <div class="metric-value">7</div>
                    <div class="metric-footer">
                        <span class="material-symbols-outlined">schedule</span>
                        Awaiting approval
                    </div>
                </div>

                <div class="metric-card">
                    <div class="metric-card-top">
                        <span class="metric-label">Total Contributors</span>
                        <div class="metric-icon icon-green">
                            <span class="material-symbols-outlined">group</span>
                        </div>
                    </div>
                    <div class="metric-value">34</div>
                    <div class="metric-footer positive">
                        <span class="material-symbols-outlined">trending_up</span>
                        +3 this week
                    </div>
                </div>

                <div class="metric-card">
                    <div class="metric-card-top">
                        <span class="metric-label">Total Categories</span>
                        <div class="metric-icon icon-violet">
                            <span class="material-symbols-outlined">folder_open</span>
                        </div>
                    </div>
                    <div class="metric-value">12</div>
                    <div class="metric-footer">
                        <span class="material-symbols-outlined">layers</span>
                        Across all content
                    </div>
                </div>

            </div>
        </main>

    </div>
</div>
</body>
</html>
