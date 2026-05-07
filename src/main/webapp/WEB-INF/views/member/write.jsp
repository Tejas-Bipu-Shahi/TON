<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.thoughtsofnomads.model.User, com.thoughtsofnomads.model.UserProfile,
                 com.thoughtsofnomads.model.Category, com.thoughtsofnomads.model.Tag,
                 java.util.List, java.util.Map" %>
<%
    User        user     = (User) session.getAttribute("user");
    UserProfile profile  = (UserProfile) request.getAttribute("userProfile");
    List<Category> categories = (List<Category>) request.getAttribute("categories");
    Map<Integer,Integer> depthMap = (Map<Integer,Integer>) request.getAttribute("categoryDepths");
    List<Tag>  tags      = (List<Tag>) request.getAttribute("tags");

    String fullName   = (profile != null && profile.getFullName()      != null) ? profile.getFullName()      : "Contributor";
    String initials   = (profile != null) ? profile.getInitials() : "?";
    String profilePic = (profile != null && profile.getProfilePicture() != null) ? profile.getProfilePicture() : "";

    // Restore form state on validation failure
    String formTitle      = (String) request.getAttribute("formTitle");
    String formContent    = (String) request.getAttribute("formContent");
    String formCategoryId = (String) request.getAttribute("formCategoryId");
    String formTagIds     = (String) request.getAttribute("formTagIds");
    String errorMsg       = (String) request.getAttribute("errorMsg");

    String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Write Article — Thoughts of Nomads</title>
    <link href="https://fonts.googleapis.com/css2?family=Epilogue:wght@400;600;700&family=Work+Sans:wght@400;500;600&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" rel="stylesheet"/>
    <!-- Quill Snow theme -->
    <link href="https://cdn.quilljs.com/1.3.7/quill.snow.css" rel="stylesheet"/>
    <style>
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
    body {
        font-family: 'Work Sans', sans-serif;
        background-color: #f4f5f7;
        color: #191c1d;
        -webkit-font-smoothing: antialiased;
        min-height: 100vh;
        display: flex;
        flex-direction: column;
    }
    a { text-decoration: none; color: inherit; }
    button { cursor: pointer; font-family: inherit; }
    .material-symbols-outlined {
        font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
        vertical-align: middle; line-height: 1;
    }

    /* ── Member Topbar ───────────────────────────────────────── */
    .member-topbar {
        position: sticky; top: 0; z-index: 100;
        background: #ffffff; border-bottom: 1px solid #e1e3e4;
        height: 56px; display: flex; align-items: center;
        justify-content: space-between; padding: 0 48px; gap: 16px;
        flex-shrink: 0;
    }
    @media (max-width: 767px) { .member-topbar { padding: 0 20px; } }

    .topbar-back {
        display: inline-flex; align-items: center; gap: 6px;
        padding: 6px 14px; border-radius: 20px;
        border: 1px solid #e1e3e4; background: #f8f9fa;
        font-size: 12px; font-weight: 600; color: #45464e;
        text-transform: uppercase; letter-spacing: 0.07em;
        transition: background-color 0.15s, color 0.15s, border-color 0.15s;
        white-space: nowrap;
    }
    .topbar-back:hover { background-color: #0e193e; color: #fff; border-color: #0e193e; }
    .topbar-back .material-symbols-outlined { font-size: 15px; }

    .topbar-brand {
        font-family: 'Epilogue', sans-serif; font-size: 15px; font-weight: 700;
        color: #0e193e; text-transform: uppercase; letter-spacing: 0.1em;
        position: absolute; left: 50%; transform: translateX(-50%);
    }
    @media (max-width: 600px) { .topbar-brand { display: none; } }

    .topbar-user { display: flex; align-items: center; gap: 10px; }
    .topbar-name { font-size: 13px; font-weight: 600; color: #0e193e; }
    @media (max-width: 480px) { .topbar-name { display: none; } }

    .topbar-avatar {
        width: 32px; height: 32px; border-radius: 50%;
        background-color: #00695c; flex-shrink: 0;
        display: flex; align-items: center; justify-content: center;
        font-family: 'Epilogue', sans-serif; font-size: 11px; font-weight: 700; color: #fff;
        overflow: hidden; position: relative;
    }
    .topbar-avatar img { width: 100%; height: 100%; object-fit: cover; position: absolute; inset: 0; }
    .topbar-logout {
        display: flex; align-items: center; justify-content: center;
        width: 32px; height: 32px; border-radius: 6px; color: #76767f;
        transition: background-color 0.15s, color 0.15s;
    }
    .topbar-logout:hover { background-color: #fce4ec; color: #c62828; }
    .topbar-logout .material-symbols-outlined { font-size: 18px; }

    /* ── Page Layout ─────────────────────────────────────────── */
    .write-container {
        flex: 1;
        max-width: 1200px;
        margin: 0 auto;
        padding: 28px 48px 60px;
        width: 100%;
        display: grid;
        grid-template-columns: 1fr 340px;
        gap: 24px;
        align-items: start;
    }
    @media (max-width: 960px) {
        .write-container { grid-template-columns: 1fr; padding: 20px 24px 60px; }
    }
    @media (max-width: 600px) {
        .write-container { padding: 16px 16px 60px; }
    }

    /* ── Error Banner ─────────────────────────────────────────── */
    .error-banner {
        background-color: #fce4ec;
        border: 1px solid #f48fb1;
        border-radius: 8px;
        padding: 12px 16px;
        display: flex; align-items: center; gap: 10px;
        font-size: 14px; color: #c62828;
        margin-bottom: 20px;
        grid-column: 1 / -1;
    }
    .error-banner .material-symbols-outlined { font-size: 20px; flex-shrink: 0; }

    /* ── Writing Panel ───────────────────────────────────────── */
    .writing-panel {
        background: #ffffff;
        border-radius: 12px;
        border: 1px solid #e1e3e4;
        overflow: hidden;
        display: flex;
        flex-direction: column;
    }

    .title-area {
        padding: 24px 28px 0;
        border-bottom: 1px solid #f0f1f3;
    }
    .title-input {
        width: 100%;
        border: none;
        outline: none;
        resize: none;
        font-family: 'Epilogue', sans-serif;
        font-size: 30px;
        font-weight: 700;
        color: #0e193e;
        line-height: 1.25;
        padding: 0 0 18px;
        background: transparent;
        overflow: hidden;
        min-height: 48px;
    }
    .title-input::placeholder { color: #b0b3b8; }

    /* Override Quill Snow theme for embedded use */
    .quill-wrapper {
        flex: 1;
    }
    .quill-wrapper .ql-toolbar.ql-snow {
        border: none;
        border-bottom: 1px solid #e8e9ec;
        padding: 10px 20px;
        font-family: 'Work Sans', sans-serif;
    }
    .quill-wrapper .ql-container.ql-snow {
        border: none;
        font-family: 'Work Sans', sans-serif;
        font-size: 16px;
    }
    .quill-wrapper .ql-editor {
        min-height: 420px;
        padding: 20px 28px;
        line-height: 1.75;
        color: #2d2f31;
    }
    .quill-wrapper .ql-editor.ql-blank::before {
        color: #b0b3b8;
        font-style: normal;
        left: 28px;
        right: 28px;
    }
    .quill-wrapper .ql-editor h1,
    .quill-wrapper .ql-editor h2,
    .quill-wrapper .ql-editor h3 {
        font-family: 'Epilogue', sans-serif;
        color: #0e193e;
        margin-top: 20px;
        margin-bottom: 8px;
    }
    .quill-wrapper .ql-editor blockquote {
        border-left: 4px solid #0e193e;
        margin: 12px 0;
        padding: 8px 16px;
        color: #5a5d63;
        font-style: italic;
        background: #f8f9fa;
    }
    .quill-wrapper .ql-editor pre.ql-syntax {
        background: #1e2030;
        color: #c0caf5;
        border-radius: 6px;
        padding: 16px;
        font-size: 13.5px;
    }

    .editor-footer {
        padding: 10px 28px;
        border-top: 1px solid #f0f1f3;
        display: flex; align-items: center; justify-content: space-between;
        font-size: 12px; color: #9b9ea4;
    }
    .word-count { display: flex; align-items: center; gap: 5px; }

    /* ── Sidebar ─────────────────────────────────────────────── */
    .sidebar { display: flex; flex-direction: column; gap: 16px; }

    .card {
        background: #ffffff;
        border: 1px solid #e1e3e4;
        border-radius: 12px;
        overflow: hidden;
    }
    .card-header {
        padding: 14px 18px;
        border-bottom: 1px solid #f0f1f3;
        font-size: 11px; font-weight: 700;
        letter-spacing: 0.1em; text-transform: uppercase;
        color: #45464e;
        display: flex; align-items: center; gap: 7px;
    }
    .card-header .material-symbols-outlined { font-size: 16px; color: #76767f; }
    .card-body { padding: 16px 18px; }

    /* Publish card */
    .publish-status {
        display: flex; align-items: center; gap: 8px;
        font-size: 13px; color: #5a5d63;
        margin-bottom: 14px;
        padding: 10px 12px;
        background: #f8f9fa;
        border-radius: 8px;
        border: 1px solid #e8e9ec;
    }
    .publish-status .status-dot {
        width: 8px; height: 8px; border-radius: 50%; background: #9b9ea4; flex-shrink: 0;
    }
    .publish-actions { display: flex; flex-direction: column; gap: 10px; }

    .btn-draft {
        display: flex; align-items: center; justify-content: center; gap: 7px;
        padding: 10px 16px; border-radius: 8px;
        border: 1px solid #c0c2c8; background: #ffffff;
        font-size: 13px; font-weight: 600; color: #45464e;
        transition: background-color 0.15s, border-color 0.15s;
        width: 100%;
    }
    .btn-draft:hover { background-color: #f4f5f7; border-color: #9b9ea4; }
    .btn-draft .material-symbols-outlined { font-size: 17px; }

    .btn-submit {
        display: flex; align-items: center; justify-content: center; gap: 7px;
        padding: 10px 16px; border-radius: 8px;
        border: none; background: #0e193e;
        font-size: 13px; font-weight: 600; color: #ffffff;
        transition: background-color 0.15s, opacity 0.15s;
        width: 100%;
    }
    .btn-submit:hover { background-color: #1a2d5a; }
    .btn-submit .material-symbols-outlined { font-size: 17px; }

    .publish-note {
        margin-top: 10px;
        font-size: 11.5px; color: #9b9ea4; line-height: 1.5;
        text-align: center;
    }

    /* Cover image card */
    .cover-dropzone {
        border: 2px dashed #d0d2d8;
        border-radius: 8px;
        padding: 20px;
        text-align: center;
        cursor: pointer;
        transition: border-color 0.2s, background-color 0.2s;
        position: relative;
    }
    .cover-dropzone:hover, .cover-dropzone.dragover {
        border-color: #0e193e;
        background-color: #f0f2f8;
    }
    .cover-dropzone input[type="file"] {
        position: absolute; inset: 0; width: 100%; height: 100%;
        opacity: 0; cursor: pointer;
    }
    .cover-icon { color: #9b9ea4; margin-bottom: 8px; }
    .cover-icon .material-symbols-outlined { font-size: 32px; }
    .cover-text-main { font-size: 13px; font-weight: 600; color: #45464e; }
    .cover-text-sub  { font-size: 11px; color: #9b9ea4; margin-top: 3px; }

    .cover-preview-wrap { position: relative; border-radius: 8px; overflow: hidden; }
    .cover-preview-wrap img {
        width: 100%; height: 160px; object-fit: cover; display: block; border-radius: 8px;
    }
    .cover-remove {
        position: absolute; top: 6px; right: 6px;
        background: rgba(0,0,0,0.55); color: #fff;
        border: none; border-radius: 50%;
        width: 28px; height: 28px;
        display: flex; align-items: center; justify-content: center;
        cursor: pointer; transition: background-color 0.15s;
    }
    .cover-remove:hover { background: rgba(198,40,40,0.85); }
    .cover-remove .material-symbols-outlined { font-size: 16px; }

    /* Category card */
    .field-label {
        display: block; font-size: 11.5px; font-weight: 600;
        color: #45464e; margin-bottom: 6px; letter-spacing: 0.04em;
    }
    .field-select {
        width: 100%;
        padding: 9px 12px;
        border-radius: 8px;
        border: 1px solid #d0d2d8;
        background: #ffffff;
        font-family: 'Work Sans', sans-serif;
        font-size: 13.5px;
        color: #191c1d;
        appearance: none;
        background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='16' height='16' viewBox='0 0 24 24' fill='none' stroke='%2376767f' stroke-width='2'%3E%3Cpolyline points='6 9 12 15 18 9'/%3E%3C/svg%3E");
        background-repeat: no-repeat;
        background-position: right 10px center;
        padding-right: 32px;
        cursor: pointer;
        outline: none;
        transition: border-color 0.15s;
    }
    .field-select:focus { border-color: #0e193e; }

    /* Tags card */
    .tags-grid {
        display: flex; flex-wrap: wrap; gap: 8px;
        min-height: 36px;
    }
    .tag-chip {
        display: inline-flex; align-items: center; gap: 4px;
        padding: 5px 12px; border-radius: 20px;
        border: 1.5px solid #d0d2d8;
        background: #ffffff;
        font-size: 12.5px; font-weight: 500; color: #45464e;
        cursor: pointer;
        transition: background-color 0.15s, border-color 0.15s, color 0.15s;
        user-select: none;
    }
    .tag-chip:hover { border-color: #0e193e; color: #0e193e; }
    .tag-chip.selected {
        background: #0e193e; border-color: #0e193e; color: #ffffff;
    }
    .tag-chip.selected .tag-check { display: inline; }
    .tag-check {
        display: none;
        font-size: 14px;
    }
    .tags-empty {
        font-size: 12.5px; color: #9b9ea4; font-style: italic;
    }
    </style>
</head>
<body>

<!-- ── Topbar ──────────────────────────────────────────── -->
<nav class="member-topbar">
    <a href="<%=cp%>/member/dashboard" class="topbar-back">
        <span class="material-symbols-outlined">arrow_back</span>
        Dashboard
    </a>
    <span class="topbar-brand">Thoughts of Nomads</span>
    <div class="topbar-user">
        <span class="topbar-name"><%=fullName%></span>
        <div class="topbar-avatar">
            <%=initials%>
            <% if (!profilePic.isEmpty()) { %><img src="<%= cp %>/<%= profilePic %>" alt=""/><% } %>
        </div>
        <a href="<%=cp%>/auth/logout" class="topbar-logout" title="Sign out">
            <span class="material-symbols-outlined">logout</span>
        </a>
    </div>
</nav>

<!-- ── Main Form ───────────────────────────────────────── -->
<form id="articleForm" method="post" action="<%=cp%>/member/articles/new" enctype="multipart/form-data">

    <!-- Hidden inputs populated by JS before submit -->
    <input type="hidden" name="content"    id="hiddenContent"/>
    <input type="hidden" name="categoryId" id="hiddenCategoryId"/>
    <input type="hidden" name="tagIds"     id="hiddenTagIds" value="<%=formTagIds != null ? formTagIds : ""%>"/>
    <input type="hidden" name="action"     id="hiddenAction"  value="draft"/>

    <div class="write-container">

        <%-- Error banner --%>
        <% if (errorMsg != null) { %>
        <div class="error-banner">
            <span class="material-symbols-outlined">error</span>
            <%=errorMsg%>
        </div>
        <% } %>

        <!-- ── Writing Panel ── -->
        <div class="writing-panel">
            <div class="title-area">
                <textarea
                    id="titleInput"
                    name="title"
                    class="title-input"
                    rows="1"
                    placeholder="Article title…"
                    maxlength="255"
                ><%=formTitle != null ? formTitle : ""%></textarea>
            </div>

            <div class="quill-wrapper">
                <div id="quillEditor"><%=formContent != null ? formContent : ""%></div>
            </div>

            <div class="editor-footer">
                <span class="word-count">
                    <span class="material-symbols-outlined" style="font-size:14px;">text_fields</span>
                    <span id="wordCount">0</span> words
                </span>
                <span>Autosave off — use Save Draft to keep your work</span>
            </div>
        </div>

        <!-- ── Sidebar ── -->
        <aside class="sidebar">

            <!-- Publish -->
            <div class="card">
                <div class="card-header">
                    <span class="material-symbols-outlined">send</span>
                    Publish
                </div>
                <div class="card-body">
                    <div class="publish-status">
                        <div class="status-dot"></div>
                        Unsaved draft
                    </div>
                    <div class="publish-actions">
                        <button type="button" class="btn-draft" onclick="submitAs('draft')">
                            <span class="material-symbols-outlined">save</span>
                            Save Draft
                        </button>
                        <button type="button" class="btn-submit" onclick="submitAs('submit')">
                            <span class="material-symbols-outlined">send</span>
                            Submit for Review
                        </button>
                    </div>
                    <p class="publish-note">Submitting sends your article to an admin for approval before it goes live.</p>
                </div>
            </div>

            <!-- Cover Image -->
            <div class="card">
                <div class="card-header">
                    <span class="material-symbols-outlined">image</span>
                    Cover Image
                </div>
                <div class="card-body">
                    <div id="coverDropzone" class="cover-dropzone">
                        <input type="file" name="coverImage" id="coverFileInput" accept="image/*"/>
                        <div class="cover-icon"><span class="material-symbols-outlined">add_photo_alternate</span></div>
                        <div class="cover-text-main">Click to upload</div>
                        <div class="cover-text-sub">PNG, JPG, WEBP · max 5 MB</div>
                    </div>
                    <div id="coverPreviewWrap" class="cover-preview-wrap" style="display:none;">
                        <img id="coverPreviewImg" src="" alt="Cover preview"/>
                        <button type="button" class="cover-remove" onclick="removeCover()" title="Remove cover">
                            <span class="material-symbols-outlined">close</span>
                        </button>
                    </div>
                </div>
            </div>

            <!-- Category -->
            <div class="card">
                <div class="card-header">
                    <span class="material-symbols-outlined">folder</span>
                    Category
                </div>
                <div class="card-body">
                    <label class="field-label" for="categorySelect">Select a category</label>
                    <select id="categorySelect" class="field-select">
                        <option value="">— Choose category —</option>
                        <%
                            if (categories != null) {
                                for (Category cat : categories) {
                                    int depth = (depthMap != null && depthMap.containsKey(cat.getId()))
                                                ? depthMap.get(cat.getId()) : 0;
                                    StringBuilder indent = new StringBuilder();
                                    for (int d = 0; d < depth; d++) indent.append("    ");
                                    String arrow = depth > 0 ? "↳ " : "";
                                    String selected = (formCategoryId != null && formCategoryId.equals(String.valueOf(cat.getId())))
                                                      ? " selected" : "";
                        %>
                        <option value="<%=cat.getId()%>"<%=selected%>><%=indent%><%=arrow%><%=cat.getName()%></option>
                        <% } } %>
                    </select>
                </div>
            </div>

            <!-- Tags -->
            <div class="card">
                <div class="card-header">
                    <span class="material-symbols-outlined">sell</span>
                    Tags
                </div>
                <div class="card-body">
                    <% if (tags == null || tags.isEmpty()) { %>
                    <span class="tags-empty">No tags available yet.</span>
                    <% } else { %>
                    <div class="tags-grid" id="tagsGrid">
                        <%
                            String savedTagIds = formTagIds != null ? formTagIds : "";
                            for (Tag tag : tags) {
                                boolean preSelected = savedTagIds.contains(String.valueOf(tag.getId()));
                        %>
                        <span class="tag-chip <%=preSelected ? "selected" : ""%>"
                              data-id="<%=tag.getId()%>"
                              onclick="toggleTag(this)">
                            <span class="tag-check">✓</span>
                            <%=tag.getName()%>
                        </span>
                        <% } %>
                    </div>
                    <% } %>
                </div>
            </div>

        </aside><!-- /sidebar -->
    </div><!-- /write-container -->
</form>

<!-- Quill JS -->
<script src="https://cdn.quilljs.com/1.3.7/quill.min.js"></script>
<script>
// ── Quill editor setup ────────────────────────────────────────
const quill = new Quill('#quillEditor', {
    theme: 'snow',
    placeholder: 'Tell your story… describe the journey, the people, the moments.',
    modules: {
        toolbar: [
            [{ header: [2, 3, false] }],
            ['bold', 'italic', 'underline', 'strike'],
            [{ list: 'ordered' }, { list: 'bullet' }],
            ['blockquote', 'code-block'],
            ['link', 'image'],
            [{ align: [] }],
            ['clean']
        ]
    }
});

// Custom image handler: upload to server, insert URL (not base64)
quill.getModule('toolbar').addHandler('image', function() {
    const input = document.createElement('input');
    input.type = 'file';
    input.accept = 'image/*';
    input.click();
    input.addEventListener('change', function() {
        const file = input.files[0];
        if (!file) return;
        const range = quill.getSelection(true);

        // Temporary placeholder while uploading
        quill.insertText(range.index, 'Uploading image…', { italic: true, color: '#9b9ea4' });
        quill.setSelection(range.index + 18);

        const form = new FormData();
        form.append('image', file);

        fetch('<%=cp%>/member/upload/image', { method: 'POST', body: form })
            .then(res => res.json())
            .then(data => {
                // Remove placeholder text, insert the real image
                quill.deleteText(range.index, 18);
                if (data.url) {
                    quill.insertEmbed(range.index, 'image', data.url);
                    quill.setSelection(range.index + 1);
                } else {
                    alert('Image upload failed: ' + (data.error || 'unknown error'));
                }
            })
            .catch(() => {
                quill.deleteText(range.index, 18);
                alert('Image upload failed. Please try again.');
            });
    });
});

// Word count
function updateWordCount() {
    const text = quill.getText().trim();
    const count = text.length === 0 ? 0 : text.split(/\s+/).length;
    document.getElementById('wordCount').textContent = count;
}
quill.on('text-change', updateWordCount);

// ── Auto-resize title textarea ────────────────────────────────
const titleInput = document.getElementById('titleInput');
function autoResizeTitle() {
    titleInput.style.height = 'auto';
    titleInput.style.height = titleInput.scrollHeight + 'px';
}
titleInput.addEventListener('input', autoResizeTitle);
autoResizeTitle(); // init on load

// ── Cover image preview ───────────────────────────────────────
const coverFileInput    = document.getElementById('coverFileInput');
const coverDropzone     = document.getElementById('coverDropzone');
const coverPreviewWrap  = document.getElementById('coverPreviewWrap');
const coverPreviewImg   = document.getElementById('coverPreviewImg');

coverFileInput.addEventListener('change', function() {
    const file = this.files[0];
    if (!file) return;
    const reader = new FileReader();
    reader.onload = function(e) {
        coverPreviewImg.src = e.target.result;
        coverDropzone.style.display = 'none';
        coverPreviewWrap.style.display = 'block';
    };
    reader.readAsDataURL(file);
});

coverDropzone.addEventListener('dragover', function(e) {
    e.preventDefault();
    this.classList.add('dragover');
});
coverDropzone.addEventListener('dragleave', function() {
    this.classList.remove('dragover');
});
coverDropzone.addEventListener('drop', function(e) {
    e.preventDefault();
    this.classList.remove('dragover');
    const file = e.dataTransfer.files[0];
    if (file && file.type.startsWith('image/')) {
        const dt = new DataTransfer();
        dt.items.add(file);
        coverFileInput.files = dt.files;
        coverFileInput.dispatchEvent(new Event('change'));
    }
});

function removeCover() {
    coverFileInput.value = '';
    coverPreviewImg.src = '';
    coverPreviewWrap.style.display = 'none';
    coverDropzone.style.display = 'block';
}

// ── Tag chip toggle ───────────────────────────────────────────
const selectedTagIds = new Set();

// Pre-populate from restored form state
const initialTagIds = document.getElementById('hiddenTagIds').value;
if (initialTagIds) {
    initialTagIds.split(',').forEach(id => { if (id.trim()) selectedTagIds.add(id.trim()); });
}
// Visually mark pre-selected chips
document.querySelectorAll('.tag-chip').forEach(chip => {
    if (selectedTagIds.has(String(chip.dataset.id))) chip.classList.add('selected');
});

function toggleTag(chip) {
    const id = String(chip.dataset.id);
    if (selectedTagIds.has(id)) {
        selectedTagIds.delete(id);
        chip.classList.remove('selected');
    } else {
        selectedTagIds.add(id);
        chip.classList.add('selected');
    }
    document.getElementById('hiddenTagIds').value = Array.from(selectedTagIds).join(',');
}

// ── Category select sync ──────────────────────────────────────
const categorySelect = document.getElementById('categorySelect');
categorySelect.addEventListener('change', function() {
    document.getElementById('hiddenCategoryId').value = this.value;
});
// Sync on page load (for restored state)
document.getElementById('hiddenCategoryId').value = categorySelect.value;

// ── Form submit ───────────────────────────────────────────────
function submitAs(action) {
    const title = titleInput.value.trim();
    if (!title) {
        titleInput.focus();
        titleInput.style.borderBottom = '2px solid #c62828';
        titleInput.placeholder = 'Please enter a title…';
        titleInput.scrollIntoView({ behavior: 'smooth', block: 'center' });
        return;
    }
    const catId = categorySelect.value;
    if (!catId) {
        categorySelect.style.borderColor = '#c62828';
        categorySelect.scrollIntoView({ behavior: 'smooth', block: 'center' });
        setTimeout(() => { categorySelect.style.borderColor = ''; }, 3000);
        return;
    }
    const contentHtml = quill.root.innerHTML;
    const textOnly = quill.getText().trim();
    if (!textOnly) {
        quill.root.style.outline = '2px solid #c62828';
        quill.focus();
        return;
    }

    document.getElementById('hiddenContent').value    = contentHtml;
    document.getElementById('hiddenCategoryId').value = catId;
    document.getElementById('hiddenTagIds').value     = Array.from(selectedTagIds).join(',');
    document.getElementById('hiddenAction').value     = action;
    formDirty = false; // prevent beforeunload prompt on intentional submit
    document.getElementById('articleForm').submit();
}

// ── Warn before leaving with unsaved content ──────────────────
let formDirty = false;
quill.on('text-change', () => { formDirty = true; });
titleInput.addEventListener('input', () => { formDirty = true; });
window.addEventListener('beforeunload', function(e) {
    if (formDirty) {
        e.preventDefault();
        e.returnValue = '';
    }
});
document.getElementById('articleForm').addEventListener('submit', () => { formDirty = false; });
</script>
</body>
</html>
