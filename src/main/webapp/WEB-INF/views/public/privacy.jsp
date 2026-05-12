<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <title>Privacy Policy - Thoughts of Nomads</title>

    <link href="https://fonts.googleapis.com/css2?family=Epilogue:wght@400;600;700&family=Work+Sans:wght@400;500;600&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet" />

    <style>
        :root {
            --primary: #0e193e;
            --primary-container: #242e54;
            --surface: #ffffff;
            --surface-container-low: #f3f4f5;
            --on-surface: #191c1d;
            --on-surface-variant: #45464e;
            --background: #f8f9fa;
            --outline-variant: #c6c5cf;
            --container-max: 800px;
            --margin-desktop: 48px;
            --margin-mobile: 16px;
            --radius: 4px;
        }

        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

        body {
            font-family: 'Work Sans', sans-serif;
            background-color: var(--background);
            color: var(--on-surface);
            line-height: 1.7;
            -webkit-font-smoothing: antialiased;
        }

        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
            vertical-align: middle;
        }

        .page-layout { display: flex; flex-direction: column; min-height: 100vh; }

        .page-main {
            flex-grow: 1;
            max-width: var(--container-max);
            margin: 0 auto;
            padding: 80px var(--margin-mobile);
            width: 100%;
        }
        @media (min-width: 768px) { .page-main { padding: 80px var(--margin-desktop); } }

        .page-header { margin-bottom: 56px; border-bottom: 1px solid var(--outline-variant); padding-bottom: 32px; }

        .page-eyebrow {
            font-size: 11px; font-weight: 700; text-transform: uppercase;
            letter-spacing: 0.12em; color: var(--on-surface-variant); margin-bottom: 12px;
        }

        .page-title {
            font-family: 'Epilogue', sans-serif;
            font-size: 40px; font-weight: 700;
            color: var(--primary); margin-bottom: 12px;
        }

        .page-meta { font-size: 13px; color: var(--on-surface-variant); }

        .doc-section { margin-bottom: 40px; }

        .doc-section h2 {
            font-family: 'Epilogue', sans-serif;
            font-size: 20px; font-weight: 600;
            color: var(--primary); margin-bottom: 12px;
        }

        .doc-section p { font-size: 15px; color: var(--on-surface-variant); margin-bottom: 12px; }
        .doc-section p:last-child { margin-bottom: 0; }

        .doc-section ul {
            padding-left: 20px; display: flex; flex-direction: column; gap: 8px;
        }
        .doc-section ul li { font-size: 15px; color: var(--on-surface-variant); }

        .doc-section a { color: var(--primary); text-underline-offset: 3px; }
    </style>
</head>

<body class="page-layout">
    <jsp:include page="/WEB-INF/views/includes/header.jsp" />

    <main class="page-main">
        <header class="page-header">
            <p class="page-eyebrow">Legal</p>
            <h1 class="page-title">Privacy Policy</h1>
            <p class="page-meta">Effective date: January 1, 2025 &nbsp;·&nbsp; Last updated: January 1, 2025</p>
        </header>

        <div class="doc-section">
            <p>Thoughts of Nomads ("we", "our", or "us") is committed to protecting your privacy. This policy explains what information we collect, how we use it, and your rights regarding your data when you use <strong>thoughtsofnomads.com</strong>.</p>
        </div>

        <div class="doc-section">
            <h2>1. Information We Collect</h2>
            <p>We collect the following types of information:</p>
            <ul>
                <li><strong>Account information</strong> — name, email address, and password when you register</li>
                <li><strong>Profile information</strong> — bio, profile photo, and any details you add to your member profile</li>
                <li><strong>Contact form submissions</strong> — name, email, subject, and message when you use our contact form</li>
                <li><strong>Newsletter subscriptions</strong> — email address when you subscribe to our newsletter</li>
                <li><strong>Usage data</strong> — pages visited, browser type, and referring URLs collected via standard server logs</li>
            </ul>
        </div>

        <div class="doc-section">
            <h2>2. How We Use Your Information</h2>
            <p>We use the information we collect to:</p>
            <ul>
                <li>Operate and maintain the site and your account</li>
                <li>Send newsletters and editorial updates you have subscribed to</li>
                <li>Respond to your contact form enquiries</li>
                <li>Notify you about the status of your submitted articles</li>
                <li>Improve site performance and user experience</li>
            </ul>
            <p>We do not sell, rent, or share your personal data with third parties for marketing purposes.</p>
        </div>

        <div class="doc-section">
            <h2>3. Email Communications</h2>
            <p>By registering or subscribing, you may receive transactional emails (account verification, article status updates) and newsletter emails. You can unsubscribe from newsletters at any time by contacting us at <a href="mailto:support@thoughtsofnomads.com">support@thoughtsofnomads.com</a>.</p>
        </div>

        <div class="doc-section">
            <h2>4. Data Storage &amp; Security</h2>
            <p>Your data is stored on secured servers. We take reasonable technical and organisational measures to protect your information against unauthorised access, loss, or disclosure. Passwords are stored in hashed form and are never stored in plain text.</p>
        </div>

        <div class="doc-section">
            <h2>5. Cookies</h2>
            <p>We use session cookies to keep you logged in while you navigate the site. These cookies are strictly necessary for the site to function and are deleted when you close your browser or log out. We do not use tracking or advertising cookies.</p>
        </div>

        <div class="doc-section">
            <h2>6. Your Rights</h2>
            <p>You have the right to:</p>
            <ul>
                <li>Access the personal data we hold about you</li>
                <li>Request correction of inaccurate data</li>
                <li>Request deletion of your account and associated data</li>
                <li>Withdraw consent for email communications at any time</li>
            </ul>
            <p>To exercise any of these rights, please <a href="<%=request.getContextPath()%>/contact">contact us</a>.</p>
        </div>

        <div class="doc-section">
            <h2>7. Third-Party Services</h2>
            <p>We use Google Fonts and Material Icons served from Google's CDN to render the site's typography and icons. These requests are subject to <a href="https://policies.google.com/privacy" target="_blank" rel="noopener">Google's Privacy Policy</a>.</p>
        </div>

        <div class="doc-section">
            <h2>8. Changes to This Policy</h2>
            <p>We may update this Privacy Policy from time to time. We will notify registered users of significant changes by email. Continued use of the site after changes are posted means you accept the updated policy.</p>
        </div>

        <div class="doc-section">
            <h2>9. Contact</h2>
            <p>If you have any questions about this policy or your data, please <a href="<%=request.getContextPath()%>/contact">contact us</a> or email <a href="mailto:support@thoughtsofnomads.com">support@thoughtsofnomads.com</a>.</p>
        </div>
    </main>

    <jsp:include page="/WEB-INF/views/includes/footer.jsp" />
</body>
</html>
