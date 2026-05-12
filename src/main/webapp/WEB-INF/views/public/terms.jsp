<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <title>Terms of Service - Thoughts of Nomads</title>

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
            <h1 class="page-title">Terms of Service</h1>
            <p class="page-meta">Effective date: January 1, 2025 &nbsp;·&nbsp; Last updated: January 1, 2025</p>
        </header>

        <div class="doc-section">
            <p>Welcome to Thoughts of Nomads. By accessing or using our website at <strong>thoughtsofnomads.com</strong>, you agree to be bound by these Terms of Service. Please read them carefully before using the site.</p>
        </div>

        <div class="doc-section">
            <h2>1. Use of the Site</h2>
            <p>You may use this site for personal, non-commercial purposes only. You agree not to:</p>
            <ul>
                <li>Copy, reproduce, or redistribute our content without written permission</li>
                <li>Use the site for any unlawful purpose or in violation of any regulations</li>
                <li>Attempt to gain unauthorised access to any part of the site or its systems</li>
                <li>Post or transmit any content that is harmful, offensive, or misleading</li>
            </ul>
        </div>

        <div class="doc-section">
            <h2>2. User Accounts</h2>
            <p>To contribute articles or access member features, you must register for an account. You are responsible for maintaining the confidentiality of your login credentials and for all activity that occurs under your account.</p>
            <p>We reserve the right to suspend or terminate accounts that violate these terms or our community guidelines.</p>
        </div>

        <div class="doc-section">
            <h2>3. Content &amp; Intellectual Property</h2>
            <p>All editorial content, photography, and branding on this site is the property of Thoughts of Nomads or its respective contributors. No content may be reproduced without prior written consent.</p>
            <p>By submitting an article or any content to our platform, you grant Thoughts of Nomads a non-exclusive, royalty-free licence to publish, display, and distribute that content on the site.</p>
        </div>

        <div class="doc-section">
            <h2>4. Third-Party Links</h2>
            <p>Our site may contain links to third-party websites. These links are provided for convenience only. We have no control over those sites and accept no responsibility for their content or privacy practices.</p>
        </div>

        <div class="doc-section">
            <h2>5. Disclaimer of Warranties</h2>
            <p>The site and its content are provided "as is" without warranties of any kind, either express or implied. We do not guarantee that the site will be available at all times or that the content is error-free.</p>
        </div>

        <div class="doc-section">
            <h2>6. Limitation of Liability</h2>
            <p>To the fullest extent permitted by law, Thoughts of Nomads shall not be liable for any indirect, incidental, or consequential damages arising from your use of the site.</p>
        </div>

        <div class="doc-section">
            <h2>7. Changes to These Terms</h2>
            <p>We may update these Terms of Service from time to time. Continued use of the site after changes are posted constitutes your acceptance of the updated terms.</p>
        </div>

        <div class="doc-section">
            <h2>8. Contact</h2>
            <p>If you have questions about these terms, please <a href="<%=request.getContextPath()%>/contact">contact us</a> or email us at <a href="mailto:support@thoughtsofnomads.com">support@thoughtsofnomads.com</a>.</p>
        </div>
    </main>

    <jsp:include page="/WEB-INF/views/includes/footer.jsp" />
</body>
</html>
