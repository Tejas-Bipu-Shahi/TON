<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.thoughtsofnomads.model.User" %>
<%
    User user = (User) session.getAttribute("user");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Thoughts of Nomads</title>
    <link href="https://fonts.googleapis.com/css2?family=Epilogue:wght@400;600;700&family=Work+Sans:wght@400;600&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet" />
    <style>
.auth-layout {
    height: 100vh;
    overflow: hidden;
    display: flex;
    flex-direction: column;
}

.auth-main {
    flex-grow: 1;
    display: flex;
    flex-direction: column;
    position: relative;
    height: 100%;
}

.auth-back-btn {
    position: absolute;
    top: 16px;
    left: 16px;
    z-index: 50;
    display: flex;
    align-items: center;
    gap: 8px;
    padding: 8px 16px;
    background-color: var(--surface);
    color: var(--on-surface);
    border: 1px solid var(--outline-variant);
    border-radius: 999px; /* Pill shape */
    font-family: 'Work Sans', sans-serif;
    font-size: 12px;
    font-weight: 600;
    letter-spacing: 0.1em;
    text-transform: uppercase;
    text-decoration: none;
    box-shadow: 0 1px 4px rgba(0,0,0,0.07);
    transition: background-color 0.2s ease;
}

.auth-back-btn:hover {
    background-color: var(--surface-variant);
}

.auth-image-panel {
    display: none; /* Hidden on mobile */
    position: relative;
    overflow: hidden;
    background-color: var(--surface-container);
}

.auth-image {
    position: absolute;
    inset: 0;
    width: 100%;
    height: 100%;
    object-fit: cover;
    object-position: center;
    filter: grayscale(15%) contrast(1.1);
}

.auth-image-overlay {
    position: absolute;
    inset: 0;
    background-image: linear-gradient(to right, rgba(14,25,62,0.2), transparent);
}

.auth-form-panel {
    width: 100%;
    height: 100%;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: var(--margin-mobile);
    background-color: var(--surface-container-lowest);
    overflow-y: auto;
}

.auth-form-wrapper {
    width: 100%;
    max-width: 384px;
    margin-top: auto;
    margin-bottom: auto;
}

/* Authentication Typography & Feedback */
.auth-header {
    margin-bottom: 40px;
}

.auth-title {
    font-family: 'Epilogue', sans-serif;
    font-size: 32px;
    line-height: 1.2;
    font-weight: 600;
    color: var(--primary-container);
    margin-bottom: 12px;
}

.auth-subtitle {
    font-family: 'Work Sans', sans-serif;
    font-size: 18px;
    color: var(--on-surface-variant);
}

.auth-error-box {
    margin-bottom: 32px;
    padding: 16px;
    background-color: var(--error-container);
    border: 1px solid rgba(186, 26, 26, 0.2);
    border-radius: var(--radius);
    display: flex;
    align-items: flex-start;
    gap: 12px;
}

.auth-error-icon {
    color: var(--error);
}

.auth-error-title {
    font-family: 'Work Sans', sans-serif;
    font-size: 12px;
    font-weight: 600;
    letter-spacing: 0.1em;
    color: var(--error);
    text-transform: uppercase;
    margin-bottom: 4px;
}

.auth-error-msg {
    font-family: 'Work Sans', sans-serif;
    font-size: 14px;
    color: var(--on-surface-variant);
    line-height: 1.25;
}

/* Forms */
.auth-form {
    display: flex;
    flex-direction: column;
    gap: 24px;
}

.form-group {
    display: flex;
    flex-direction: column;
    gap: 8px;
}

.form-label {
    display: block;
    font-family: 'Work Sans', sans-serif;
    font-size: 12px;
    font-weight: 600;
    letter-spacing: 0.1em;
    color: var(--on-surface);
    text-transform: uppercase;
}

.form-label-row {
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.form-input {
    width: 100%;
    padding: 12px 16px;
    background-color: var(--surface);
    border: 1px solid var(--outline-variant);
    border-radius: var(--radius);
    font-family: 'Work Sans', sans-serif;
    font-size: 16px;
    color: var(--on-surface);
    outline: none;
    transition: border-color 0.2s ease, box-shadow 0.2s ease;
}

.form-input:focus {
    border-color: var(--primary-container);
    box-shadow: 0 0 0 1px var(--primary-container);
}

.form-input-wrapper {
    position: relative;
}

.form-input-wrapper .form-input {
    padding-right: 48px; /* Space for the eye icon */
}

.password-toggle-btn {
    position: absolute;
    right: 16px;
    top: 50%;
    transform: translateY(-50%);
    background: none;
    border: none;
    color: var(--outline);
    display: flex;
    align-items: center;
}

.password-toggle-btn:hover {
    color: var(--on-surface);
}

.auth-submit-btn {
    width: 100%;
    margin-top: 32px;
    background-color: var(--primary-container);
    color: #ffffff;
    padding: 16px 24px;
    border-radius: var(--radius);
    border: none;
    font-family: 'Work Sans', sans-serif;
    font-size: 12px;
    font-weight: 600;
    letter-spacing: 0.1em;
    text-transform: uppercase;
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 8px;
    transition: background-color 0.2s ease, box-shadow 0.2s ease;
}

.auth-submit-btn:hover {
    background-color: var(--primary);
    box-shadow: 0 4px 20px rgba(36, 46, 84, 0.15);
}

.auth-footer {
    margin-top: 40px;
    padding-top: 32px;
    border-top: 1px solid rgba(198, 197, 207, 0.3);
    text-align: center;
}

.auth-footer-text {
    font-family: 'Work Sans', sans-serif;
    font-size: 16px;
    color: var(--on-surface-variant);
}

.auth-link {
    color: var(--primary-container);
    font-weight: 600;
    text-decoration: none;
    margin-left: 4px;
    text-underline-offset: 4px;
    transition: text-decoration 0.2s ease;
}

.auth-link:hover {
    text-decoration: underline;
}

.auth-forgot-link {
    color: var(--primary-container);
    font-family: 'Work Sans', sans-serif;
    font-size: 12px;
    font-weight: 600;
    letter-spacing: 0.1em;
    text-transform: uppercase;
    text-decoration: none;
    text-underline-offset: 4px;
    transition: text-decoration 0.2s ease;
}

.auth-forgot-link:hover {
    text-decoration: underline;
}

/* Responsive Split Screen */
@media (min-width: 768px) {
    .auth-main {
        flex-direction: row;
    }
    
    .auth-back-btn {
        top: 32px;
        left: 32px;
    }
    
    .auth-image-panel {
        display: block;
        width: 45%;
    }
    
    .auth-form-panel {
        width: 55%;
        padding: var(--gutter);
    }
}

@media (min-width: 1024px) {
    .auth-image-panel {
        width: 55%;
    }
    
    .auth-form-panel {
        width: 45%;
        padding: var(--margin-desktop);
    }
}

.site-header {
    background-color: var(--surface-container-lowest);
    position: sticky;
    top: 0;
    width: 100%;
    z-index: 50;
    border-bottom: 1px solid var(--surface-variant);
    font-family: 'Work Sans', sans-serif;
}

.header-container {
    display: flex;
    justify-content: space-between;
    align-items: center;
    max-width: var(--container-max);
    margin: 0 auto;
    padding-left: var(--margin-mobile);
    padding-right: var(--margin-mobile);
    height: 80px;
}

.header-brand {
    font-family: 'Epilogue', sans-serif;
    font-size: 20px;
    font-weight: 700;
    color: var(--primary);
    text-transform: uppercase;
    letter-spacing: 0.1em;
}

/* Hide menus on mobile by default */
.header-menu,
.header-auth {
    display: none; 
}

/* Base button styles used in header and throughout the site */
.btn {
    font-family: 'Work Sans', sans-serif;
    font-size: 12px;
    font-weight: 600;
    letter-spacing: 0.1em;
    text-transform: uppercase;
    padding: 8px 16px;
    border-radius: var(--radius);
    text-decoration: none;
    transition: background-color 0.2s ease, opacity 0.2s ease;
    display: inline-flex;
    align-items: center;
    justify-content: center;
}

.btn-outline {
    color: var(--primary);
    border: 1px solid var(--primary);
    background-color: transparent;
}

.btn-outline:hover {
    background-color: var(--surface-container-low);
}

.btn-solid {
    background-color: var(--primary);
    color: var(--on-primary);
    border: 1px solid var(--primary);
}

.btn-solid:hover {
    opacity: 0.9;
}

/* Desktop layout rules */
@media (min-width: 768px) {
    .header-container {
        padding-left: var(--margin-desktop);
        padding-right: var(--margin-desktop);
    }
    
    .header-menu {
        display: flex;
        gap: 32px;
    }
    
    .header-auth {
        display: flex;
        gap: 16px;
        align-items: center;
    }
}

.nav-link {
    color: var(--on-surface-variant);
    font-weight: 500;
    text-transform: uppercase;
    letter-spacing: 0.1em;
    font-size: 12px;
    transition: color 0.2s ease, transform 0.2s ease;
    text-decoration: none;
}

.nav-link:hover {
    color: var(--primary);
    transform: scale(0.95);
}

.nav-link:active {
    transform: scale(0.90);
}

.nav-link.active {
    color: var(--primary);
    border-bottom: 2px solid var(--primary);
    padding-bottom: 4px;
    font-weight: 600;
}

/* Newsletter Section */
.newsletter-section {
    width: 100%;
    background-color: var(--surface-container-low);
    padding-top: var(--section-gap);
    padding-bottom: var(--section-gap);
}

.newsletter-container {
    max-width: var(--container-max);
    margin: 0 auto;
    padding-left: var(--margin-mobile);
    padding-right: var(--margin-mobile);
    text-align: center;
}

.newsletter-title {
    font-family: 'Epilogue', sans-serif;
    font-size: 32px;
    line-height: 1.2;
    font-weight: 600;
    color: var(--on-surface);
    margin-bottom: 16px;
}

.newsletter-desc {
    font-family: 'Work Sans', sans-serif;
    font-size: 18px;
    line-height: 1.6;
    color: var(--on-surface-variant);
    margin-bottom: 32px;
    max-width: 576px;
    margin-left: auto;
    margin-right: auto;
}

.newsletter-form {
    display: flex;
    flex-direction: column;
    gap: 16px;
    justify-content: center;
    max-width: 512px;
    margin: 0 auto;
}

.newsletter-input {
    flex-grow: 1;
    padding: 12px 16px;
    border-radius: var(--radius);
    border: 1px solid var(--outline-variant);
    background-color: var(--surface);
    color: var(--on-surface);
    outline: none;
    transition: all 0.2s ease;
}

.newsletter-input:focus {
    border-color: transparent;
    box-shadow: 0 0 0 2px var(--primary);
}

.newsletter-btn {
    background-color: var(--primary);
    color: var(--on-primary);
    font-family: 'Work Sans', sans-serif;
    font-size: 12px;
    line-height: 1.0;
    font-weight: 600;
    letter-spacing: 0.1em;
    text-transform: uppercase;
    padding: 12px 32px;
    border: none;
    border-radius: var(--radius);
    white-space: nowrap;
    transition: opacity 0.2s ease;
}

.newsletter-btn:hover {
    opacity: 0.9;
}

/* Footer Base */
.site-footer {
    width: 100%;
    background-color: var(--surface);
    color: var(--primary);
    font-family: 'Work Sans', sans-serif;
    font-size: 16px;
    line-height: 1.625;
    padding-top: 64px;
    padding-bottom: 64px;
    border-top: 1px solid var(--surface-variant);
}

.footer-grid {
    display: grid;
    grid-template-columns: 1fr;
    gap: 32px;
    max-width: var(--container-max);
    margin: 0 auto;
    padding-left: var(--margin-mobile);
    padding-right: var(--margin-mobile);
}

.footer-brand {
    display: block;
    font-family: 'Epilogue', sans-serif;
    font-size: 18px;
    font-weight: 700;
    color: var(--primary);
    margin-bottom: 16px;
}

.footer-copyright {
    color: var(--on-surface-variant);
    margin-bottom: 24px;
}

.social-links {
    display: flex;
    gap: 16px;
}

.social-icon {
    color: var(--on-surface-variant);
    transition: color 0.2s ease;
}

.social-icon:hover {
    color: var(--primary);
}

.footer-nav {
    display: flex;
    flex-direction: column;
    gap: 12px;
}

.footer-link {
    color: var(--on-surface-variant);
    text-decoration: underline;
    text-underline-offset: 4px;
    transition: color 0.2s ease;
}

.footer-link:hover {
    color: var(--primary);
}

/* Responsive Grid and Flexbox for Tablet/Desktop */
@media (min-width: 640px) {
    .newsletter-form {
        flex-direction: row;
    }
}

@media (min-width: 768px) {
    .newsletter-container,
    .footer-grid {
        padding-left: var(--margin-desktop);
        padding-right: var(--margin-desktop);
    }

    .footer-grid {
        grid-template-columns: repeat(12, 1fr);
    }

    .footer-col {
        grid-column: span 4;
    }
}

.dashboard-layout {
    background-color: var(--surface);
    color: var(--on-surface);
    font-family: 'Work Sans', sans-serif;
    min-height: 100vh;
    display: flex;
    flex-direction: column;
}

.dashboard-main {
    flex-grow: 1;
    max-width: 1024px;
    margin: 3rem auto 0; /* mt-12 */
    width: 100%;
    padding: 0 var(--margin-desktop);
    padding-bottom: 4rem;
}

@media (max-width: 767px) {
    .dashboard-main {
        padding: 0 var(--margin-mobile);
        padding-bottom: 4rem;
    }
}

.dashboard-header {
    margin-bottom: 2.5rem; /* mb-10 */
}

.dashboard-title {
    font-family: 'Epilogue', sans-serif;
    font-size: 36px;
    font-weight: 700;
    color: var(--primary-container);
    margin-bottom: 0.5rem; /* mb-2 */
}

.dashboard-subtitle {
    font-family: 'Work Sans', sans-serif;
    font-size: var(--body-md);
    color: var(--on-surface-variant);
}

.dashboard-grid {
    display: grid;
    grid-template-columns: 1fr;
    gap: 2rem; /* gap-8 */
}

@media (min-width: 768px) {
    .dashboard-grid {
        grid-template-columns: repeat(2, 1fr);
    }
}

.dashboard-card {
    background-color: var(--surface-container-lowest);
    padding: 2rem; /* p-8 */
    border-radius: 0.75rem; /* rounded-xl */
    box-shadow: 0 1px 2px rgba(0,0,0,0.05); /* shadow-sm */
    border: 1px solid var(--surface-variant);
    transition: box-shadow 0.2s ease;
    display: flex;
    flex-direction: column;
    align-items: flex-start;
}

.dashboard-card:hover {
    box-shadow: 0 4px 6px -1px rgba(0,0,0,0.1), 0 2px 4px -1px rgba(0,0,0,0.06); /* shadow-md */
}

.dashboard-card-icon {
    font-size: 40px; /* text-[40px] */
    color: var(--primary-container);
    margin-bottom: 1rem; /* mb-4 */
}

.dashboard-card-title {
    font-family: 'Epilogue', sans-serif;
    font-size: 24px;
    font-weight: 600;
    color: var(--on-surface);
    margin-bottom: 0.5rem; /* mb-2 */
}

.dashboard-card-desc {
    font-family: 'Work Sans', sans-serif;
    font-size: var(--body-md);
    color: var(--on-surface-variant);
    margin-bottom: 1.5rem; /* mb-6 */
    flex-grow: 1;
}

.dashboard-btn-primary {
    background-color: var(--primary-container);
    color: white;
    padding: 0.5rem 1.5rem; /* py-2 px-6 */
    border-radius: var(--radius);
    font-family: 'Work Sans', sans-serif;
    font-size: var(--label-caps);
    text-transform: uppercase;
    letter-spacing: 0.05em;
    border: none;
    cursor: pointer;
    transition: background-color 0.2s ease;
    font-weight: 600;
}

.dashboard-btn-primary:hover {
    background-color: var(--primary);
}

.dashboard-btn-secondary {
    background-color: transparent;
    color: var(--on-surface);
    padding: 0.5rem 1.5rem; /* py-2 px-6 */
    border-radius: var(--radius);
    font-family: 'Work Sans', sans-serif;
    font-size: var(--label-caps);
    text-transform: uppercase;
    letter-spacing: 0.05em;
    border: 1px solid var(--outline-variant);
    cursor: pointer;
    transition: background-color 0.2s ease;
    font-weight: 600;
}

.dashboard-btn-secondary:hover {
    background-color: var(--surface-container);
}
</style>
</head>
<body class="dashboard-layout">
    <!-- Navbar -->
    <jsp:include page="/WEB-INF/views/includes/header.jsp" />

    <!-- Main Content -->
    <main class="dashboard-main">
        <header class="dashboard-header">
            <h1 class="dashboard-title">Welcome back, <%= user.getRole().name() %>!</h1>
            <p class="dashboard-subtitle">This is your personal dashboard. From here, you can manage your contributions and profile.</p>
        </header>

        <div class="dashboard-grid">
            <!-- Card 1 -->
            <div class="dashboard-card">
                <span class="material-symbols-outlined dashboard-card-icon">edit_document</span>
                <h2 class="dashboard-card-title">Draft a Story</h2>
                <p class="dashboard-card-desc">Start writing your next adventure. Share your journey with the world.</p>
                <button class="dashboard-btn-primary">Create Post</button>
            </div>

            <!-- Card 2 -->
            <div class="dashboard-card">
                <span class="material-symbols-outlined dashboard-card-icon">manage_accounts</span>
                <h2 class="dashboard-card-title">Profile Settings</h2>
                <p class="dashboard-card-desc">Update your bio, profile picture, and contact information.</p>
                <button class="dashboard-btn-secondary">Edit Profile</button>
            </div>
        </div>
    </main>
    
    <jsp:include page="/WEB-INF/views/includes/footer.jsp" />
</body>
</html>
