<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.thoughtsofnomads.model.User, com.thoughtsofnomads.model.UserProfile" %>
<%
    User        user    = (User)        session.getAttribute("user");
    UserProfile profile = (UserProfile) request.getAttribute("userProfile");

    String fullName      = (profile != null && profile.getFullName()      != null) ? profile.getFullName()      : "";
    String contactNumber = (profile != null && profile.getContactNumber()  != null) ? profile.getContactNumber() : "";
    String bio           = (profile != null && profile.getBio()            != null) ? profile.getBio()           : "";
    String profilePic    = (profile != null && profile.getProfilePicture() != null) ? profile.getProfilePicture() : "";
    String initials      = (profile != null) ? profile.getInitials() : "?";

    String flashSuccess = (String) session.getAttribute("flashSuccess");
    String flashError   = (String) session.getAttribute("flashError");
    if (flashSuccess != null) session.removeAttribute("flashSuccess");
    if (flashError   != null) session.removeAttribute("flashError");

    String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Profile Settings — Thoughts of Nomads</title>
    <link href="https://fonts.googleapis.com/css2?family=Epilogue:wght@400;600;700&family=Work+Sans:wght@400;500;600&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" rel="stylesheet"/>
    <style>
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
    body { font-family: 'Work Sans', sans-serif; background-color: #f8f9fa; color: #191c1d; -webkit-font-smoothing: antialiased; }
    a { text-decoration: none; color: inherit; }
    button { cursor: pointer; font-family: inherit; }
    .material-symbols-outlined { font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24; vertical-align: middle; line-height: 1; }

    /* ── Topbar ──────────────────────────────────── */
    .member-topbar {
        position: sticky; top: 0; z-index: 100;
        background: #ffffff; border-bottom: 1px solid #e1e3e4;
        height: 56px; display: flex; align-items: center;
        justify-content: space-between; padding: 0 48px; gap: 16px;
    }
    @media (max-width: 767px) { .member-topbar { padding: 0 20px; } }

    .topbar-back {
        display: inline-flex; align-items: center; gap: 6px;
        padding: 6px 14px; border-radius: 20px;
        border: 1px solid #e1e3e4; background: #f8f9fa;
        font-size: 12px; font-weight: 600; color: #45464e;
        text-transform: uppercase; letter-spacing: 0.07em;
        transition: background-color 0.15s ease, color 0.15s ease, border-color 0.15s ease;
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
        transition: background-color 0.15s ease, color 0.15s ease;
    }
    .topbar-logout:hover { background-color: #fce4ec; color: #c62828; }
    .topbar-logout .material-symbols-outlined { font-size: 18px; }

    /* ── Page container ──────────────────────────── */
    .page-container {
        max-width: 760px; margin: 40px auto; padding: 0 24px 80px;
    }
    @media (max-width: 767px) { .page-container { padding: 0 16px 60px; margin-top: 24px; } }

    /* ── Page header ─────────────────────────────── */
    .page-header { margin-bottom: 28px; }
    .page-header h1 { font-family: 'Epilogue', sans-serif; font-size: 24px; font-weight: 700; color: #0e193e; }
    .page-header p  { font-size: 14px; color: #76767f; margin-top: 4px; }

    /* ── Flash alerts ────────────────────────────── */
    .alert {
        display: flex; align-items: flex-start; gap: 10px;
        padding: 14px 16px; border-radius: 6px; font-size: 14px; font-weight: 500;
        margin-bottom: 24px;
    }
    .alert .material-symbols-outlined { font-size: 18px; flex-shrink: 0; margin-top: 1px; }
    .alert-success { background-color: #e8f5e9; color: #2e7d32; border: 1px solid #c8e6c9; }
    .alert-error   { background-color: #fce4ec; color: #c62828; border: 1px solid #f8bbd0; }

    /* ── Section card ────────────────────────────── */
    .settings-section {
        background: #fff; border: 1px solid #e1e3e4; border-radius: 10px;
        margin-bottom: 20px; overflow: hidden;
    }
    .section-header {
        display: flex; align-items: center; gap: 10px;
        padding: 18px 24px; border-bottom: 1px solid #f0f2f5;
        background: #fafbfc;
    }
    .section-header .material-symbols-outlined {
        font-size: 20px; color: #0e193e;
        font-variation-settings: 'FILL' 1, 'wght' 400, 'GRAD' 0, 'opsz' 20;
    }
    .section-title { font-family: 'Epilogue', sans-serif; font-size: 15px; font-weight: 700; color: #0e193e; }
    .section-body  { padding: 24px; }

    /* ── Avatar area ─────────────────────────────── */
    .avatar-row { display: flex; align-items: center; gap: 20px; margin-bottom: 24px; }
    .avatar-circle {
        width: 76px; height: 76px; border-radius: 50%; flex-shrink: 0;
        background-color: #00695c;
        display: flex; align-items: center; justify-content: center;
        font-family: 'Epilogue', sans-serif; font-size: 26px; font-weight: 700; color: #fff;
        overflow: hidden; border: 2px solid #e1e3e4; position: relative;
    }
    .avatar-circle img { width: 100%; height: 100%; object-fit: cover; border-radius: 50%; }
    .avatar-info { flex: 1; min-width: 0; }
    .avatar-info h3 { font-size: 15px; font-weight: 600; color: #0e193e; margin-bottom: 4px; }
    .avatar-info p  { font-size: 13px; color: #76767f; margin-bottom: 10px; line-height: 1.5; }
    .btn-upload {
        display: inline-flex; align-items: center; gap: 6px;
        padding: 7px 14px; border-radius: 5px;
        border: 1px solid #c6c5cf; background: #fff; color: #45464e;
        font-size: 12px; font-weight: 600; text-transform: uppercase; letter-spacing: 0.07em;
        cursor: pointer; transition: background-color 0.15s ease, border-color 0.15s ease;
    }
    .btn-upload:hover { background-color: #f3f4f5; border-color: #9b9ea4; }
    .btn-upload .material-symbols-outlined { font-size: 15px; }
    .upload-hint { font-size: 12px; color: #9b9ea4; margin-top: 6px; }

    /* ── Form fields ─────────────────────────────── */
    .form-row { display: grid; grid-template-columns: 1fr 1fr; gap: 16px; }
    @media (max-width: 520px) { .form-row { grid-template-columns: 1fr; } }

    .form-group { display: flex; flex-direction: column; gap: 6px; margin-bottom: 16px; }
    .form-group label { font-size: 13px; font-weight: 600; color: #45464e; }
    .form-group input,
    .form-group textarea {
        width: 100%; padding: 10px 12px; border-radius: 5px;
        border: 1px solid #c6c5cf; background: #fff; color: #191c1d;
        font-family: 'Work Sans', sans-serif; font-size: 14px;
        transition: border-color 0.15s ease, box-shadow 0.15s ease;
        outline: none;
    }
    .form-group input:focus,
    .form-group textarea:focus { border-color: #0e193e; box-shadow: 0 0 0 3px rgba(14,25,62,0.08); }
    .form-group textarea { resize: vertical; min-height: 88px; line-height: 1.55; }
    .form-hint { font-size: 12px; color: #9b9ea4; }

    /* ── Password strength indicator ────────────── */
    .strength-bar { height: 4px; border-radius: 2px; background: #f0f2f5; margin-top: 6px; overflow: hidden; }
    .strength-fill { height: 100%; border-radius: 2px; transition: width 0.3s, background-color 0.3s; width: 0; }
    .strength-label { font-size: 11px; font-weight: 600; margin-top: 4px; }

    /* ── Form footer ─────────────────────────────── */
    .form-footer { display: flex; justify-content: flex-end; padding-top: 8px; }
    .btn-save {
        display: inline-flex; align-items: center; gap: 7px;
        padding: 10px 22px; border: none; border-radius: 5px;
        background-color: #0e193e; color: #fff;
        font-family: 'Work Sans', sans-serif; font-size: 13px; font-weight: 600;
        text-transform: uppercase; letter-spacing: 0.07em;
        cursor: pointer; transition: background-color 0.15s ease;
    }
    .btn-save:hover { background-color: #242e54; }
    .btn-save .material-symbols-outlined { font-size: 16px; }

    /* ── Danger zone ─────────────────────────────── */
    .danger-section {
        background: #fff; border: 1px solid #fce4ec; border-radius: 10px; padding: 20px 24px;
    }
    .danger-title { font-family: 'Epilogue', sans-serif; font-size: 14px; font-weight: 700; color: #c62828; margin-bottom: 6px; }
    .danger-desc  { font-size: 13px; color: #76767f; line-height: 1.5; }
    </style>
</head>
<body>

    <!-- ── Topbar ──────────────────────────────────────────── -->
    <header class="member-topbar">
        <a href="<%= cp %>/member/dashboard" class="topbar-back">
            <span class="material-symbols-outlined">arrow_back</span>
            Dashboard
        </a>
        <div class="topbar-brand">Thoughts of Nomads</div>
        <div class="topbar-user">
            <span class="topbar-name"><%= fullName.isEmpty() ? user.getEmail() : fullName %></span>
            <div class="topbar-avatar">
                <% if (!profilePic.isEmpty()) { %>
                <img src="<%= cp %>/<%= profilePic %>" alt=""/>
                <% } else { %><%= initials %><% } %>
            </div>
            <a href="<%= cp %>/" class="topbar-back">
                <span class="material-symbols-outlined">open_in_new</span>
                View Site
            </a>
        </div>
    </header>

    <div class="page-container">

        <div class="page-header">
            <h1>Profile Settings</h1>
            <p>Manage your personal information and account security.</p>
        </div>

        <!-- Flash messages -->
        <% if (flashSuccess != null) { %>
        <div class="alert alert-success">
            <span class="material-symbols-outlined">check_circle</span>
            <%= flashSuccess %>
        </div>
        <% } %>
        <% if (flashError != null) { %>
        <div class="alert alert-error">
            <span class="material-symbols-outlined">error</span>
            <%= flashError %>
        </div>
        <% } %>

        <!-- ── Profile Info ────────────────────────────────── -->
        <div class="settings-section">
            <div class="section-header">
                <span class="material-symbols-outlined">person</span>
                <span class="section-title">Profile Information</span>
            </div>
            <div class="section-body">
                <form method="post" action="<%= cp %>/member/profile" id="profileForm">
                    <input type="hidden" name="section" value="profile"/>
                    <input type="hidden" name="profilePicture" id="profilePictureInput" value="<%= profilePic %>"/>

                    <!-- Avatar upload -->
                    <div class="avatar-row">
                        <div class="avatar-circle" id="avatarCircle">
                            <% if (!profilePic.isEmpty()) { %>
                            <img id="avatarImg" src="<%= cp %>/<%= profilePic %>" alt=""/>
                            <% } else { %>
                            <span id="avatarInitials"><%= initials %></span>
                            <% } %>
                        </div>
                        <div class="avatar-info">
                            <h3>Profile Photo</h3>
                            <p>Upload a clear photo. JPG, PNG, or WEBP, max 5 MB.</p>
                            <button type="button" class="btn-upload" id="uploadBtn">
                                <span class="material-symbols-outlined">upload</span>
                                Choose Photo
                            </button>
                            <input type="file" id="avatarFileInput" accept="image/*" style="display:none;"/>
                            <div class="upload-hint" id="uploadHint"></div>
                        </div>
                    </div>

                    <!-- Name + Contact -->
                    <div class="form-row">
                        <div class="form-group">
                            <label for="fullName">Full Name <span style="color:#c62828">*</span></label>
                            <input type="text" id="fullName" name="fullName"
                                   value="<%= fullName %>" placeholder="Your full name" required/>
                        </div>
                        <div class="form-group">
                            <label for="contactNumber">Contact Number</label>
                            <input type="tel" id="contactNumber" name="contactNumber"
                                   value="<%= contactNumber %>" placeholder="+1 234 567 8900"/>
                        </div>
                    </div>

                    <!-- Email (read-only) -->
                    <div class="form-group">
                        <label>Email Address</label>
                        <input type="email" value="<%= user.getEmail() %>" disabled
                               style="background:#f8f9fa;color:#9b9ea4;cursor:not-allowed;"/>
                        <span class="form-hint">Email cannot be changed here. Contact an admin if needed.</span>
                    </div>

                    <!-- Bio -->
                    <div class="form-group">
                        <label for="bio">Bio</label>
                        <textarea id="bio" name="bio" placeholder="Tell readers a little about yourself…"><%= bio %></textarea>
                        <span class="form-hint">Shown on your published articles. Keep it short and interesting.</span>
                    </div>

                    <div class="form-footer">
                        <button type="submit" class="btn-save">
                            <span class="material-symbols-outlined">save</span>
                            Save Profile
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <!-- ── Change Password ────────────────────────────── -->
        <div class="settings-section">
            <div class="section-header">
                <span class="material-symbols-outlined">lock</span>
                <span class="section-title">Change Password</span>
            </div>
            <div class="section-body">
                <form method="post" action="<%= cp %>/member/profile" id="passwordForm">
                    <input type="hidden" name="section" value="password"/>

                    <div class="form-group">
                        <label for="currentPassword">Current Password</label>
                        <input type="password" id="currentPassword" name="currentPassword"
                               placeholder="Enter your current password" autocomplete="current-password"/>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="newPassword">New Password</label>
                            <input type="password" id="newPassword" name="newPassword"
                                   placeholder="At least 8 characters" autocomplete="new-password"
                                   oninput="checkStrength(this.value)"/>
                            <div class="strength-bar"><div class="strength-fill" id="strengthFill"></div></div>
                            <div class="strength-label" id="strengthLabel" style="color:#9b9ea4;"></div>
                        </div>
                        <div class="form-group">
                            <label for="confirmPassword">Confirm New Password</label>
                            <input type="password" id="confirmPassword" name="confirmPassword"
                                   placeholder="Repeat new password" autocomplete="new-password"
                                   oninput="checkMatch()"/>
                            <div class="strength-label" id="matchLabel" style="color:#9b9ea4;"></div>
                        </div>
                    </div>

                    <div class="form-footer" style="justify-content:space-between;align-items:center;">
                        <a href="<%= cp %>/auth/forgot-password"
                           style="font-size:13px;color:#76767f;text-decoration:underline;text-underline-offset:3px;">
                            Forgot your password?
                        </a>
                        <button type="submit" class="btn-save">
                            <span class="material-symbols-outlined">key</span>
                            Update Password
                        </button>
                    </div>
                </form>
            </div>
        </div>

    </div><!-- page-container -->

<script>
/* ── Avatar upload ─────────────────────────────────────────── */
document.getElementById('uploadBtn').addEventListener('click', function() {
    document.getElementById('avatarFileInput').click();
});

document.getElementById('avatarFileInput').addEventListener('change', function() {
    var file = this.files[0];
    if (!file) return;

    if (file.size > 5 * 1024 * 1024) {
        document.getElementById('uploadHint').textContent = 'File too large (max 5 MB).';
        document.getElementById('uploadHint').style.color = '#c62828';
        return;
    }

    var hint = document.getElementById('uploadHint');
    hint.textContent = 'Uploading…';
    hint.style.color = '#76767f';

    var formData = new FormData();
    formData.append('image', file);

    fetch('<%= cp %>/member/upload/image', { method: 'POST', body: formData })
        .then(function(r) { return r.json(); })
        .then(function(data) {
            if (data.url) {
                document.getElementById('profilePictureInput').value = data.url;
                hint.textContent = 'Photo ready — save profile to apply.';
                hint.style.color = '#2e7d32';

                // Update avatar preview
                var circle = document.getElementById('avatarCircle');
                var initials = circle.querySelector('#avatarInitials');
                var existingImg = circle.querySelector('#avatarImg');
                if (existingImg) existingImg.remove();
                if (initials) initials.style.display = 'none';

                var img = document.createElement('img');
                img.id  = 'avatarImg';
                img.src = data.url;  // data.url already includes the context path
                img.alt = '';
                circle.appendChild(img);
            } else {
                hint.textContent = data.error || 'Upload failed.';
                hint.style.color = '#c62828';
            }
        })
        .catch(function() {
            hint.textContent = 'Upload failed. Please try again.';
            hint.style.color = '#c62828';
        });
});

/* ── Password strength ─────────────────────────────────────── */
function checkStrength(val) {
    var fill  = document.getElementById('strengthFill');
    var label = document.getElementById('strengthLabel');
    var score = 0;
    if (val.length >= 8)  score++;
    if (/[A-Z]/.test(val)) score++;
    if (/[0-9]/.test(val)) score++;
    if (/[^A-Za-z0-9]/.test(val)) score++;

    var pct   = ['0%', '25%', '50%', '75%', '100%'][score];
    var color = ['#f44336','#ff9800','#ffc107','#66bb6a','#2e7d32'][score];
    var text  = ['','Weak','Fair','Good','Strong'][score];
    fill.style.width = pct;
    fill.style.backgroundColor = color;
    label.textContent = text;
    label.style.color = color;
    checkMatch();
}

function checkMatch() {
    var np    = document.getElementById('newPassword').value;
    var cp    = document.getElementById('confirmPassword').value;
    var label = document.getElementById('matchLabel');
    if (!cp) { label.textContent = ''; return; }
    if (np === cp) {
        label.textContent = 'Passwords match';
        label.style.color = '#2e7d32';
    } else {
        label.textContent = 'Passwords do not match';
        label.style.color = '#c62828';
    }
}
</script>

</body>
</html>
