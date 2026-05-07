<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Forgot Password — Thoughts of Nomads</title>
    <link href="https://fonts.googleapis.com/css2?family=Epilogue:wght@700&family=Work+Sans:wght@400;600;700&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
    <style>
        :root { --primary: #0e193e; --primary-container: #242e54; --outline-variant: #c6c5cf; --error: #ba1a1a; --radius: 4px; }
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Work Sans', sans-serif; min-height: 100vh; display: flex; align-items: center; justify-content: center; background: #ffffff; -webkit-font-smoothing: antialiased; }

        .back-btn {
            position: absolute; top: 32px; left: 32px;
            display: flex; align-items: center; gap: 8px;
            text-decoration: none; color: #191c1d;
            font-size: 11px; font-weight: 700; text-transform: uppercase; letter-spacing: 0.1em;
            transition: transform 0.2s ease;
        }
        .back-btn:hover { transform: translateX(-4px); }
        .back-btn .material-symbols-outlined { font-size: 18px; vertical-align: middle; }

        .container { width: 100%; max-width: 460px; padding: 24px; text-align: center; }

        .icon-wrap {
            width: 64px; height: 64px; border-radius: 50%;
            background: #eef0f8; display: flex; align-items: center; justify-content: center;
            margin: 0 auto 24px;
        }
        .icon-wrap .material-symbols-outlined {
            font-size: 30px; color: var(--primary);
            font-variation-settings: 'FILL' 1,'wght' 400,'GRAD' 0,'opsz' 32;
        }

        h1 { font-family: 'Epilogue', sans-serif; font-size: 32px; font-weight: 700; color: #191c1d; margin-bottom: 12px; }
        .subtitle { font-size: 15px; color: #45464e; line-height: 1.6; margin-bottom: 36px; }

        .form-group { text-align: left; margin-bottom: 20px; }
        .form-group label { display: block; font-size: 12px; font-weight: 700; text-transform: uppercase; letter-spacing: 0.1em; color: #45464e; margin-bottom: 8px; }
        .form-group input {
            width: 100%; padding: 14px 16px; border-radius: var(--radius);
            border: 1px solid var(--outline-variant); font-family: inherit; font-size: 15px;
            outline: none; transition: border-color 0.2s, box-shadow 0.2s;
        }
        .form-group input:focus { border-color: var(--primary-container); box-shadow: 0 0 0 1px var(--primary-container); }

        .error-msg { color: var(--error); font-size: 14px; font-weight: 600; margin-bottom: 20px; text-align: left; }

        .submit-btn {
            width: 100%; padding: 16px; background: var(--primary-container); color: #fff;
            border: none; border-radius: var(--radius); font-family: inherit;
            font-size: 13px; font-weight: 700; text-transform: uppercase; letter-spacing: 0.12em;
            cursor: pointer; transition: opacity 0.2s;
        }
        .submit-btn:hover { opacity: 0.9; }

        .footer { margin-top: 28px; font-size: 14px; color: #45464e; }
        .footer a { color: var(--primary); font-weight: 600; text-decoration: underline; text-underline-offset: 3px; }
    </style>
</head>
<body>
    <a href="<%= request.getContextPath() %>/auth/login" class="back-btn">
        <span class="material-symbols-outlined">arrow_back</span>
        Back to login
    </a>

    <main class="container">
        <div class="icon-wrap">
            <span class="material-symbols-outlined">lock_reset</span>
        </div>
        <h1>Reset Password</h1>
        <p class="subtitle">Enter your account email and we'll send you a 6-digit code to reset your password.</p>

        <% if (request.getAttribute("error") != null) { %>
        <p class="error-msg"><%= request.getAttribute("error") %></p>
        <% } %>

        <form method="post" action="<%= request.getContextPath() %>/auth/forgot-password">
            <input type="hidden" name="step" value="email"/>
            <div class="form-group">
                <label for="email">Email Address</label>
                <input type="email" id="email" name="email" placeholder="nomad@example.com"
                       value="<%= request.getParameter("email") != null ? request.getParameter("email") : "" %>"
                       required autofocus/>
            </div>
            <button type="submit" class="submit-btn">Send Reset Code</button>
        </form>

        <p class="footer">Remembered it? <a href="<%= request.getContextPath() %>/auth/login">Sign in</a></p>
    </main>
</body>
</html>
