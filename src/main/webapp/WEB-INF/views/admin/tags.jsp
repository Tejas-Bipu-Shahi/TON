<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.thoughtsofnomads.model.Tag, java.util.List" %>
<%
    @SuppressWarnings("unchecked")
    List<Tag> tags    = (List<Tag>) request.getAttribute("tags");
    Tag editTag       = (Tag) request.getAttribute("editTag");
    String flashSuccess = (String) request.getAttribute("flashSuccess");
    String flashError   = (String) request.getAttribute("flashError");
    boolean isEditing   = (editTag != null);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Tags — Admin | Thoughts of Nomads</title>
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

        /* Extended palette */
        --primary-dark:        #242e54;
        --outline-strong:      #c6c5cf;
        --error:               #c62828;
        --error-surface:       #fce4ec;
        --icon-muted:          #76767f;
    }

    /* ── Resets ──────────────────────────────────────────────── */
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

    html, body { height: 100%; overflow: hidden; }

    body {
        font-family: 'Work Sans', sans-serif;
        background-color: var(--surface);
        color: var(--on-surface);
        -webkit-font-smoothing: antialiased;
    }

    a { text-decoration: none; color: inherit; }
    button { cursor: pointer; font-family: inherit; }

    .material-symbols-outlined {
        font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
        vertical-align: middle;
        line-height: 1;
    }

    /* ── Shell ───────────────────────────────────────────────── */
    .admin-shell {
        display: flex;
        height: 100vh;
        overflow: hidden;
    }

    .admin-content {
        flex: 1;
        display: flex;
        flex-direction: column;
        min-width: 0;
        overflow: hidden;
    }

    .admin-main {
        flex: 1;
        overflow-y: auto;
        padding: 32px;
    }

    /* ── Page Header ─────────────────────────────────────────── */
    .page-header {
        margin-bottom: 28px;
    }

    .page-title {
        font-family: 'Epilogue', sans-serif;
        font-size: 24px;
        font-weight: 700;
        color: var(--primary);
        margin-bottom: 4px;
    }

    .page-subtitle {
        font-size: 14px;
        color: var(--on-surface-variant);
    }

    /* ── 1/3 + 2/3 Grid ─────────────────────────────────────── */
    .content-grid {
        display: grid;
        grid-template-columns: 1fr 2fr;
        gap: 24px;
        align-items: start;
    }

    @media (max-width: 1080px) {
        .content-grid { grid-template-columns: 1fr; }
    }

    /* ── Card ────────────────────────────────────────────────── */
    .card {
        background-color: var(--surface-lowest);
        border: 1px solid var(--outline);
        border-radius: var(--radius);
    }

    .card-header {
        display: flex;
        align-items: center;
        gap: 10px;
        padding: 16px 20px;
        border-bottom: 1px solid var(--outline);
    }

    .card-header .material-symbols-outlined {
        font-size: 18px;
        color: var(--primary-dark);
        font-variation-settings: 'FILL' 1, 'wght' 400, 'GRAD' 0, 'opsz' 20;
    }

    .card-title {
        font-family: 'Epilogue', sans-serif;
        font-size: 14px;
        font-weight: 700;
        color: var(--primary);
    }

    .card-body {
        padding: 20px;
    }

    /* ── Form ────────────────────────────────────────────────── */
    .form-stack {
        display: flex;
        flex-direction: column;
        gap: 16px;
    }

    .form-group {
        display: flex;
        flex-direction: column;
        gap: 5px;
    }

    .form-label {
        font-size: 11px;
        font-weight: 600;
        color: var(--on-surface-variant);
        text-transform: uppercase;
        letter-spacing: 0.09em;
    }

    .form-control {
        width: 100%;
        padding: 9px 12px;
        font-family: 'Work Sans', sans-serif;
        font-size: 14px;
        color: var(--on-surface);
        background-color: var(--surface-lowest);
        border: 1px solid var(--outline-strong);
        border-radius: var(--radius);
        outline: none;
        transition: border-color 0.18s ease, box-shadow 0.18s ease;
    }

    .form-control:focus {
        border-color: var(--primary-dark);
        box-shadow: 0 0 0 3px rgba(36, 46, 84, 0.1);
    }

    .form-hint {
        font-size: 12px;
        color: var(--icon-muted);
    }

    .btn-submit {
        width: 100%;
        padding: 10px 16px;
        background-color: var(--primary);
        color: #ffffff;
        border: none;
        border-radius: var(--radius);
        font-family: 'Work Sans', sans-serif;
        font-size: 12px;
        font-weight: 600;
        letter-spacing: 0.1em;
        text-transform: uppercase;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 7px;
        transition: background-color 0.18s ease, box-shadow 0.18s ease;
        margin-top: 4px;
    }

    .btn-submit .material-symbols-outlined {
        font-size: 16px;
        font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 20;
    }

    .btn-submit:hover {
        background-color: var(--primary-dark);
        box-shadow: 0 4px 12px rgba(14, 25, 62, 0.2);
    }

    /* ── Table ───────────────────────────────────────────────── */
    .table-wrapper {
        overflow-x: auto;
    }

    .data-table {
        width: 100%;
        border-collapse: collapse;
        font-size: 13.5px;
    }

    .data-table thead tr {
        background-color: var(--surface);
        border-bottom: 1px solid var(--outline);
    }

    .data-table th {
        padding: 10px 14px;
        text-align: left;
        font-size: 11px;
        font-weight: 600;
        color: var(--on-surface-variant);
        text-transform: uppercase;
        letter-spacing: 0.09em;
        white-space: nowrap;
    }

    .data-table td {
        padding: 11px 14px;
        border-bottom: 1px solid var(--outline);
        vertical-align: middle;
        color: var(--on-surface);
    }

    .data-table tbody tr:last-child td {
        border-bottom: none;
    }

    .data-table tbody tr:hover {
        background-color: #fafbfc;
    }

    /* ── Tag Badge ───────────────────────────────────────────── */
    .tag-badge {
        display: inline-flex;
        align-items: center;
        gap: 5px;
        padding: 3px 10px;
        background-color: #f3f4f5;
        color: var(--on-surface-variant);
        border: 1px solid var(--outline);
        border-radius: 4px;
        font-size: 12.5px;
        font-weight: 500;
        white-space: nowrap;
    }

    .tag-badge .material-symbols-outlined {
        font-size: 13px;
        color: var(--icon-muted);
        font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 20;
    }

    /* Slug cell */
    .td-slug {
        font-family: 'Courier New', Courier, monospace;
        font-size: 12px;
        color: var(--on-surface-variant);
        background-color: var(--surface);
        padding: 2px 7px;
        border-radius: 4px;
        border: 1px solid var(--outline);
        display: inline-block;
        white-space: nowrap;
    }

    /* Article count */
    .td-count {
        display: inline-flex;
        align-items: center;
        gap: 4px;
        font-size: 13px;
        font-weight: 600;
        color: var(--primary-dark);
    }

    .td-count .material-symbols-outlined {
        font-size: 14px;
        color: var(--icon-muted);
        font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 20;
    }

    /* ── Action Buttons ──────────────────────────────────────── */
    .action-cell {
        display: flex;
        align-items: center;
        gap: 6px;
    }

    .btn-icon {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        width: 30px;
        height: 30px;
        border-radius: 5px;
        border: none;
        background: transparent;
        transition: background-color 0.15s ease, color 0.15s ease;
    }

    .btn-icon .material-symbols-outlined {
        font-size: 17px;
        font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 20;
    }

    .btn-edit { color: var(--primary-dark); }
    .btn-edit:hover { background-color: #e8eaf6; color: var(--primary); }

    .btn-delete { color: var(--icon-muted); }
    .btn-delete:hover { background-color: var(--error-surface); color: var(--error); }

    /* ── Empty State ─────────────────────────────────────────── */
    .td-empty {
        text-align: center;
        padding: 40px 16px;
        color: var(--on-surface-variant);
        font-size: 14px;
    }
    .td-empty .material-symbols-outlined {
        display: block;
        font-size: 32px;
        margin-bottom: 8px;
        opacity: 0.35;
    }

    /* ── Flash Messages ──────────────────────────────────────── */
    .flash {
        display: flex;
        align-items: center;
        gap: 10px;
        padding: 12px 16px;
        border-radius: var(--radius);
        font-size: 14px;
        font-weight: 500;
        margin-bottom: 20px;
    }
    .flash .material-symbols-outlined {
        font-size: 18px;
        font-variation-settings: 'FILL' 1, 'wght' 400, 'GRAD' 0, 'opsz' 20;
    }
    .flash-success { background-color: #e8f5e9; color: #2e7d32; border: 1px solid #a5d6a7; }
    .flash-error   { background-color: var(--error-surface); color: var(--error); border: 1px solid #ef9a9a; }

    /* ── Cancel Edit Link ────────────────────────────────────── */
    .btn-cancel {
        display: block;
        text-align: center;
        margin-top: 8px;
        font-size: 13px;
        font-weight: 500;
        color: var(--on-surface-variant);
        text-decoration: underline;
        text-underline-offset: 3px;
    }
    .btn-cancel:hover { color: var(--error); }

    /* ── Delete Confirmation Modal ───────────────────────────── */
    .modal-backdrop {
        position: fixed;
        inset: 0;
        background: rgba(14, 25, 62, 0.45);
        backdrop-filter: blur(2px);
        -webkit-backdrop-filter: blur(2px);
        display: flex;
        align-items: center;
        justify-content: center;
        z-index: 900;
        opacity: 0;
        pointer-events: none;
        transition: opacity 0.2s ease;
    }

    .modal-backdrop.open {
        opacity: 1;
        pointer-events: auto;
    }

    .modal {
        background: var(--surface-lowest);
        border: 1px solid var(--outline);
        border-radius: 10px;
        width: 100%;
        max-width: 400px;
        margin: 16px;
        box-shadow: 0 20px 60px rgba(14, 25, 62, 0.18), 0 4px 16px rgba(0,0,0,0.08);
        transform: translateY(10px) scale(0.98);
        transition: transform 0.2s ease;
    }

    .modal-backdrop.open .modal {
        transform: translateY(0) scale(1);
    }

    .modal-icon-wrap {
        display: flex;
        align-items: center;
        justify-content: center;
        width: 52px;
        height: 52px;
        border-radius: 50%;
        background-color: var(--error-surface);
        margin: 28px auto 16px;
    }

    .modal-icon-wrap .material-symbols-outlined {
        font-size: 26px;
        color: var(--error);
        font-variation-settings: 'FILL' 1, 'wght' 400, 'GRAD' 0, 'opsz' 24;
    }

    .modal-body {
        padding: 0 28px 24px;
        text-align: center;
    }

    .modal-title {
        font-family: 'Epilogue', sans-serif;
        font-size: 17px;
        font-weight: 700;
        color: var(--on-surface);
        margin-bottom: 8px;
    }

    .modal-desc {
        font-size: 13.5px;
        color: var(--on-surface-variant);
        line-height: 1.55;
    }

    .modal-tag-name {
        font-weight: 600;
        color: var(--on-surface);
    }

    .modal-footer {
        display: flex;
        gap: 10px;
        padding: 16px 20px;
        border-top: 1px solid var(--outline);
        background-color: var(--surface);
        border-radius: 0 0 10px 10px;
    }

    .modal-btn {
        flex: 1;
        padding: 9px 16px;
        font-family: 'Work Sans', sans-serif;
        font-size: 13px;
        font-weight: 600;
        border-radius: var(--radius);
        border: none;
        cursor: pointer;
        transition: background-color 0.15s ease, box-shadow 0.15s ease;
        letter-spacing: 0.03em;
    }

    .modal-btn-cancel {
        background-color: var(--surface-lowest);
        color: var(--on-surface-variant);
        border: 1px solid var(--outline-strong);
    }

    .modal-btn-cancel:hover {
        background-color: var(--surface);
        color: var(--on-surface);
    }

    .modal-btn-delete {
        background-color: var(--error);
        color: #fff;
    }

    .modal-btn-delete:hover {
        background-color: #b71c1c;
        box-shadow: 0 4px 12px rgba(198, 40, 40, 0.3);
    }
    </style>
</head>
<body>
<div class="admin-shell">

    <jsp:include page="/WEB-INF/views/admin/includes/sidebar.jsp"/>

    <div class="admin-content">

        <jsp:include page="/WEB-INF/views/admin/includes/header.jsp"/>

        <main class="admin-main">

            <div class="page-header">
                <h1 class="page-title">Tag Management</h1>
                <p class="page-subtitle">Add tags to help readers discover related articles across the site.</p>
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

                <!-- ── Left: Add / Edit Tag Form ──────────────────── -->
                <div class="card">
                    <div class="card-header">
                        <span class="material-symbols-outlined"><%= isEditing ? "edit" : "sell" %></span>
                        <span class="card-title"><%= isEditing ? "Edit Tag" : "Add New Tag" %></span>
                    </div>
                    <div class="card-body">
                        <form action="<%= request.getContextPath() %>/admin/tags" method="post" class="form-stack">
                            <input type="hidden" name="action" value="<%= isEditing ? "edit" : "add" %>"/>
                            <% if (isEditing) { %>
                            <input type="hidden" name="id" value="<%= editTag.getId() %>"/>
                            <% } %>

                            <div class="form-group">
                                <label class="form-label" for="tagName">Tag Name</label>
                                <input class="form-control" type="text" id="tagName" name="name"
                                       placeholder="e.g. Backpacking" required
                                       value="<%= isEditing ? editTag.getName() : "" %>"/>
                            </div>

                            <div class="form-group">
                                <label class="form-label" for="tagSlug">Slug</label>
                                <input class="form-control" type="text" id="tagSlug" name="slug"
                                       placeholder="e.g. backpacking" required
                                       value="<%= isEditing ? editTag.getSlug() : "" %>"/>
                                <span class="form-hint">Auto-filled from name. Lowercase and hyphens only.</span>
                            </div>

                            <button type="submit" class="btn-submit">
                                <span class="material-symbols-outlined"><%= isEditing ? "save" : "add" %></span>
                                <%= isEditing ? "Save Changes" : "Add Tag" %>
                            </button>

                            <% if (isEditing) { %>
                            <a href="<%= request.getContextPath() %>/admin/tags" class="btn-cancel">
                                Cancel Edit
                            </a>
                            <% } %>
                        </form>
                    </div>
                </div>

                <!-- ── Right: Tags Table ───────────────────────────── -->
                <div class="card">
                    <div class="card-header">
                        <span class="material-symbols-outlined">label</span>
                        <span class="card-title">All Tags</span>
                    </div>
                    <div class="table-wrapper">
                        <table class="data-table">
                            <thead>
                                <tr>
                                    <th>Tag Name</th>
                                    <th>Slug</th>
                                    <th>Articles</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                            <% if (tags == null || tags.isEmpty()) { %>
                                <tr>
                                    <td colspan="4" class="td-empty">
                                        <span class="material-symbols-outlined">label_off</span>
                                        No tags yet. Add one using the form.
                                    </td>
                                </tr>
                            <% } else {
                                   for (Tag tag : tags) { %>
                                <tr>
                                    <td>
                                        <span class="tag-badge">
                                            <span class="material-symbols-outlined">sell</span>
                                            <%= tag.getName() %>
                                        </span>
                                    </td>
                                    <td><span class="td-slug"><%= tag.getSlug() %></span></td>
                                    <td>
                                        <span class="td-count">
                                            <span class="material-symbols-outlined">article</span>
                                            <%= tag.getArticleCount() %>
                                        </span>
                                    </td>
                                    <td>
                                        <div class="action-cell">
                                            <a href="<%= request.getContextPath() %>/admin/tags?editId=<%= tag.getId() %>"
                                               class="btn-icon btn-edit" title="Edit">
                                                <span class="material-symbols-outlined">edit</span>
                                            </a>
                                            <button type="button" class="btn-icon btn-delete" title="Delete"
                                                    onclick="openDeleteModal(<%= tag.getId() %>, '<%= tag.getName().replace("'", "\\'") %>')">
                                                <span class="material-symbols-outlined">delete</span>
                                            </button>
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
            <span class="material-symbols-outlined">delete_forever</span>
        </div>
        <div class="modal-body">
            <p class="modal-title" id="modalTitle">Delete Tag?</p>
            <p class="modal-desc">
                You're about to delete <span class="modal-tag-name" id="modalTagName"></span>.
                Articles using this tag will lose it. This cannot be undone.
            </p>
        </div>
        <div class="modal-footer">
            <button type="button" class="modal-btn modal-btn-cancel" onclick="closeDeleteModal()">Cancel</button>
            <form method="post" action="<%= request.getContextPath() %>/admin/tags" id="deleteForm" style="flex:1;display:flex;">
                <input type="hidden" name="action" value="delete"/>
                <input type="hidden" name="id" id="deleteId"/>
                <button type="submit" class="modal-btn modal-btn-delete" style="width:100%;">Delete</button>
            </form>
        </div>
    </div>
</div>

<script>
    /* Auto-generate slug from tag name */
    const nameInput = document.getElementById('tagName');
    const slugInput = document.getElementById('tagSlug');
    let slugEdited = false;

    slugInput.addEventListener('input', () => { slugEdited = true; });

    nameInput.addEventListener('input', () => {
        if (slugEdited) return;
        slugInput.value = nameInput.value
            .toLowerCase()
            .trim()
            .replace(/[^a-z0-9\s-]/g, '')
            .replace(/\s+/g, '-');
    });

    /* Delete modal */
    const modal = document.getElementById('deleteModal');

    function openDeleteModal(id, name) {
        document.getElementById('deleteId').value = id;
        document.getElementById('modalTagName').textContent = '"' + name + '"';
        modal.classList.add('open');
        document.getElementById('deleteForm').querySelector('[type=submit]').focus();
    }

    function closeDeleteModal() {
        modal.classList.remove('open');
    }

    modal.addEventListener('click', (e) => {
        if (e.target === modal) closeDeleteModal();
    });

    document.addEventListener('keydown', (e) => {
        if (e.key === 'Escape') closeDeleteModal();
    });
</script>
</body>
</html>
