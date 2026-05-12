<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.thoughtsofnomads.model.User, com.thoughtsofnomads.model.Role" %>

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