<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.thoughtsofnomads.model.User" %>
<%
    User _headerUser = (User) session.getAttribute("user");
    String _initial  = (_headerUser != null && _headerUser.getEmail() != null)
                       ? String.valueOf(_headerUser.getEmail().charAt(0)).toUpperCase()
                       : "A";
    String _pageTitle = (String) request.getAttribute("adminPageTitle");
    if (_pageTitle == null) _pageTitle = "Admin";
%>
<style>
/* ── Admin Header ─────────────────────────────────────────── */
.admin-header {
    flex-shrink: 0;
    height: 64px;
    background-color: #ffffff;
    border-bottom: 1px solid #e1e3e4;
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 0 32px;
    position: sticky;
    top: 0;
    z-index: 20;
}

.admin-header-left {
    display: flex;
    align-items: center;
    gap: 10px;
}

.admin-header-title {
    font-family: 'Epilogue', sans-serif;
    font-size: 18px;
    font-weight: 700;
    color: #0e193e;
    letter-spacing: -0.01em;
}

.admin-header-right {
    display: flex;
    align-items: center;
    gap: 14px;
}

.admin-header-user {
    text-align: right;
    line-height: 1.3;
}

.admin-header-name {
    font-family: 'Work Sans', sans-serif;
    font-size: 13px;
    font-weight: 600;
    color: #0e193e;
}

.admin-header-role {
    font-family: 'Work Sans', sans-serif;
    font-size: 11px;
    color: #76767f;
    text-transform: uppercase;
    letter-spacing: 0.08em;
}

.admin-header-avatar {
    width: 36px;
    height: 36px;
    border-radius: 50%;
    background-color: #0e193e;
    color: #ffffff;
    font-family: 'Epilogue', sans-serif;
    font-size: 14px;
    font-weight: 700;
    display: flex;
    align-items: center;
    justify-content: center;
    flex-shrink: 0;
}
</style>

<header class="admin-header">
    <div class="admin-header-left">
        <span class="admin-header-title"><%= _pageTitle %></span>
    </div>
    <div class="admin-header-right">
        <div class="admin-header-user">
            <div class="admin-header-name">System Admin</div>
            <div class="admin-header-role">Administrator</div>
        </div>
        <div class="admin-header-avatar"><%= _initial %></div>
    </div>
</header>
