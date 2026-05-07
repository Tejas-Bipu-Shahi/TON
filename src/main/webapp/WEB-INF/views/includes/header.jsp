<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.thoughtsofnomads.model.User, com.thoughtsofnomads.model.Role" %>

<style>
    /* Header Specific CSS */
    .site-header {
        background-color: #ffffff;
        position: sticky; 
        top: 0; 
        width: 100%; 
        z-index: 50;
        border-bottom: 1px solid #e1e3e4;
        font-family: 'Work Sans', sans-serif;
    }
    .header-container {
        display: flex; 
        justify-content: space-between; 
        align-items: center;
        max-width: 1280px; 
        margin: 0 auto;
        padding: 0 16px; 
        height: 80px;
    }
    .header-brand {
        font-family: 'Epilogue', sans-serif; 
        font-size: 20px; 
        font-weight: 700;
        color: #0e193e; 
        text-transform: uppercase; 
        letter-spacing: 0.1em;
    }
    
    /* Hide menus on mobile by default */
    .header-menu, .header-auth { display: none; } 

    @media (min-width: 768px) {
        .header-container { padding: 0 48px; }
        .header-menu { display: flex; gap: 32px; }
        .header-auth { display: flex; gap: 16px; align-items: center; }
    }

    .nav-link {
        color: #45464e; 
        font-weight: 500; 
        text-transform: uppercase;
        letter-spacing: 0.1em; 
        font-size: 12px; 
        transition: color 0.2s ease, transform 0.2s ease;
        text-decoration: none;
    }
    .nav-link:hover { color: #0e193e; transform: scale(0.95); }
    .nav-link:active { transform: scale(0.90); }
    .nav-link.active { 
        color: #0e193e; 
        border-bottom: 2px solid #0e193e; 
        padding-bottom: 4px; 
        font-weight: 600; 
    }

    /* Base buttons for header */
    .btn {
        font-family: 'Work Sans', sans-serif;
        font-size: 12px; 
        font-weight: 600; 
        letter-spacing: 0.1em; 
        text-transform: uppercase;
        padding: 8px 16px; 
        border-radius: 4px;
        text-decoration: none;
        transition: background-color 0.2s ease, opacity 0.2s ease;
        display: inline-flex;
        align-items: center;
        justify-content: center;
    }
    .btn-outline {
        color: #0e193e;
        border: 1px solid #0e193e;
        background-color: transparent;
    }
    .btn-outline:hover { background-color: #f3f4f5; }
    
    .btn-solid {
        background-color: #0e193e;
        color: #ffffff;
        border: 1px solid #0e193e;
    }
    .btn-solid:hover { opacity: 0.9; }
</style>

<!-- TopNavBar HTML -->
<nav class="site-header">
    <div class="header-container">
        <!-- Brand -->
        <a class="header-brand" href="<%=request.getContextPath()%>/" style="text-decoration:none;">Thoughts of Nomads</a>

        <!-- Main Navigation (Desktop) -->
        <div class="header-menu">
            <%
                String currentUri  = request.getRequestURI();
                String contextPath = request.getContextPath();
                String forwardUri  = (String) request.getAttribute("jakarta.servlet.forward.request_uri");
                String checkPath   = (forwardUri != null) ? forwardUri : currentUri;
                if (checkPath.startsWith(contextPath)) checkPath = checkPath.substring(contextPath.length());

                boolean isHome       = checkPath.equals("/") || checkPath.equals("") || checkPath.equals("/home");
                boolean isCategories = checkPath.startsWith("/categories") || checkPath.startsWith("/category");
                boolean isLatest     = checkPath.startsWith("/latest");
                boolean isAbout      = checkPath.startsWith("/about");
            %>
            <a class="nav-link <%= isHome       ? "active" : "" %>" href="<%=contextPath%>/">Home</a>
            <a class="nav-link <%= isCategories ? "active" : "" %>" href="<%=contextPath%>/categories">Categories</a>
            <a class="nav-link <%= isLatest     ? "active" : "" %>" href="<%=contextPath%>/latest">Latest</a>
            <a class="nav-link <%= isAbout      ? "active" : "" %>" href="<%=contextPath%>/about">About Us</a>
        </div>

        <!-- Auth Navigation (Desktop) -->
        <div class="header-auth">
            <%
                User _hUser = (User) session.getAttribute("user");
                if (_hUser != null) {
                    String _dashUrl = (_hUser.getRole() == Role.ADMIN)
                        ? request.getContextPath() + "/admin/dashboard"
                        : request.getContextPath() + "/member/dashboard";
            %>
                <a href="<%= _dashUrl %>" class="btn btn-outline">Dashboard</a>
                <a href="<%=request.getContextPath()%>/auth/logout" class="btn btn-solid">Logout</a>
            <% } else { %>
                <a href="<%=request.getContextPath()%>/auth/login" class="btn btn-outline">Sign In</a>
                <a href="<%=request.getContextPath()%>/auth/register" class="btn btn-solid">Register</a>
            <% } %>
        </div>
    </div>
</nav>