<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <title>Verify Your Identity - Thoughts of Nomads</title>
    
    <!-- Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Epilogue:wght@700&family=Work+Sans:wght@400;600;700&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet" />

    <style>
        /* ── TOKENS ── */
        :root {
            --primary: #0e193e;
            --primary-container: #1a213e; /* Darker blue from the image */
            --on-surface: #191c1d;
            --on-surface-variant: #45464e;
            --outline-variant: #c6c5cf;
            --error: #ba1a1a;
            --radius: 4px;
        }

        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        
        body {
            font-family: 'Work Sans', sans-serif;
            height: 100vh;
            width: 100vw;
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: #ffffff;
            -webkit-font-smoothing: antialiased;
            overflow: hidden;
        }

        /* ── BACK BUTTON ── */
        .otp-back-btn {
            position: absolute;
            top: 32px;
            left: 32px;
            display: flex;
            align-items: center;
            gap: 8px;
            text-decoration: none;
            color: var(--on-surface);
            font-size: 11px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.1em;
            transition: transform 0.2s ease;
        }
        .otp-back-btn:hover { transform: translateX(-4px); }

        /* ── CONTAINER ── */
        .otp-container {
            width: 100%;
            max-width: 500px;
            text-align: center;
            padding: 24px;
        }

        .otp-header { margin-bottom: 48px; }
        .otp-title {
            font-family: 'Epilogue', sans-serif;
            font-size: 48px;
            font-weight: 700;
            color: var(--on-surface);
            margin-bottom: 16px;
        }
        .otp-subtitle {
            font-size: 18px;
            color: var(--on-surface-variant);
            line-height: 1.6;
        }
        .otp-subtitle strong { color: var(--on-surface); font-weight: 700; }

        /* ── OTP INPUTS ── */
        .otp-form { display: flex; flex-direction: column; gap: 40px; }
        
        .otp-input-group {
            display: flex;
            justify-content: center;
            gap: 12px;
        }

        .otp-input {
            width: 56px;
            height: 64px;
            text-align: center;
            font-family: 'Epilogue', sans-serif;
            font-size: 24px;
            font-weight: 700;
            border: 1px solid var(--outline-variant);
            border-radius: var(--radius);
            outline: none;
            transition: border-color 0.2s, box-shadow 0.2s;
        }
        .otp-input:focus {
            border-color: var(--primary-container);
            box-shadow: 0 0 0 1px var(--primary-container);
        }

        /* Hide number arrows */
        .otp-input::-webkit-outer-spin-button,
        .otp-input::-webkit-inner-spin-button { -webkit-appearance: none; margin: 0; }
        .otp-input[type=number] { -moz-appearance: textfield; }

        /* ── BUTTON ── */
        .otp-submit-btn {
            background-color: var(--primary-container);
            color: #ffffff;
            padding: 20px;
            border: none;
            border-radius: var(--radius);
            font-family: 'Work Sans', sans-serif;
            font-size: 12px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.15em;
            cursor: pointer;
            transition: opacity 0.2s;
        }
        .otp-submit-btn:hover { opacity: 0.9; }

        /* ── FOOTER ── */
        .otp-footer {
            margin-top: 32px;
            font-size: 16px;
            color: var(--on-surface-variant);
        }
        .resend-link {
            color: var(--primary-container);
            text-decoration: underline;
            text-underline-offset: 4px;
            font-weight: 700;
            background: none;
            border: none;
            cursor: pointer;
            margin-left: 4px;
        }

        /* Error Message */
        .auth-error-msg {
            color: var(--error);
            font-size: 14px;
            margin-bottom: 24px;
            font-weight: 600;
        }
    </style>
</head>

<body>
    
    <a href="<%=request.getContextPath()%>/auth/login" class="otp-back-btn">
        <span class="material-symbols-outlined" style="font-size: 18px;">arrow_back</span>
        Back
    </a>

    <main class="otp-container">
        <header class="otp-header">
            <h1 class="otp-title">Verify Your Identity</h1>
            <p class="otp-subtitle">
                We’ve sent a 6-digit code to <strong><%= session.getAttribute("verificationEmail") != null ? session.getAttribute("verificationEmail") : "nomad@example.com" %></strong>. Please enter it below to continue.
            </p>
        </header>

        <% if (request.getAttribute("error") != null) { %>
            <p class="auth-error-msg"><%= request.getAttribute("error") %></p>
        <% } %>

        <form action="<%=request.getContextPath()%>/auth/verify" method="POST" class="otp-form" onsubmit="combineOtp()">
            <input type="hidden" name="otp" id="otp_hidden" value="">
            
            <script>
                function combineOtp() {
                    const inputs = document.querySelectorAll('.otp-input');
                    let otpStr = "";
                    inputs.forEach(i => otpStr += i.value);
                    document.getElementById('otp_hidden').value = otpStr;
                }
                
                // Optional: Auto-focus next input
                document.addEventListener("DOMContentLoaded", () => {
                    const inputs = document.querySelectorAll('.otp-input');
                    inputs.forEach((input, index) => {
                        input.addEventListener('input', () => {
                            if (input.value.length === 1 && index < inputs.length - 1) {
                                inputs[index + 1].focus();
                            }
                        });
                    });
                });
            </script>

            <div class="otp-input-group">
                <input class="otp-input" maxlength="1" placeholder="•" type="number" required />
                <input class="otp-input" maxlength="1" placeholder="•" type="number" required />
                <input class="otp-input" maxlength="1" placeholder="•" type="number" required />
                <input class="otp-input" maxlength="1" placeholder="•" type="number" required />
                <input class="otp-input" maxlength="1" placeholder="•" type="number" required />
                <input class="otp-input" maxlength="1" placeholder="•" type="number" required />
            </div>

            <button class="otp-submit-btn" type="submit">
                Verify Code
            </button>
        </form>

        <div class="otp-footer">
            Didn't receive a code?
            <button class="resend-link" type="button">Resend Code</button>
        </div>
    </main>
</body>
</html>