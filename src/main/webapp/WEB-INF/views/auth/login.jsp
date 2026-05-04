<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <title>Secure Login - Thoughts of Nomads</title>
    
    <!-- Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Epilogue:wght@700&family=Work+Sans:wght@400;600;700&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet" />

    <style>
        /* ── TOKENS ── */
        :root {
            --primary: #0e193e;
            --primary-container: #242e54;
            --surface: #f8f9fa;
            --outline-variant: #c6c5cf;
            --on-surface: #191c1d;
            --on-surface-variant: #45464e;
            --error: #ba1a1a;
            --error-container: #ffdad6;
            --radius: 4px;
        }

        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        
        body {
            font-family: 'Work Sans', sans-serif;
            height: 100vh;
            overflow: hidden;
            background-color: #ffffff;
            -webkit-font-smoothing: antialiased;
        }

        .auth-main {
            display: flex;
            height: 100%;
            width: 100%;
        }

        /* ── LEFT PANEL: IMAGE ── */
        .auth-image-panel {
            position: relative;
            flex: 1;
            display: none; /* Hidden on mobile */
            overflow: hidden;
        }

        @media (min-width: 768px) {
            .auth-image-panel { display: block; }
        }

        .auth-image {
            width: 100%;
            height: 100%;
            object-fit: cover;
            filter: contrast(1.05);
        }

        .auth-back-btn {
            position: absolute;
            top: 32px;
            left: 32px;
            z-index: 10;
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 10px 20px;
            background: #ffffff;
            border: none;
            border-radius: 6px;
            font-size: 11px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.1em;
            color: var(--on-surface);
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            text-decoration: none;
        }

        /* ── RIGHT PANEL: FORM ── */
        .auth-form-panel {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 40px;
            overflow-y: auto;
        }

        .auth-form-wrapper {
            width: 100%;
            max-width: 400px;
        }

        /* Security Alert (Pink box from image) */
        .auth-error-box {
            background-color: var(--error-container);
            border: 1px solid rgba(186, 26, 26, 0.15);
            padding: 20px;
            border-radius: var(--radius);
            display: flex;
            gap: 16px;
            margin-bottom: 32px;
        }

        .auth-error-icon { color: var(--error); font-size: 20px; }
        .auth-error-title {
            font-size: 10px;
            font-weight: 700;
            letter-spacing: 0.1em;
            color: var(--error);
            text-transform: uppercase;
            margin-bottom: 4px;
        }
        .auth-error-msg {
            font-size: 13px;
            line-height: 1.5;
            color: var(--on-surface-variant);
        }

        /* Typography */
        .auth-header { margin-bottom: 48px; }
        .auth-title {
            font-family: 'Epilogue', sans-serif;
            font-size: 44px;
            font-weight: 700;
            color: var(--primary-container);
            margin-bottom: 12px;
        }
        .auth-subtitle {
            font-size: 18px;
            color: var(--on-surface-variant);
        }

        /* Form Controls */
        .form-group { margin-bottom: 24px; }
        .form-label-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
        }
        .form-label {
            font-size: 10px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.1em;
            color: var(--on-surface);
        }
        .auth-forgot-link {
            font-size: 10px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            color: var(--on-surface);
            text-decoration: none;
        }

        .form-input-wrapper { position: relative; }
        .form-input {
            width: 100%;
            padding: 14px 16px;
            background-color: var(--surface);
            border: 1px solid var(--outline-variant);
            border-radius: var(--radius);
            font-family: 'Work Sans', sans-serif;
            font-size: 16px;
            outline: none;
            transition: border-color 0.2s;
        }
        .form-input:focus { border-color: var(--primary-container); }
        
        .password-toggle-btn {
            position: absolute;
            right: 16px;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            border: none;
            color: var(--on-surface-variant);
            cursor: pointer;
        }

        /* Submit Button */
        .auth-submit-btn {
            width: 100%;
            background-color: var(--primary-container);
            color: #ffffff;
            padding: 18px;
            border: none;
            border-radius: var(--radius);
            font-family: 'Work Sans', sans-serif;
            font-size: 12px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.12em;
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 10px;
            cursor: pointer;
            margin-top: 8px;
        }

        /* Footer Text */
        .auth-footer {
            margin-top: 64px;
            text-align: center;
            font-size: 15px;
            color: var(--on-surface-variant);
        }
        .auth-link {
            font-weight: 700;
            color: var(--primary-container);
            text-decoration: none;
            margin-left: 4px;
        }
    </style>
</head>

<body>
    <main class="auth-main">
        
        <!-- Left Side: Image + Back Button -->
        <div class="auth-image-panel">
            <a class="auth-back-btn" href="<%=request.getContextPath()%>/">
                <span class="material-symbols-outlined" style="font-size: 18px;">arrow_back</span>
                Back
            </a>
            <img alt="Travel imagery" class="auth-image" src="https://lh3.googleusercontent.com/aida-public/AB6AXuBN6Upeshm-JuQm69iCqDKAwes0pAorHC3lE72d054emQoOl8kvQfRVe914colmlHEv0l0OMdR4YqTkCJLlJQH2Qiur4gxm51qCtIMEya5xF2s9yGW8nhfDsa3Q7sC5-EYCdKa6UFp0-efLYDjrb91iTPpnue0LSLdrG6NVqOw6_78_QQG6cKxLB4GMGs3R5fbJXH8E8unvCUmNj7CYq4rFwZv3tZsHA7z99UWE4YsWiVMmTeBnTOPprm4XzpIX6qC76ZO_1ac3bxo" />
        </div>

        <!-- Right Side: Form Content -->
        <div class="auth-form-panel">
            <div class="auth-form-wrapper">
                
                <!-- Security Feedback (Stylized as pink box from image) -->
                <% if (request.getAttribute("error") != null) { %>
                    <div class="auth-error-box">
                        <span class="material-symbols-outlined auth-error-icon">lock_clock</span>
                        <div>
                            <h3 class="auth-error-title">Security Alert</h3>
                            <p class="auth-error-msg"><%= request.getAttribute("error") %></p>
                        </div>
                    </div>
                <% } %>

                <div class="auth-header">
                    <h1 class="auth-title">Sign In</h1>
                    <p class="auth-subtitle">Continue your journey with curated insights.</p>
                </div>

                <form action="<%=request.getContextPath()%>/auth/login" method="POST">
                    
                    <div class="form-group">
                        <label class="form-label" for="email">Email Address</label>
                        <input class="form-input" id="email" name="email" placeholder="nomad@example.com" required type="email" />
                    </div>

                    <div class="form-group">
                        <div class="form-label-row">
                            <label class="form-label" for="password">Password</label>
                            <a class="auth-forgot-link" href="<%=request.getContextPath()%>/auth/forgot-password">Forgot Password?</a>
                        </div>
                        <div class="form-input-wrapper">
                            <input class="form-input" id="password" name="password" placeholder="••••••••" required type="password" />
                            <button class="password-toggle-btn" type="button" onclick="const p=document.getElementById('password'); const i=this.querySelector('span'); if(p.type==='password'){p.type='text';i.innerText='visibility_off';}else{p.type='password';i.innerText='visibility';}">
                                <span class="material-symbols-outlined" style="font-size: 20px;">visibility</span>
                            </button>
                        </div>
                    </div>

                    <button class="auth-submit-btn" type="submit">
                        Sign In
                        <span class="material-symbols-outlined" style="font-size: 18px;">arrow_forward</span>
                    </button>
                </form>

                <div class="auth-footer">
                    Not a member?
                    <a class="auth-link" href="<%=request.getContextPath()%>/auth/register">Register now.</a>
                </div>

            </div>
        </div>
    </main>
</body>
</html>