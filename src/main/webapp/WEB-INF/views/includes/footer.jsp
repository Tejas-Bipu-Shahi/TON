<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<style>
    /* ============================================================
       FOOTER & NEWSLETTER SPECIFIC CSS
       ============================================================ */
    .newsletter-section {
        background-color: #f3f4f5; /* Light gray surface */
        padding: 64px 0;
    }
    .newsletter-container {
        max-width: 1280px; 
        margin: 0 auto; 
        text-align: center;
        padding: 0 16px;
    }
    .newsletter-title {
        font-family: 'Epilogue', sans-serif; 
        font-size: 32px; 
        font-weight: 600; 
        margin-bottom: 16px;
        color: #191c1d;
    }
    .newsletter-desc {
        font-family: 'Work Sans', sans-serif;
        font-size: 18px; 
        color: #45464e; 
        margin-bottom: 32px; 
        max-width: 576px;
        margin-left: auto;
        margin-right: auto;
    }
    .newsletter-form {
        display: flex; 
        flex-direction: column; 
        gap: 16px; 
        max-width: 512px; 
        margin: 0 auto;
    }
    @media (min-width: 640px) { 
        .newsletter-form { flex-direction: row; } 
    }
    
    .newsletter-input {
        flex-grow: 1; 
        padding: 12px 16px; 
        border-radius: 4px;
        border: 1px solid #c6c5cf; 
        outline: none; 
        background-color: #ffffff;
        font-family: 'Work Sans', sans-serif;
        font-size: 16px;
        color: #191c1d;
        transition: border-color 0.2s ease, box-shadow 0.2s ease;
    }
    .newsletter-input:focus { 
        border-color: #0e193e; 
        box-shadow: 0 0 0 1px #0e193e; 
    }
    
    .newsletter-btn {
        background-color: #0e193e; 
        color: #ffffff; 
        font-family: 'Work Sans', sans-serif;
        font-weight: 600;
        text-transform: uppercase; 
        letter-spacing: 0.1em; 
        font-size: 12px;
        padding: 12px 32px; 
        border: none; 
        border-radius: 4px;
        transition: opacity 0.2s ease;
        cursor: pointer;
    }
    .newsletter-btn:hover { 
        opacity: 0.9; 
    }

    /* Footer Base */
    .site-footer {
        background-color: #ffffff; 
        padding: 64px 0;
        border-top: 1px solid #e1e3e4;
        font-family: 'Work Sans', sans-serif;
    }
    .footer-grid {
        display: grid; 
        grid-template-columns: 1fr; 
        gap: 32px;
        max-width: 1280px; 
        margin: 0 auto; 
        padding: 0 16px;
    }
    @media (min-width: 768px) {
        .footer-grid { 
            grid-template-columns: repeat(12, 1fr); 
            padding: 0 48px; 
        }
        .footer-col { grid-column: span 4; }
    }
    .footer-brand {
        display: block; 
        font-family: 'Epilogue', sans-serif; 
        font-size: 18px; 
        font-weight: 700;
        color: #0e193e; 
        margin-bottom: 16px;
    }
    .footer-copyright { 
        color: #45464e; 
        margin-bottom: 24px; 
        font-size: 14px; 
    }
    
    .social-links { display: flex; gap: 16px; }
    .social-icon { 
        color: #45464e; 
        transition: color 0.2s ease; 
        text-decoration: none;
    }
    .social-icon:hover { color: #0e193e; }
    
    .footer-nav { display: flex; flex-direction: column; gap: 12px; }
    .footer-link { 
        color: #45464e; 
        text-decoration: underline; 
        text-underline-offset: 4px; 
        font-size: 14px;
        transition: color 0.2s ease;
    }
    .footer-link:hover { color: #0e193e; }
</style>

<!-- Newsletter Section HTML -->
<section class="newsletter-section">
    <div class="newsletter-container">
        <h2 class="newsletter-title">Join the Nomad Community</h2>
        <p class="newsletter-desc">Subscribe to our newsletter for the latest stories and travel insights.</p>
        <form class="newsletter-form" onsubmit="return false;">
            <input class="newsletter-input" placeholder="Your email address" required type="email" />
            <button class="newsletter-btn" type="submit">Subscribe</button>
        </form>
    </div>
</section>

<!-- Footer Base HTML -->
<footer class="site-footer">
    <div class="footer-grid">
        <!-- Brand & Social -->
        <div class="footer-col">
            <span class="footer-brand">Thoughts of Nomads</span>
            <p class="footer-copyright">© 2026 Thoughts of Nomads. Editorial Excellence for the Modern Explorer.</p>
            <div class="social-links">
                <a aria-label="Instagram" class="social-icon" href="#">
                    <span class="material-symbols-outlined">photo_camera</span>
                </a>
                <a aria-label="Twitter" class="social-icon" href="#">
                    <span class="material-symbols-outlined">share</span>
                </a>
                <a aria-label="Facebook" class="social-icon" href="#">
                    <span class="material-symbols-outlined">public</span>
                </a>
            </div>
        </div>
        
        <!-- Quick Links 1 -->
        <div class="footer-col">
            <nav class="footer-nav">
                <a class="footer-link" href="<%=request.getContextPath()%>/">Home</a>
                <a class="footer-link" href="<%=request.getContextPath()%>/category">Categories</a>
                <a class="footer-link" href="<%=request.getContextPath()%>/latest">Latest</a>
            </nav>
        </div>
        
        <!-- Quick Links 2 -->
        <div class="footer-col">
            <nav class="footer-nav">
                <a class="footer-link" href="<%=request.getContextPath()%>/about">About Us</a>
                <a class="footer-link" href="<%=request.getContextPath()%>/contact">Contact Us</a>
                <a class="footer-link" href="#">Privacy Policy</a>
                <a class="footer-link" href="#">Terms</a>
            </nav>
        </div>
    </div>
</footer>