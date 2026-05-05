<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String cp = request.getContextPath();
    String forwardUri = (String) request.getAttribute("jakarta.servlet.forward.request_uri");
    String activePath = (forwardUri != null) ? forwardUri : request.getRequestURI();
    if (activePath.startsWith(cp)) activePath = activePath.substring(cp.length());
%>
<style>
/* ── Admin Sidebar ───────────────────────────────────────── */
.admin-sidebar {
    width: 256px;
    flex-shrink: 0;
    background-color: #1a213e;
    display: flex;
    flex-direction: column;
    height: 100vh;
    position: sticky;
    top: 0;
    overflow-y: auto;
}

.sidebar-brand {
    padding: 28px 20px 22px;
    border-bottom: 1px solid rgba(255,255,255,0.07);
}

.sidebar-brand-name {
    font-family: 'Epilogue', sans-serif;
    font-size: 15px;
    font-weight: 700;
    color: #ffffff;
    text-transform: uppercase;
    letter-spacing: 0.12em;
    line-height: 1.3;
}

.sidebar-brand-tag {
    margin-top: 5px;
    font-family: 'Work Sans', sans-serif;
    font-size: 10px;
    font-weight: 600;
    color: rgba(255,255,255,0.35);
    text-transform: uppercase;
    letter-spacing: 0.15em;
}

.sidebar-nav {
    flex: 1;
    padding: 12px 10px;
    display: flex;
    flex-direction: column;
}

.sidebar-section-label {
    font-family: 'Work Sans', sans-serif;
    font-size: 10px;
    font-weight: 600;
    color: rgba(255,255,255,0.28);
    text-transform: uppercase;
    letter-spacing: 0.14em;
    padding: 16px 10px 6px;
}

.sidebar-link {
    display: flex;
    align-items: center;
    gap: 11px;
    padding: 9px 10px;
    border-radius: 6px;
    font-family: 'Work Sans', sans-serif;
    font-size: 14px;
    font-weight: 500;
    color: rgba(255,255,255,0.58);
    text-decoration: none;
    transition: background-color 0.15s ease, color 0.15s ease;
    margin-bottom: 1px;
}

.sidebar-link:hover {
    background-color: rgba(255,255,255,0.07);
    color: #ffffff;
}

.sidebar-link.active {
    background-color: rgba(255,255,255,0.11);
    color: #ffffff;
    font-weight: 600;
    border-left: 3px solid #a23d30;
    padding-left: 7px;
}

.sidebar-link .material-symbols-outlined {
    font-size: 19px;
    flex-shrink: 0;
    font-variation-settings: 'FILL' 0, 'wght' 300, 'GRAD' 0, 'opsz' 20;
}

.sidebar-link.active .material-symbols-outlined {
    font-variation-settings: 'FILL' 1, 'wght' 400, 'GRAD' 0, 'opsz' 20;
}

.sidebar-footer {
    padding: 12px 10px 20px;
    border-top: 1px solid rgba(255,255,255,0.07);
}

.sidebar-signout {
    display: flex;
    align-items: center;
    gap: 11px;
    width: 100%;
    padding: 9px 10px;
    border-radius: 6px;
    background: transparent;
    border: none;
    font-family: 'Work Sans', sans-serif;
    font-size: 14px;
    font-weight: 500;
    color: rgba(255,255,255,0.45);
    cursor: pointer;
    transition: background-color 0.15s ease, color 0.15s ease;
    text-decoration: none;
}

.sidebar-signout:hover {
    background-color: rgba(186,26,26,0.18);
    color: #ff8a80;
}

.sidebar-signout .material-symbols-outlined {
    font-size: 19px;
    font-variation-settings: 'FILL' 0, 'wght' 300, 'GRAD' 0, 'opsz' 20;
}
</style>

<aside class="admin-sidebar">

    <div class="sidebar-brand">
        <div class="sidebar-brand-name">Thoughts of Nomads</div>
        <div class="sidebar-brand-tag">Admin Panel</div>
    </div>

    <nav class="sidebar-nav">
        <span class="sidebar-section-label">Main</span>

        <a href="<%= cp %>/admin/dashboard"
           class="sidebar-link <%= activePath.equals("/admin/dashboard") ? "active" : "" %>">
            <span class="material-symbols-outlined">dashboard</span>
            Dashboard
        </a>

        <a href="<%= cp %>/admin/articles"
           class="sidebar-link <%= activePath.startsWith("/admin/articles") ? "active" : "" %>">
            <span class="material-symbols-outlined">article</span>
            Articles
        </a>

        <span class="sidebar-section-label">Taxonomy</span>

        <a href="<%= cp %>/admin/categories"
           class="sidebar-link <%= activePath.startsWith("/admin/categories") ? "active" : "" %>">
            <span class="material-symbols-outlined">folder_open</span>
            Categories
        </a>

        <a href="<%= cp %>/admin/tags"
           class="sidebar-link <%= activePath.startsWith("/admin/tags") ? "active" : "" %>">
            <span class="material-symbols-outlined">sell</span>
            Tags
        </a>

        <span class="sidebar-section-label">People</span>

        <a href="<%= cp %>/admin/users"
           class="sidebar-link <%= activePath.startsWith("/admin/users") ? "active" : "" %>">
            <span class="material-symbols-outlined">group</span>
            Users
        </a>
    </nav>

    <div class="sidebar-footer">
        <a href="<%= cp %>/auth/logout" class="sidebar-signout">
            <span class="material-symbols-outlined">logout</span>
            Sign Out
        </a>
    </div>

</aside>
