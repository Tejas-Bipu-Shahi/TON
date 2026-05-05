<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.thoughtsofnomads.model.User, com.thoughtsofnomads.model.UserProfile,
                 com.thoughtsofnomads.model.Role, com.thoughtsofnomads.model.AccountStatus,
                 java.util.List, java.text.SimpleDateFormat" %>
<%
    @SuppressWarnings("unchecked")
    List<User> users     = (List<User>) request.getAttribute("users");
    User editUser        = (User) request.getAttribute("editUser");
    String flashSuccess  = (String) request.getAttribute("flashSuccess");
    String flashError    = (String) request.getAttribute("flashError");
    boolean isEditing    = (editUser != null);

    User sessionUser     = (User) session.getAttribute("user");
    int  sessionUserId   = (sessionUser != null) ? sessionUser.getUserId() : -1;

    SimpleDateFormat sdf = new SimpleDateFormat("MMM d, yyyy");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Users — Admin | Thoughts of Nomads</title>
    <link href="https://fonts.googleapis.com/css2?family=Epilogue:wght@400;600;700&family=Work+Sans:wght@400;500;600&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" rel="stylesheet"/>
    <style>
    /* ── Design Tokens ───────────────────────────────────────── */
    :root {
        --primary:             #0e193e;
        --surface-lowest:      #ffffff;
        --surface:             #f8f9fa;
        --outline:             #e1e3e4;
        --on-surface:          #191c1d;
        --on-surface-variant:  #45464e;
        --radius:              6px;
        --primary-dark:        #242e54;
        --outline-strong:      #c6c5cf;
        --error:               #c62828;
        --error-surface:       #fce4ec;
        --icon-muted:          #76767f;
    }

    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
    html, body { height: 100%; overflow: hidden; }
    body { font-family: 'Work Sans', sans-serif; background-color: var(--surface); color: var(--on-surface); -webkit-font-smoothing: antialiased; }
    a { text-decoration: none; color: inherit; }
    button { cursor: pointer; font-family: inherit; }
    .material-symbols-outlined { font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24; vertical-align: middle; line-height: 1; }

    /* ── Shell ───────────────────────────────────────────────── */
    .admin-shell { display: flex; height: 100vh; overflow: hidden; }
    .admin-content { flex: 1; display: flex; flex-direction: column; min-width: 0; overflow: hidden; }
    .admin-main { flex: 1; overflow-y: auto; padding: 32px; }

    /* ── Page Header ─────────────────────────────────────────── */
    .page-header { margin-bottom: 28px; }
    .page-title { font-family: 'Epilogue', sans-serif; font-size: 24px; font-weight: 700; color: var(--primary); margin-bottom: 4px; }
    .page-subtitle { font-size: 14px; color: var(--on-surface-variant); }

    /* ── Grid ────────────────────────────────────────────────── */
    .content-grid { display: grid; grid-template-columns: 1fr 2fr; gap: 24px; align-items: start; }
    @media (max-width: 1100px) { .content-grid { grid-template-columns: 1fr; } }

    /* ── Card ────────────────────────────────────────────────── */
    .card { background-color: var(--surface-lowest); border: 1px solid var(--outline); border-radius: var(--radius); }
    .card-header { display: flex; align-items: center; gap: 10px; padding: 16px 20px; border-bottom: 1px solid var(--outline); }
    .card-header .material-symbols-outlined { font-size: 18px; color: var(--primary-dark); font-variation-settings: 'FILL' 1, 'wght' 400, 'GRAD' 0, 'opsz' 20; }
    .card-title { font-family: 'Epilogue', sans-serif; font-size: 14px; font-weight: 700; color: var(--primary); }
    .card-body { padding: 20px; }

    /* ── Form ────────────────────────────────────────────────── */
    .form-stack { display: flex; flex-direction: column; gap: 14px; }
    .form-row { display: grid; grid-template-columns: 1fr 1fr; gap: 12px; }
    .form-group { display: flex; flex-direction: column; gap: 5px; }
    .form-label { font-size: 11px; font-weight: 600; color: var(--on-surface-variant); text-transform: uppercase; letter-spacing: 0.09em; }
    .form-control {
        width: 100%; padding: 9px 12px; font-family: 'Work Sans', sans-serif; font-size: 14px;
        color: var(--on-surface); background-color: var(--surface-lowest);
        border: 1px solid var(--outline-strong); border-radius: var(--radius);
        outline: none; transition: border-color 0.18s ease, box-shadow 0.18s ease;
        appearance: none; -webkit-appearance: none;
    }
    .form-control:focus { border-color: var(--primary-dark); box-shadow: 0 0 0 3px rgba(36, 46, 84, 0.1); }
    .select-wrapper { position: relative; }
    .select-wrapper .form-control {
        padding-right: 36px; cursor: pointer;
        background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 24 24' fill='none' stroke='%2376767f' stroke-width='2.5' stroke-linecap='round' stroke-linejoin='round'%3E%3Cpolyline points='6 9 12 15 18 9'%3E%3C/polyline%3E%3C/svg%3E");
        background-repeat: no-repeat; background-position: right 12px center;
    }
    textarea.form-control { resize: vertical; min-height: 76px; line-height: 1.55; }
    .form-hint { font-size: 12px; color: var(--icon-muted); }

    .btn-submit {
        width: 100%; padding: 10px 16px; background-color: var(--primary); color: #fff;
        border: none; border-radius: var(--radius); font-family: 'Work Sans', sans-serif;
        font-size: 12px; font-weight: 600; letter-spacing: 0.1em; text-transform: uppercase;
        display: flex; align-items: center; justify-content: center; gap: 7px;
        transition: background-color 0.18s ease, box-shadow 0.18s ease; margin-top: 4px;
    }
    .btn-submit .material-symbols-outlined { font-size: 16px; font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 20; }
    .btn-submit:hover { background-color: var(--primary-dark); box-shadow: 0 4px 12px rgba(14, 25, 62, 0.2); }

    .btn-cancel { display: block; text-align: center; margin-top: 8px; font-size: 13px; font-weight: 500; color: var(--on-surface-variant); text-decoration: underline; text-underline-offset: 3px; }
    .btn-cancel:hover { color: var(--error); }

    /* ── Table ───────────────────────────────────────────────── */
    .table-wrapper { overflow-x: auto; }
    .data-table { width: 100%; border-collapse: collapse; font-size: 13.5px; }
    .data-table thead tr { background-color: var(--surface); border-bottom: 1px solid var(--outline); }
    .data-table th { padding: 10px 14px; text-align: left; font-size: 11px; font-weight: 600; color: var(--on-surface-variant); text-transform: uppercase; letter-spacing: 0.09em; white-space: nowrap; }
    .data-table td { padding: 12px 14px; border-bottom: 1px solid var(--outline); vertical-align: middle; }
    .data-table tbody tr:last-child td { border-bottom: none; }
    .data-table tbody tr:hover { background-color: #fafbfc; }

    /* ── User Cell ───────────────────────────────────────────── */
    .user-cell { display: flex; align-items: center; gap: 11px; }
    .user-avatar {
        width: 36px; height: 36px; border-radius: 50%; flex-shrink: 0;
        display: flex; align-items: center; justify-content: center;
        font-family: 'Epilogue', sans-serif; font-size: 13px; font-weight: 700;
        color: #fff; letter-spacing: 0.03em;
    }
    .avatar-admin       { background-color: #0e193e; }
    .avatar-contributor { background-color: #00695c; }
    .user-name { font-weight: 600; color: var(--on-surface); font-size: 13.5px; }
    .user-email { font-size: 12px; color: var(--on-surface-variant); margin-top: 1px; }

    /* ── Badges ──────────────────────────────────────────────── */
    .badge {
        display: inline-flex; align-items: center; gap: 4px;
        padding: 3px 9px; border-radius: 20px; font-size: 11.5px; font-weight: 600;
        white-space: nowrap; letter-spacing: 0.02em;
    }
    .badge .material-symbols-outlined { font-size: 12px; font-variation-settings: 'FILL' 1, 'wght' 500, 'GRAD' 0, 'opsz' 20; }

    .badge-admin       { background-color: #e8eaf6; color: #283593; }
    .badge-contributor { background-color: #f3f4f5; color: var(--on-surface-variant); }

    .badge-active   { background-color: #e8f5e9; color: #2e7d32; }
    .badge-pending  { background-color: #e3f2fd; color: #1565c0; }
    .badge-locked   { background-color: #fff3e0; color: #e65100; }
    .badge-disabled { background-color: var(--error-surface); color: var(--error); }

    .failed-badge {
        display: inline-flex; align-items: center; gap: 3px; margin-left: 6px;
        padding: 2px 6px; border-radius: 10px; font-size: 11px; font-weight: 600;
        background-color: #fff3e0; color: #e65100;
    }
    .failed-badge .material-symbols-outlined { font-size: 11px; font-variation-settings: 'FILL' 1, 'wght' 500, 'GRAD' 0, 'opsz' 20; }

    /* ── Action Buttons ──────────────────────────────────────── */
    .action-cell { display: flex; align-items: center; gap: 4px; }
    .btn-icon {
        display: inline-flex; align-items: center; justify-content: center;
        width: 30px; height: 30px; border-radius: 5px; border: none;
        background: transparent; transition: background-color 0.15s ease, color 0.15s ease;
    }
    .btn-icon .material-symbols-outlined { font-size: 17px; font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 20; }

    .btn-edit   { color: var(--primary-dark); }
    .btn-edit:hover { background-color: #e8eaf6; color: var(--primary); }

    .btn-activate { color: #2e7d32; }
    .btn-activate:hover { background-color: #e8f5e9; }

    .btn-lock { color: #e65100; }
    .btn-lock:hover { background-color: #fff3e0; }

    .btn-unlock { color: #1565c0; }
    .btn-unlock:hover { background-color: #e3f2fd; }

    .btn-delete { color: var(--icon-muted); }
    .btn-delete:hover { background-color: var(--error-surface); color: var(--error); }

    .btn-icon:disabled { opacity: 0.3; cursor: not-allowed; pointer-events: none; }

    /* ── Joined Cell ─────────────────────────────────────────── */
    .td-date { font-size: 12.5px; color: var(--on-surface-variant); white-space: nowrap; }

    /* ── Empty State ─────────────────────────────────────────── */
    .td-empty { text-align: center; padding: 48px 16px; color: var(--on-surface-variant); font-size: 14px; }
    .td-empty .material-symbols-outlined { display: block; font-size: 36px; margin-bottom: 10px; opacity: 0.3; }

    /* ── Flash ───────────────────────────────────────────────── */
    .flash { display: flex; align-items: center; gap: 10px; padding: 12px 16px; border-radius: var(--radius); font-size: 14px; font-weight: 500; margin-bottom: 20px; }
    .flash .material-symbols-outlined { font-size: 18px; font-variation-settings: 'FILL' 1, 'wght' 400, 'GRAD' 0, 'opsz' 20; }
    .flash-success { background-color: #e8f5e9; color: #2e7d32; border: 1px solid #a5d6a7; }
    .flash-error   { background-color: var(--error-surface); color: var(--error); border: 1px solid #ef9a9a; }

    /* ── Self Badge ──────────────────────────────────────────── */
    .you-chip {
        display: inline-block; margin-left: 6px; padding: 1px 6px;
        font-size: 10px; font-weight: 700; letter-spacing: 0.06em;
        background-color: #e8eaf6; color: #283593;
        border-radius: 3px; text-transform: uppercase; vertical-align: middle;
    }

    /* ── Delete Modal ────────────────────────────────────────── */
    .modal-backdrop {
        position: fixed; inset: 0; background: rgba(14, 25, 62, 0.45);
        backdrop-filter: blur(2px); -webkit-backdrop-filter: blur(2px);
        display: flex; align-items: center; justify-content: center;
        z-index: 900; opacity: 0; pointer-events: none; transition: opacity 0.2s ease;
    }
    .modal-backdrop.open { opacity: 1; pointer-events: auto; }
    .modal {
        background: var(--surface-lowest); border: 1px solid var(--outline); border-radius: 10px;
        width: 100%; max-width: 420px; margin: 16px;
        box-shadow: 0 20px 60px rgba(14, 25, 62, 0.18), 0 4px 16px rgba(0,0,0,0.08);
        transform: translateY(10px) scale(0.98); transition: transform 0.2s ease;
    }
    .modal-backdrop.open .modal { transform: translateY(0) scale(1); }
    .modal-icon-wrap {
        display: flex; align-items: center; justify-content: center;
        width: 52px; height: 52px; border-radius: 50%;
        background-color: var(--error-surface); margin: 28px auto 16px;
    }
    .modal-icon-wrap .material-symbols-outlined { font-size: 26px; color: var(--error); font-variation-settings: 'FILL' 1, 'wght' 400, 'GRAD' 0, 'opsz' 24; }
    .modal-body { padding: 0 28px 24px; text-align: center; }
    .modal-title { font-family: 'Epilogue', sans-serif; font-size: 17px; font-weight: 700; color: var(--on-surface); margin-bottom: 8px; }
    .modal-desc { font-size: 13.5px; color: var(--on-surface-variant); line-height: 1.6; }
    .modal-subject { font-weight: 600; color: var(--on-surface); }
    .modal-warning { margin-top: 10px; font-size: 12px; color: var(--error); }
    .modal-footer { display: flex; gap: 10px; padding: 16px 20px; border-top: 1px solid var(--outline); background-color: var(--surface); border-radius: 0 0 10px 10px; }
    .modal-btn { flex: 1; padding: 9px 16px; font-family: 'Work Sans', sans-serif; font-size: 13px; font-weight: 600; border-radius: var(--radius); border: none; cursor: pointer; transition: background-color 0.15s ease, box-shadow 0.15s ease; letter-spacing: 0.03em; }
    .modal-btn-cancel { background-color: var(--surface-lowest); color: var(--on-surface-variant); border: 1px solid var(--outline-strong); }
    .modal-btn-cancel:hover { background-color: var(--surface); color: var(--on-surface); }
    .modal-btn-delete { background-color: var(--error); color: #fff; }
    .modal-btn-delete:hover { background-color: #b71c1c; box-shadow: 0 4px 12px rgba(198, 40, 40, 0.3); }
    </style>
</head>
<body>
<div class="admin-shell">

    <jsp:include page="/WEB-INF/views/admin/includes/sidebar.jsp"/>

    <div class="admin-content">

        <jsp:include page="/WEB-INF/views/admin/includes/header.jsp"/>

        <main class="admin-main">

            <div class="page-header">
                <h1 class="page-title">User Management</h1>
                <p class="page-subtitle">Create and manage contributor and administrator accounts.</p>
            </div>

            <%-- Flash messages --%>
            <% if (flashSuccess != null) { %>
            <div class="flash flash-success">
                <span class="material-symbols-outlined">check_circle</span>
                <%= flashSuccess %>
            </div>
            <% } %>
            <% if (flashError != null) { %>
            <div class="flash flash-error">
                <span class="material-symbols-outlined">error</span>
                <%= flashError %>
            </div>
            <% } %>

            <div class="content-grid">

                <!-- ── Left: Add / Edit User Form ─────────────────── -->
                <div class="card">
                    <div class="card-header">
                        <span class="material-symbols-outlined"><%= isEditing ? "manage_accounts" : "person_add" %></span>
                        <span class="card-title"><%= isEditing ? "Edit User" : "Add New User" %></span>
                    </div>
                    <div class="card-body">
                        <form action="<%= request.getContextPath() %>/admin/users" method="post" class="form-stack">
                            <input type="hidden" name="action" value="<%= isEditing ? "edit" : "add" %>"/>
                            <% if (isEditing) { %>
                            <input type="hidden" name="id" value="<%= editUser.getUserId() %>"/>
                            <% } %>

                            <div class="form-group">
                                <label class="form-label" for="fullName">Full Name</label>
                                <input class="form-control" type="text" id="fullName" name="fullName" required
                                       placeholder="e.g. Jane Doe"
                                       value="<%= isEditing && editUser.getProfile() != null && editUser.getProfile().getFullName() != null ? editUser.getProfile().getFullName() : "" %>"/>
                            </div>

                            <div class="form-group">
                                <label class="form-label" for="email">Email</label>
                                <input class="form-control" type="email" id="email" name="email" required
                                       placeholder="e.g. jane@example.com"
                                       value="<%= isEditing ? editUser.getEmail() : "" %>"/>
                            </div>

                            <div class="form-group">
                                <label class="form-label" for="password"><%= isEditing ? "New Password" : "Password" %></label>
                                <input class="form-control" type="password" id="password" name="password"
                                       placeholder="<%= isEditing ? "Leave blank to keep current" : "Min. 8 characters" %>"
                                       <%= isEditing ? "" : "required" %>/>
                                <% if (isEditing) { %>
                                <span class="form-hint">Leave blank to keep existing password.</span>
                                <% } %>
                            </div>

                            <div class="form-row">
                                <div class="form-group">
                                    <label class="form-label" for="role">Role</label>
                                    <div class="select-wrapper">
                                        <select class="form-control" id="role" name="role">
                                            <option value="CONTRIBUTOR" <%= isEditing && editUser.getRole() == Role.CONTRIBUTOR ? "selected" : "" %>>Contributor</option>
                                            <option value="ADMIN"       <%= isEditing && editUser.getRole() == Role.ADMIN       ? "selected" : "" %>>Admin</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="form-label" for="status">Status</label>
                                    <div class="select-wrapper">
                                        <select class="form-control" id="status" name="status">
                                            <option value="ACTIVE"   <%= isEditing && editUser.getAccountStatus() == AccountStatus.ACTIVE   ? "selected" : "" %>>Active</option>
                                            <option value="PENDING"  <%= isEditing && editUser.getAccountStatus() == AccountStatus.PENDING  ? "selected" : "" %>>Pending</option>
                                            <option value="LOCKED"   <%= isEditing && editUser.getAccountStatus() == AccountStatus.LOCKED   ? "selected" : "" %>>Locked</option>
                                            <option value="DISABLED" <%= isEditing && editUser.getAccountStatus() == AccountStatus.DISABLED ? "selected" : "" %>>Disabled</option>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="form-label" for="contactNumber">Contact Number</label>
                                <input class="form-control" type="text" id="contactNumber" name="contactNumber"
                                       placeholder="e.g. +977-9800000000"
                                       value="<%= isEditing && editUser.getProfile() != null && editUser.getProfile().getContactNumber() != null ? editUser.getProfile().getContactNumber() : "" %>"/>
                            </div>

                            <div class="form-group">
                                <label class="form-label" for="bio">Bio</label>
                                <textarea class="form-control" id="bio" name="bio"
                                          placeholder="Short bio for this user…"><%= isEditing && editUser.getProfile() != null && editUser.getProfile().getBio() != null ? editUser.getProfile().getBio() : "" %></textarea>
                            </div>

                            <button type="submit" class="btn-submit">
                                <span class="material-symbols-outlined"><%= isEditing ? "save" : "person_add" %></span>
                                <%= isEditing ? "Save Changes" : "Create User" %>
                            </button>

                            <% if (isEditing) { %>
                            <a href="<%= request.getContextPath() %>/admin/users" class="btn-cancel">Cancel Edit</a>
                            <% } %>
                        </form>
                    </div>
                </div>

                <!-- ── Right: Users Table ──────────────────────────── -->
                <div class="card">
                    <div class="card-header">
                        <span class="material-symbols-outlined">group</span>
                        <span class="card-title">All Users</span>
                    </div>
                    <div class="table-wrapper">
                        <table class="data-table">
                            <thead>
                                <tr>
                                    <th>User</th>
                                    <th>Role</th>
                                    <th>Status</th>
                                    <th>Joined</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                            <% if (users == null || users.isEmpty()) { %>
                                <tr>
                                    <td colspan="5" class="td-empty">
                                        <span class="material-symbols-outlined">person_off</span>
                                        No users found.
                                    </td>
                                </tr>
                            <% } else {
                                   for (User u : users) {
                                       UserProfile p = u.getProfile();
                                       String initials = (p != null) ? p.getInitials() : "?";
                                       String fullName = (p != null && p.getFullName() != null) ? p.getFullName() : "—";
                                       boolean isSelf = (u.getUserId() == sessionUserId);
                                       String avatarClass = u.getRole() == Role.ADMIN ? "avatar-admin" : "avatar-contributor";
                                       AccountStatus st = u.getAccountStatus();
                                       String statusClass = "badge-" + st.name().toLowerCase();
                                       String statusIcon  = st == AccountStatus.ACTIVE   ? "check_circle"
                                                          : st == AccountStatus.PENDING  ? "schedule"
                                                          : st == AccountStatus.LOCKED   ? "lock"
                                                          :                                "block";
            %>
                                <tr>
                                    <!-- User -->
                                    <td>
                                        <div class="user-cell">
                                            <div class="user-avatar <%= avatarClass %>"><%= initials %></div>
                                            <div>
                                                <div class="user-name">
                                                    <%= fullName %>
                                                    <% if (isSelf) { %><span class="you-chip">You</span><% } %>
                                                </div>
                                                <div class="user-email"><%= u.getEmail() %></div>
                                            </div>
                                        </div>
                                    </td>

                                    <!-- Role -->
                                    <td>
                                        <span class="badge badge-<%= u.getRole().name().toLowerCase() %>">
                                            <span class="material-symbols-outlined">
                                                <%= u.getRole() == Role.ADMIN ? "shield" : "edit_note" %>
                                            </span>
                                            <%= u.getRole() == Role.ADMIN ? "Admin" : "Contributor" %>
                                        </span>
                                    </td>

                                    <!-- Status -->
                                    <td>
                                        <span class="badge <%= statusClass %>">
                                            <span class="material-symbols-outlined"><%= statusIcon %></span>
                                            <%= st.name().charAt(0) + st.name().substring(1).toLowerCase() %>
                                        </span>
                                        <% if (u.getFailedAttempts() > 0) { %>
                                        <span class="failed-badge">
                                            <span class="material-symbols-outlined">warning</span>
                                            <%= u.getFailedAttempts() %>
                                        </span>
                                        <% } %>
                                    </td>

                                    <!-- Joined -->
                                    <td class="td-date">
                                        <%= u.getCreatedAt() != null ? sdf.format(u.getCreatedAt()) : "—" %>
                                    </td>

                                    <!-- Actions -->
                                    <td>
                                        <div class="action-cell">

                                            <%-- Edit --%>
                                            <a href="<%= request.getContextPath() %>/admin/users?editId=<%= u.getUserId() %>"
                                               class="btn-icon btn-edit" title="Edit user">
                                                <span class="material-symbols-outlined">edit</span>
                                            </a>

                                            <%-- Status quick-toggle --%>
                                            <% if (!isSelf) {
                                                   String toggleStatus, toggleClass, toggleIcon, toggleTitle;
                                                   if (st == AccountStatus.ACTIVE) {
                                                       toggleStatus = "LOCKED"; toggleClass = "btn-lock";
                                                       toggleIcon = "lock"; toggleTitle = "Lock account";
                                                   } else {
                                                       toggleStatus = "ACTIVE"; toggleClass = "btn-activate";
                                                       toggleIcon = "lock_open"; toggleTitle = "Activate account";
                                                   }
                                            %>
                                            <form method="post" action="<%= request.getContextPath() %>/admin/users" style="display:inline">
                                                <input type="hidden" name="action"    value="status"/>
                                                <input type="hidden" name="userId"    value="<%= u.getUserId() %>"/>
                                                <input type="hidden" name="newStatus" value="<%= toggleStatus %>"/>
                                                <button type="submit" class="btn-icon <%= toggleClass %>" title="<%= toggleTitle %>">
                                                    <span class="material-symbols-outlined"><%= toggleIcon %></span>
                                                </button>
                                            </form>
                                            <% } %>

                                            <%-- Delete --%>
                                            <% if (!isSelf) { %>
                                            <button type="button" class="btn-icon btn-delete" title="Delete user"
                                                    onclick="openDeleteModal(<%= u.getUserId() %>, '<%= fullName.replace("'", "\\'") %>')">
                                                <span class="material-symbols-outlined">delete</span>
                                            </button>
                                            <% } %>

                                        </div>
                                    </td>
                                </tr>
                            <%     }
                               }
                            %>
                            </tbody>
                        </table>
                    </div>
                </div>

            </div><!-- .content-grid -->
        </main>
    </div>
</div>

<!-- ── Delete Confirmation Modal ─────────────────────────────── -->
<div class="modal-backdrop" id="deleteModal" role="dialog" aria-modal="true" aria-labelledby="modalTitle">
    <div class="modal">
        <div class="modal-icon-wrap">
            <span class="material-symbols-outlined">person_remove</span>
        </div>
        <div class="modal-body">
            <p class="modal-title" id="modalTitle">Delete User?</p>
            <p class="modal-desc">
                You're about to permanently delete <span class="modal-subject" id="modalUserName"></span>.
                Their profile and all associated data will be removed.
            </p>
            <p class="modal-warning">This action cannot be undone.</p>
        </div>
        <div class="modal-footer">
            <button type="button" class="modal-btn modal-btn-cancel" onclick="closeDeleteModal()">Cancel</button>
            <form method="post" action="<%= request.getContextPath() %>/admin/users" id="deleteForm" style="flex:1;display:flex;">
                <input type="hidden" name="action" value="delete"/>
                <input type="hidden" name="id" id="deleteUserId"/>
                <button type="submit" class="modal-btn modal-btn-delete" style="width:100%;">Delete User</button>
            </form>
        </div>
    </div>
</div>

<script>
    const modal = document.getElementById('deleteModal');

    function openDeleteModal(id, name) {
        document.getElementById('deleteUserId').value = id;
        document.getElementById('modalUserName').textContent = '"' + name + '"';
        modal.classList.add('open');
        document.getElementById('deleteForm').querySelector('[type=submit]').focus();
    }

    function closeDeleteModal() {
        modal.classList.remove('open');
    }

    modal.addEventListener('click', (e) => { if (e.target === modal) closeDeleteModal(); });
    document.addEventListener('keydown', (e) => { if (e.key === 'Escape') closeDeleteModal(); });
</script>
</body>
</html>
