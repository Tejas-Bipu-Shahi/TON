<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <title>Register - Thoughts of Nomads</title>
    
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

        /* Registration card wrapper to match your screenshot */
        .auth-card {
            width: 100%;
            max-width: 500px;
            background-color: #ffffff;
            border: 1px solid var(--outline-variant);
            border-radius: var(--radius);
            padding: 48px;
            margin: 40px 0;
        }

        /* Registration Failed box (pink background) */
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
        .auth-header { margin-bottom: 40px; text-align: center; }
        .auth-title {
            font-family: 'Epilogue', sans-serif;
            font-size: 40px;
            font-weight: 700;
            color: var(--primary-container);
            margin-bottom: 12px;
        }
        .auth-subtitle {
            font-size: 16px;
            color: var(--on-surface-variant);
        }

        /* Form Controls */
        .form-group { margin-bottom: 20px; }
        .form-label {
            display: block;
            font-size: 10px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.1em;
            color: var(--on-surface);
            margin-bottom: 10px;
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
            margin-top: 24px;
        }

        /* Footer Text */
        .auth-footer {
            margin-top: 32px;
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
        
        <!-- Left Side: Himalayan Landscape Imagery -->
        <div class="auth-image-panel">
            <a class="auth-back-btn" href="<%=request.getContextPath()%>/">
                <span class="material-symbols-outlined" style="font-size: 18px;">arrow_back</span>
                Back
            </a>
            <!-- New Himalayan Image -->
            <img alt="High-altitude Himalayan peaks" class="auth-image" src="https://i.pinimg.com/1200x/74/5f/b8/745fb8c273c1efb715fefd59adffe50f.jpg" />
        </div>

        <!-- Right Side: Registration Canvas -->
        <div class="auth-form-panel">
            <div class="auth-card">
                
                <div class="auth-header">
                    <h1 class="auth-title">Join Our Community</h1>
                    <p class="auth-subtitle">Become a contributor and share your nomadic journeys.</p>
                </div>

                <!-- Registration Feedback (Pink box) -->
                <% if (request.getAttribute("error") != null) { %>
                    <div class="auth-error-box">
                        <span class="material-symbols-outlined auth-error-icon">error</span>
                        <div>
                            <h3 class="auth-error-title">Registration Failed</h3>
                            <p class="auth-error-msg"><%= request.getAttribute("error") %></p>
                        </div>
                    </div>
                <% } %>

                <form action="<%=request.getContextPath()%>/auth/register" method="POST">
                    
                    <div class="form-group">
                        <label class="form-label" for="fullName">Full Name</label>
                        <input class="form-input" id="fullName" name="fullName" placeholder="John Doe" 
                               value="<%= request.getParameter("fullName") != null ? request.getParameter("fullName") : "" %>" required type="text" />
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="email">Email Address</label>
                        <input class="form-input" id="email" name="email" placeholder="alex@example.com" 
                               value="<%= request.getParameter("email") != null ? request.getParameter("email") : "" %>" required type="email" />
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="phone">Contact Number</label>
                        <input class="form-input" id="phone" name="phone" placeholder="+1 (555) 000-0000" 
                               value="<%= request.getParameter("phone") != null ? request.getParameter("phone") : "" %>" required type="tel" />
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="password">Password</label>
                        <div class="form-input-wrapper">
                            <input class="form-input" id="password" name="password" placeholder="••••••••" required type="password" />
                            <button class="password-toggle-btn" type="button" onclick="const p=document.getElementById('password'); const i=this.querySelector('span'); if(p.type==='password'){p.type='text';i.innerText='visibility_off';}else{p.type='password';i.innerText='visibility';}">
                                <span class="material-symbols-outlined" style="font-size: 20px;">visibility</span>
                            </button>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="confirmPassword">Confirm Password</label>
                        <div class="form-input-wrapper">
                            <input class="form-input" id="confirmPassword" name="confirmPassword" placeholder="••••••••" required type="password" />
                            <button class="password-toggle-btn" type="button" onclick="const p=document.getElementById('confirmPassword'); const i=this.querySelector('span'); if(p.type==='password'){p.type='text';i.innerText='visibility_off';}else{p.type='password';i.innerText='visibility';}">
                                <span class="material-symbols-outlined" style="font-size: 20px;">visibility</span>
                            </button>
                        </div>
                    </div>

                    <button class="auth-submit-btn" type="submit">
                        Join as a Contributor
                    </button>
                </form>

                <div class="auth-footer">
                    Already a member?
                    <a class="auth-link" href="<%=request.getContextPath()%>/auth/login">Sign in here.</a>
                </div>

            </div>
        </div>
    </main>
</body>
</html>