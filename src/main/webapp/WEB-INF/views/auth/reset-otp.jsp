<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String resetEmail = (String) session.getAttribute("resetEmail");
    if (resetEmail == null) {
        response.sendRedirect(request.getContextPath() + "/auth/forgot-password");
        return;
    }
    // Mask email for display
    int at = resetEmail.indexOf('@');
    String maskedEmail = resetEmail;
    if (at > 2) {
        maskedEmail = resetEmail.substring(0, 2)
            + "*".repeat(at - 2)
            + resetEmail.substring(at);
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Enter Reset Code — Thoughts of Nomads</title>
    <link href="https://fonts.googleapis.com/css2?family=Epilogue:wght@700&family=Work+Sans:wght@400;600;700&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
    <style>
        :root { --primary: #0e193e; --primary-container: #1a213e; --outline-variant: #c6c5cf; --error: #ba1a1a; --radius: 4px; }
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Work Sans', sans-serif; min-height: 100vh; display: flex; align-items: center; justify-content: center; background: #ffffff; -webkit-font-smoothing: antialiased; overflow: hidden; }

        .back-btn {
            position: absolute; top: 32px; left: 32px;
            display: flex; align-items: center; gap: 8px; text-decoration: none; color: #191c1d;
            font-size: 11px; font-weight: 700; text-transform: uppercase; letter-spacing: 0.1em;
            transition: transform 0.2s ease;
        }
        .back-btn:hover { transform: translateX(-4px); }
        .back-btn .material-symbols-outlined { font-size: 18px; vertical-align: middle; }

        .container { width: 100%; max-width: 500px; padding: 24px; text-align: center; }

        h1 { font-family: 'Epilogue', sans-serif; font-size: 40px; font-weight: 700; color: #191c1d; margin-bottom: 16px; }
        .subtitle { font-size: 16px; color: #45464e; line-height: 1.6; margin-bottom: 40px; }
        .subtitle strong { color: #191c1d; }

        .otp-form { display: flex; flex-direction: column; gap: 36px; }
        .otp-input-group { display: flex; justify-content: center; gap: 12px; }
        .otp-input {
            width: 56px; height: 64px; text-align: center;
            font-family: 'Epilogue', sans-serif; font-size: 24px; font-weight: 700;
            border: 1px solid var(--outline-variant); border-radius: var(--radius);
            outline: none; transition: border-color 0.2s, box-shadow 0.2s;
        }
        .otp-input:focus { border-color: var(--primary-container); box-shadow: 0 0 0 1px var(--primary-container); }
        .otp-input::-webkit-outer-spin-button, .otp-input::-webkit-inner-spin-button { -webkit-appearance: none; }
        .otp-input[type=number] { -moz-appearance: textfield; }

        .error-msg { color: var(--error); font-size: 14px; font-weight: 600; }

        .submit-btn {
            background: var(--primary-container); color: #fff; padding: 18px;
            border: none; border-radius: var(--radius); font-family: inherit;
            font-size: 13px; font-weight: 700; text-transform: uppercase; letter-spacing: 0.12em;
            cursor: pointer; transition: opacity 0.2s;
        }
        .submit-btn:hover { opacity: 0.9; }

        .footer { margin-top: 28px; font-size: 15px; color: #45464e; }
        .resend-btn {
            color: var(--primary-container); text-decoration: underline; text-underline-offset: 4px;
            font-weight: 700; background: none; border: none; cursor: pointer; font-family: inherit;
            font-size: 15px; margin-left: 4px;
        }
    </style>
</head>
<body>
    <a href="<%= request.getContextPath() %>/auth/forgot-password" class="back-btn">
        <span class="material-symbols-outlined">arrow_back</span>
        Back
    </a>

    <main class="container">
        <h1>Check Your Email</h1>
        <p class="subtitle">
            We sent a 6-digit code to <strong><%= maskedEmail %></strong>.<br/>
            Enter it below to continue. The code expires in 10 minutes.
        </p>

        <% if (request.getAttribute("error") != null) { %>
        <p class="error-msg" style="margin-bottom:24px;"><%= request.getAttribute("error") %></p>
        <% } %>

        <form class="otp-form" method="post" action="<%= request.getContextPath() %>/auth/forgot-password"
              onsubmit="combineOtp()">
            <input type="hidden" name="step" value="otp"/>
            <input type="hidden" name="otp"  id="otp_hidden" value=""/>

            <div class="otp-input-group">
                <input class="otp-input" type="number" maxlength="1" placeholder="•" required/>
                <input class="otp-input" type="number" maxlength="1" placeholder="•" required/>
                <input class="otp-input" type="number" maxlength="1" placeholder="•" required/>
                <input class="otp-input" type="number" maxlength="1" placeholder="•" required/>
                <input class="otp-input" type="number" maxlength="1" placeholder="•" required/>
                <input class="otp-input" type="number" maxlength="1" placeholder="•" required/>
            </div>

            <button type="submit" class="submit-btn">Verify Code</button>
        </form>

        <p class="footer">
            Didn't receive a code?
            <form method="post" action="<%= request.getContextPath() %>/auth/forgot-password" style="display:inline;">
                <input type="hidden" name="step"  value="email"/>
                <input type="hidden" name="email" value="<%= resetEmail %>"/>
                <button type="submit" class="resend-btn">Resend Code</button>
            </form>
        </p>
    </main>

    <script>
        function combineOtp() {
            var inputs = document.querySelectorAll('.otp-input');
            var otpStr = '';
            inputs.forEach(function(i) { otpStr += i.value; });
            document.getElementById('otp_hidden').value = otpStr;
        }

        document.addEventListener('DOMContentLoaded', function() {
            var inputs = document.querySelectorAll('.otp-input');
            inputs.forEach(function(input, index) {
                input.addEventListener('input', function() {
                    if (input.value.length === 1 && index < inputs.length - 1) {
                        inputs[index + 1].focus();
                    }
                });
                input.addEventListener('keydown', function(e) {
                    if (e.key === 'Backspace' && input.value === '' && index > 0) {
                        inputs[index - 1].focus();
                    }
                });
            });
            if (inputs.length > 0) inputs[0].focus();
        });
    </script>
</body>
</html>
