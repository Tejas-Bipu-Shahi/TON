<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="utf-8" />
        <meta content="width=device-width, initial-scale=1.0" name="viewport" />
        <title>Contact Us - Thoughts of Nomads</title>

        <!-- Google Fonts & Material Icons -->
        <link
            href="https://fonts.googleapis.com/css2?family=Epilogue:wght@400;600;700&family=Work+Sans:wght@400;500;600&display=swap"
            rel="stylesheet" />
        <link
            href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap"
            rel="stylesheet" />

        <style>
            /* ============================================================
           DESIGN TOKENS & RESETS
           ============================================================ */
            :root {
                --primary: #0e193e;
                --primary-container: #242e54;
                --on-primary: #ffffff;
                --surface: #ffffff;
                --surface-container-low: #f3f4f5;
                --surface-container-lowest: #ffffff;
                --surface-variant: #e1e3e4;
                --on-surface: #191c1d;
                --on-surface-variant: #45464e;
                --background: #f8f9fa;
                --outline-variant: #c6c5cf;

                --container-max: 1280px;
                --margin-desktop: 48px;
                --margin-mobile: 16px;
                --radius: 4px;
            }

            *,
            *::before,
            *::after {
                box-sizing: border-box;
                margin: 0;
                padding: 0;
            }

            body {
                font-family: 'Work Sans', sans-serif;
                background-color: var(--background);
                color: var(--on-surface);
                line-height: 1.5;
                -webkit-font-smoothing: antialiased;
            }

            .material-symbols-outlined {
                font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
                vertical-align: middle;
            }

            /* ============================================================
           CONTACT PAGE LAYOUT
           ============================================================ */
            .contact-layout {
                display: flex;
                flex-direction: column;
                min-height: 100vh;
            }

            .contact-main {
                flex-grow: 1;
                max-width: var(--container-max);
                margin: 0 auto;
                padding: 80px var(--margin-mobile);
                width: 100%;
            }

            @media (min-width: 768px) {
                .contact-main {
                    padding: 80px var(--margin-desktop);
                }
            }

            /* Page Header */
            .contact-header {
                margin-bottom: 64px;
                max-width: 800px;
            }

            .contact-title {
                font-family: 'Epilogue', sans-serif;
                font-size: 48px;
                font-weight: 700;
                color: var(--primary);
                margin-bottom: 16px;
            }

            .contact-subtitle {
                font-size: 18px;
                color: var(--on-surface-variant);
                line-height: 1.6;
            }

            /* Main Grid */
            .contact-grid {
                display: grid;
                grid-template-columns: 1fr;
                gap: 64px;
                align-items: start;
            }

            @media (min-width: 1024px) {
                .contact-grid {
                    grid-template-columns: 1fr 1.5fr;
                }
            }

            /* ============================================================
           LEFT COLUMN: INFO & MAP
           ============================================================ */
            .contact-info {
                display: flex;
                flex-direction: column;
                gap: 48px;
            }

            .contact-info-title {
                font-family: 'Epilogue', sans-serif;
                font-size: 24px;
                font-weight: 600;
                color: var(--primary);
                margin-bottom: 32px;
            }

            .contact-info-list {
                display: flex;
                flex-direction: column;
                gap: 32px;
            }

            .contact-info-item {
                display: flex;
                align-items: flex-start;
                gap: 16px;
            }

            .contact-info-icon {
                color: var(--primary);
                font-size: 24px;
                margin-top: 4px;
            }

            .contact-info-label {
                font-size: 10px;
                font-weight: 700;
                text-transform: uppercase;
                letter-spacing: 0.1em;
                color: var(--on-surface-variant);
                margin-bottom: 4px;
            }

            .contact-info-text {
                font-size: 15px;
                color: var(--on-surface);
            }

            .contact-info-link {
                color: var(--on-surface);
                text-decoration: none;
                transition: color 0.2s;
            }

            .contact-info-link:hover {
                color: var(--primary);
                text-decoration: underline;
            }

            .contact-map-wrapper {
                width: 100%;
                aspect-ratio: 1/1;
                border-radius: var(--radius);
                overflow: hidden;
                border: 1px solid var(--outline-variant);
                background-color: #e5e7eb;
            }

            .contact-map-image {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }

            /* ============================================================
           RIGHT COLUMN: FORM CARD
           ============================================================ */
            .contact-form-wrapper {
                background-color: var(--surface-container-lowest);
                padding: 48px;
                border-radius: var(--radius);
                border: 1px solid var(--outline-variant);
            }

            @media (max-width: 767px) {
                .contact-form-wrapper {
                    padding: 24px;
                }
            }

            .contact-form {
                display: flex;
                flex-direction: column;
                gap: 24px;
            }

            .contact-form-row {
                display: grid;
                grid-template-columns: 1fr;
                gap: 24px;
            }

            @media (min-width: 640px) {
                .contact-form-row {
                    grid-template-columns: 1fr 1fr;
                }
            }

            .form-group {
                display: flex;
                flex-direction: column;
                gap: 8px;
            }

            .form-label {
                font-size: 12px;
                font-weight: 700;
                color: var(--on-surface);
            }

            .form-input {
                width: 100%;
                padding: 14px 16px;
                border: 1px solid var(--outline-variant);
                border-radius: var(--radius);
                background-color: var(--background);
                font-family: 'Work Sans', sans-serif;
                font-size: 15px;
                outline: none;
                transition: border-color 0.2s;
            }

            .form-input:focus {
                border-color: var(--primary);
            }

            .form-textarea {
                resize: none;
                min-height: 150px;
            }

            .form-hint {
                font-size: 12px;
                color: var(--on-surface-variant);
                opacity: 0.7;
            }

            .contact-submit-area {
                display: flex;
                flex-direction: column;
                gap: 24px;
                margin-top: 16px;
            }

            @media (min-width: 640px) {
                .contact-submit-area {
                    flex-direction: row;
                    justify-content: space-between;
                    align-items: center;
                }
            }

            .btn-submit {
                background-color: var(--primary-container);
                color: #ffffff;
                padding: 16px 32px;
                border-radius: var(--radius);
                font-size: 12px;
                font-weight: 700;
                text-transform: uppercase;
                letter-spacing: 0.1em;
                display: inline-flex;
                align-items: center;
                gap: 12px;
                transition: background-color 0.2s;
            }

            .btn-submit:hover {
                background-color: var(--primary);
            }

            .contact-success {
                padding: 16px;
                background-color: #e6fffa;
                border: 1px solid #b2f5ea;
                color: #234e52;
                border-radius: var(--radius);
                margin-bottom: 24px;
                font-size: 14px;
            }

            .contact-error {
                padding: 16px;
                background-color: #fff5f5;
                border: 1px solid #fed7d7;
                color: #742a2a;
                border-radius: var(--radius);
                margin-bottom: 24px;
                font-size: 14px;
            }
        </style>
        <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css" />
    </head>

    <body class="contact-layout">
        <!-- Header Include -->
        <jsp:include page="/WEB-INF/views/includes/header.jsp" />

        <main class="contact-main">
            <header class="contact-header">
                <h1 class="contact-title">Contact Us</h1>
                <p class="contact-subtitle">We're always eager to connect with fellow travelers, potential partners, and
                    readers. Reach out and let's start a conversation.</p>
            </header>

            <div class="contact-grid">
                <!-- Left Column -->
                <div class="contact-info">
                    <section>
                        <h2 class="contact-info-title">Get in Touch</h2>
                        <div class="contact-info-list">
                            <div class="contact-info-item">
                                <span class="material-symbols-outlined contact-info-icon">location_on</span>
                                <div>
                                    <h3 class="contact-info-label">HQ ADDRESS</h3>
                                    <p class="contact-info-text">Baneshwor, Kathmandu<br />Bagmati Province,
                                        Nepal<br />44600</p>
                                </div>
                            </div>
                            <div class="contact-info-item">
                                <span class="material-symbols-outlined contact-info-icon">mail</span>
                                <div>
                                    <h3 class="contact-info-label">EDITORIAL & SUPPORT</h3>
                                    <a class="contact-info-link"
                                        href="mailto:shahitejas899@gmail.com">shahitejas899@gmail.com</a>
                                </div>
                            </div>
                            <div class="contact-info-item">
                                <span class="material-symbols-outlined contact-info-icon">phone_enabled</span>
                                <div>
                                    <h3 class="contact-info-label">GENERAL INQUIRIES</h3>
                                    <a class="contact-info-link" href="tel:+9779744643344">+977 9744643344</a>
                                </div>
                            </div>
                        </div>
                    </section>

                    <div class="contact-map-wrapper">
                        <img alt="Map of Kathmandu" class="contact-map-image"
                            src="https://lh3.googleusercontent.com/aida-public/AB6AXuBBxCTBI6Vl96SCYskCk2zmI07NmfVpsfKJw-vPjCK3cNJ6Ve6CLxsFeoXaCTGnApNTfjg7omrgoxm0mgETW_lSvbbZwi0yWIA3nKtkRjoUJ3WxFpJtE55yaWm_tZ2tMhlf3b4DM0el2vhtwm7-aanQl4VaRzfqK-0kWZv6OCRRzuj0Cz_lTebqD2advS6nAfemUIcQAWPHPoX-RpuVce5Dpy1aObtnSd_wVN54G3ic0zbM51bfD2q3hE1hqqllkgl99J5wS9OJyJM" />
                    </div>
                </div>

                <!-- Right Column -->
                <div class="contact-form-wrapper">
                    <% if (request.getAttribute("success") !=null) { %>
                        <div class="contact-success">
                            <%= request.getAttribute("success") %>
                        </div>
                        <% } %>
                            <% if (request.getAttribute("error") !=null) { %>
                                <div class="contact-error">
                                    <%= request.getAttribute("error") %>
                                </div>
                                <% } %>

                                    <form action="<%=request.getContextPath()%>/contact" method="POST"
                                        class="contact-form">
                                        <div class="contact-form-row">
                                            <div class="form-group">
                                                <label class="form-label" for="fullName">Full Name *</label>
                                                <input class="form-input" id="fullName" name="fullName"
                                                    placeholder="Jane Doe" required type="text" />
                                            </div>
                                            <div class="form-group">
                                                <label class="form-label" for="emailAddress">Email Address *</label>
                                                <input class="form-input" id="emailAddress" name="emailAddress"
                                                    placeholder="jane@example.com" required type="email" />
                                                <span class="form-hint">We'll never share your email.</span>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label class="form-label" for="subject">Subject</label>
                                            <input class="form-input" id="subject" name="subject"
                                                placeholder="Partnership Inquiry" type="text" />
                                        </div>

                                        <div class="form-group">
                                            <label class="form-label" for="message">Message *</label>
                                            <textarea class="form-input form-textarea" id="message" name="message"
                                                placeholder="How can we help you on your journey?" required></textarea>
                                        </div>

                                        <div class="contact-submit-area">
                                            <span class="form-hint">* Indicates required field</span>
                                            <button class="btn-submit" type="submit">
                                                Send Message
                                                <span class="material-symbols-outlined"
                                                    style="font-size: 18px;">send</span>
                                            </button>
                                        </div>
                                    </form>
                </div>
            </div>
        </main>

        <!-- Footer Include -->
        <jsp:include page="/WEB-INF/views/includes/footer.jsp" />
    </body>

    </html>