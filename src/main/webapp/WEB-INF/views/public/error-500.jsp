<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Server Error — Thoughts of Nomads</title>
    <link href="https://fonts.googleapis.com/css2?family=Epilogue:wght@400;600;700&family=Work+Sans:wght@400;500;600&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
    <style>
        :root {
            --primary: #0e193e;
            --primary-container: #242e54;
            --on-primary: #ffffff;
            --surface: #ffffff;
            --surface-container: #f3f4f5;
            --on-surface: #191c1d;
            --on-surface-variant: #45464e;
            --background: #f8f9fa;
            --outline-variant: #c6c5cf;
        }

        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

        body {
            font-family: 'Work Sans', sans-serif;
            background-color: var(--background);
            color: var(--on-surface);
            line-height: 1.6;
            -webkit-font-smoothing: antialiased;
        }

        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
            vertical-align: middle;
        }

        .page-layout { display: flex; flex-direction: column; min-height: 100vh; }

        .error-main {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 80px 16px;
        }

        .error-card {
            background: var(--surface);
            border: 1px solid var(--outline-variant);
            border-radius: 12px;
            padding: 64px 48px;
            max-width: 520px;
            width: 100%;
            text-align: center;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .error-code {
            font-family: 'Epilogue', sans-serif;
            font-size: 96px;
            font-weight: 700;
            color: var(--primary);
            line-height: 1;
            margin-bottom: 8px;
            opacity: 0.12;
            letter-spacing: -4px;
        }

        .error-icon-wrap {
            background: #fff4f2;
            width: 72px;
            height: 72px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 24px;
        }

        .error-icon-wrap .material-symbols-outlined {
            font-size: 32px;
            color: #b84034;
        }

        .error-title {
            font-family: 'Epilogue', sans-serif;
            font-size: 28px;
            font-weight: 700;
            color: var(--on-surface);
            margin-bottom: 12px;
        }

        .error-desc {
            font-size: 15px;
            color: var(--on-surface-variant);
            margin-bottom: 36px;
            line-height: 1.65;
            max-width: 380px;
        }

        .btn-row {
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
            justify-content: center;
        }

        .btn-primary {
            background: var(--primary);
            color: var(--on-primary);
            padding: 12px 28px;
            border-radius: 4px;
            font-family: 'Work Sans', sans-serif;
            font-size: 13px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.08em;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: background 0.2s;
        }
        .btn-primary:hover { background: var(--primary-container); }

        .btn-ghost {
            background: transparent;
            color: var(--on-surface-variant);
            padding: 12px 28px;
            border-radius: 4px;
            border: 1px solid var(--outline-variant);
            font-family: 'Work Sans', sans-serif;
            font-size: 13px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.08em;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: border-color 0.2s, color 0.2s;
        }
        .btn-ghost:hover { border-color: var(--primary); color: var(--primary); }
    </style>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css"/>
</head>
<body class="page-layout">
    <jsp:include page="/WEB-INF/views/includes/header.jsp"/>

    <main class="error-main">
        <div class="error-card">
            <div class="error-code">500</div>
            <div class="error-icon-wrap">
                <span class="material-symbols-outlined">warning</span>
            </div>
            <h1 class="error-title">Something Went Wrong</h1>
            <p class="error-desc">
                We hit an unexpected bump on the road. Please try again in a moment or head back to the homepage.
            </p>
            <div class="btn-row">
                <a href="<%= request.getContextPath() %>/" class="btn-primary">
                    <span class="material-symbols-outlined" style="font-size:16px;">home</span>
                    Go Home
                </a>
                <a href="javascript:history.back()" class="btn-ghost">
                    <span class="material-symbols-outlined" style="font-size:16px;">arrow_back</span>
                    Go Back
                </a>
            </div>
        </div>
    </main>

    <jsp:include page="/WEB-INF/views/includes/footer.jsp"/>
</body>
</html>
