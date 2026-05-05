<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.thoughtsofnomads.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Thoughts of Nomads</title>
    <link href="https://fonts.googleapis.com/css2?family=Epilogue:wght@400;600;700&family=Work+Sans:wght@400;600&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css" />
</head>
<body class="dashboard-layout">

    <jsp:include page="/WEB-INF/views/includes/header.jsp" />

    <main class="dashboard-main">
        <header class="dashboard-header">
            <h1 class="dashboard-title">Admin Dashboard</h1>
            <p class="dashboard-subtitle">Manage users, content, and site settings from here.</p>
        </header>

        <div class="dashboard-grid">
            <div class="dashboard-card">
                <span class="material-symbols-outlined dashboard-card-icon">group</span>
                <h2 class="dashboard-card-title">Manage Users</h2>
                <p class="dashboard-card-desc">View, edit, or remove registered contributors and their account statuses.</p>
                <button class="dashboard-btn-primary">View Users</button>
            </div>

            <div class="dashboard-card">
                <span class="material-symbols-outlined dashboard-card-icon">article</span>
                <h2 class="dashboard-card-title">Manage Posts</h2>
                <p class="dashboard-card-desc">Review and moderate all published and pending articles on the platform.</p>
                <button class="dashboard-btn-primary">View Posts</button>
            </div>

            <div class="dashboard-card">
                <span class="material-symbols-outlined dashboard-card-icon">bar_chart</span>
                <h2 class="dashboard-card-title">Site Analytics</h2>
                <p class="dashboard-card-desc">Monitor traffic, engagement, and other key metrics for the platform.</p>
                <button class="dashboard-btn-secondary">View Analytics</button>
            </div>

            <div class="dashboard-card">
                <span class="material-symbols-outlined dashboard-card-icon">settings</span>
                <h2 class="dashboard-card-title">Site Settings</h2>
                <p class="dashboard-card-desc">Configure global settings, categories, and platform preferences.</p>
                <button class="dashboard-btn-secondary">Open Settings</button>
            </div>
        </div>
    </main>

    <jsp:include page="/WEB-INF/views/includes/footer.jsp" />
</body>
</html>
