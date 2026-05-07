<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    Boolean verified = (Boolean) session.getAttribute("resetVerified");
    if (!Boolean.TRUE.equals(verified)) {
        response.sendRedirect(request.getContextPath() + "/auth/forgot-password");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Set New Password — Thoughts of Nomads</title>
    <link href="https://fonts.googleapis.com/css2?family=Epilogue:wght@700&family=Work+Sans:wght@400;600;700&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
    <style>
        :root { --primary: #0e193e; --primary-container: #242e54; --outline-variant: #c6c5cf; --error: #ba1a1a; --radius: 4px; }
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Work Sans', sans-serif; min-height: 100vh; display: flex; align-items: center; justify-content: center; background: #ffffff; -webkit-font-smoothing: antialiased; }

        .container { width: 100%; max-width: 440px; padding: 24px; }

        .icon-wrap {
            width: 64px; height: 64px; border-radius: 50%; background: #e8f5e9;
            display: flex; align-items: center; justify-content: center; margin: 0 auto 24px;
        }
        .icon-wrap .material-symbols-outlined {
            font-size: 30px; color: #2e7d32;
            font-variation-settings: 'FILL' 1,'wght' 400,'GRAD' 0,'opsz' 32;
        }

        h1 { font-family: 'Epilogue', sans-serif; font-size: 30px; font-weight: 700; color: #191c1d; margin-bottom: 8px; text-align: center; }
        .subtitle { font-size: 14px; color: #45464e; text-align: center; margin-bottom: 32px; line-height: 1.6; }

        .form-group { margin-bottom: 18px; }
        .form-group label { display: block; font-size: 12px; font-weight: 700; text-transform: uppercase; letter-spacing: 0.1em; color: #45464e; margin-bottom: 7px; }
        .input-wrap { position: relative; }
        .form-group input {
            width: 100%; padding: 13px 40px 13px 14px; border-radius: var(--radius);
            border: 1px solid var(--outline-variant); font-family: inherit; font-size: 15px;
            outline: none; transition: border-color 0.2s, box-shadow 0.2s;
        }
        .form-group input:focus { border-color: var(--primary-container); box-shadow: 0 0 0 1px var(--primary-container); }
        .toggle-btn {
            position: absolute; right: 10px; top: 50%; transform: translateY(-50%);
            background: none; border: none; cursor: pointer; color: #76767f; padding: 4px;
        }
        .toggle-btn .material-symbols-outlined { font-size: 18px; vertical-align: middle; }

        .strength-bar { height: 4px; background: #f0f2f5; border-radius: 2px; margin-top: 6px; overflow: hidden; }
        .strength-fill { height: 100%; border-radius: 2px; transition: width 0.3s, background-color 0.3s; width: 0; }
        .strength-label { font-size: 11px; font-weight: 600; margin-top: 4px; }

        .match-label { font-size: 11px; font-weight: 600; margin-top: 4px; }

        .error-msg { color: var(--error); font-size: 14px; font-weight: 600; margin-bottom: 18px; }

        .submit-btn {
            width: 100%; padding: 16px; margin-top: 8px;
            background: var(--primary-container); color: #fff;
            border: none; border-radius: var(--radius); font-family: inherit;
            font-size: 13px; font-weight: 700; text-transform: uppercase; letter-spacing: 0.12em;
            cursor: pointer; transition: opacity 0.2s;
        }
        .submit-btn:hover { opacity: 0.9; }
    </style>
</head>
<body>
    <main class="container">
        <div class="icon-wrap">
            <span class="material-symbols-outlined">verified_user</span>
        </div>
        <h1>Set New Password</h1>
        <p class="subtitle">Identity verified. Choose a strong new password for your account.</p>

        <% if (request.getAttribute("error") != null) { %>
        <p class="error-msg"><%= request.getAttribute("error") %></p>
        <% } %>

        <form method="post" action="<%= request.getContextPath() %>/auth/forgot-password">
            <input type="hidden" name="step" value="reset"/>

            <div class="form-group">
                <label for="newPassword">New Password</label>
                <div class="input-wrap">
                    <input type="password" id="newPassword" name="newPassword"
                           placeholder="At least 8 characters" autocomplete="new-password"
                           oninput="checkStrength(this.value)" required/>
                    <button type="button" class="toggle-btn" onclick="toggleVis('newPassword', this)">
                        <span class="material-symbols-outlined">visibility</span>
                    </button>
                </div>
                <div class="strength-bar"><div class="strength-fill" id="strengthFill"></div></div>
                <div class="strength-label" id="strengthLabel" style="color:#9b9ea4;"></div>
            </div>

            <div class="form-group">
                <label for="confirmPassword">Confirm Password</label>
                <div class="input-wrap">
                    <input type="password" id="confirmPassword" name="confirmPassword"
                           placeholder="Repeat your new password" autocomplete="new-password"
                           oninput="checkMatch()" required/>
                    <button type="button" class="toggle-btn" onclick="toggleVis('confirmPassword', this)">
                        <span class="material-symbols-outlined">visibility</span>
                    </button>
                </div>
                <div class="match-label" id="matchLabel" style="color:#9b9ea4;"></div>
            </div>

            <button type="submit" class="submit-btn">Update Password</button>
        </form>
    </main>

<script>
function toggleVis(id, btn) {
    var inp = document.getElementById(id);
    var icon = btn.querySelector('span');
    if (inp.type === 'password') { inp.type = 'text'; icon.innerText = 'visibility_off'; }
    else { inp.type = 'password'; icon.innerText = 'visibility'; }
}

function checkStrength(val) {
    var fill = document.getElementById('strengthFill');
    var label = document.getElementById('strengthLabel');
    var score = 0;
    if (val.length >= 8)  score++;
    if (/[A-Z]/.test(val)) score++;
    if (/[0-9]/.test(val)) score++;
    if (/[^A-Za-z0-9]/.test(val)) score++;
    var pct   = ['0%','25%','50%','75%','100%'][score];
    var color = ['#f44336','#ff9800','#ffc107','#66bb6a','#2e7d32'][score];
    var text  = ['','Weak','Fair','Good','Strong'][score];
    fill.style.width = pct;
    fill.style.backgroundColor = color;
    label.textContent = text;
    label.style.color = color;
    checkMatch();
}

function checkMatch() {
    var np = document.getElementById('newPassword').value;
    var cp = document.getElementById('confirmPassword').value;
    var label = document.getElementById('matchLabel');
    if (!cp) { label.textContent = ''; return; }
    if (np === cp) { label.textContent = 'Passwords match'; label.style.color = '#2e7d32'; }
    else           { label.textContent = 'Passwords do not match'; label.style.color = '#c62828'; }
}
</script>
</body>
</html>
