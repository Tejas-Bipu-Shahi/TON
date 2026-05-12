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
        <form class="newsletter-form" id="newsletterForm">
            <input class="newsletter-input" id="newsletterEmail" placeholder="Your email address" required type="email" />
            <button class="newsletter-btn" id="newsletterBtn" type="submit">Subscribe</button>
        </form>
        <p id="newsletterMsg" style="display:none;margin-top:16px;font-size:14px;font-weight:600;"></p>
    </div>
</section>
<script>
(function() {
    var form  = document.getElementById('newsletterForm');
    var input = document.getElementById('newsletterEmail');
    var btn   = document.getElementById('newsletterBtn');
    var msg   = document.getElementById('newsletterMsg');
    var url   = '<%= request.getContextPath() %>/subscribe';

    form.addEventListener('submit', function(e) {
        e.preventDefault();
        var email = input.value.trim();
        if (!email) return;

        btn.disabled = true;
        btn.textContent = 'Subscribing...';

        fetch(url, {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: 'email=' + encodeURIComponent(email)
        })
        .then(function(r) { return r.json(); })
        .then(function(data) {
            if (data.success) {
                form.style.display = 'none';
                msg.style.color = '#2e7d32';
                msg.textContent = "You're subscribed! We'll send you the latest stories.";
                msg.style.display = 'block';
            } else {
                msg.style.color = data.error && data.error.indexOf('already') !== -1 ? '#e65100' : '#c62828';
                msg.textContent = data.error || 'Something went wrong. Please try again.';
                msg.style.display = 'block';
                btn.disabled = false;
                btn.textContent = 'Subscribe';
            }
        })
        .catch(function() {
            msg.style.color = '#c62828';
            msg.textContent = 'Connection error. Please try again.';
            msg.style.display = 'block';
            btn.disabled = false;
            btn.textContent = 'Subscribe';
        });
    });
})();
</script>

<!-- Footer Base HTML -->
<footer class="site-footer">
    <div class="footer-grid">
        <!-- Brand & Social -->
        <div class="footer-col">
            <span class="footer-brand">Thoughts of Nomads</span>
            <p class="footer-copyright">© 2026 Thoughts of Nomads. Editorial Excellence for the Modern Explorer.</p>
            <div class="social-links">
                <a aria-label="Instagram" class="social-icon" href="https://www.instagram.com/tejas.ez.afk/" target="_blank" rel="noopener">
                    <svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <rect x="2" y="2" width="20" height="20" rx="5" ry="5"/>
                        <circle cx="12" cy="12" r="4"/>
                        <circle cx="17.5" cy="6.5" r="1" fill="currentColor" stroke="none"/>
                    </svg>
                </a>
                <a aria-label="Facebook" class="social-icon" href="https://www.facebook.com/tejas.shahi.2025/" target="_blank" rel="noopener">
                    <svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M18 2h-3a5 5 0 0 0-5 5v3H7v4h3v8h4v-8h3l1-4h-4V7a1 1 0 0 1 1-1h3z"/>
                    </svg>
                </a>
                <a aria-label="LinkedIn" class="social-icon" href="https://www.linkedin.com/in/tejas-shahi" target="_blank" rel="noopener">
                    <svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M16 8a6 6 0 0 1 6 6v7h-4v-7a2 2 0 0 0-2-2 2 2 0 0 0-2 2v7h-4v-7a6 6 0 0 1 6-6z"/>
                        <rect x="2" y="9" width="4" height="12"/>
                        <circle cx="4" cy="4" r="2"/>
                    </svg>
                </a>
            </div>
        </div>
        
        <!-- Quick Links 1 -->
        <div class="footer-col">
            <nav class="footer-nav">
                <a class="footer-link" href="<%=request.getContextPath()%>/">Home</a>
                <a class="footer-link" href="<%=request.getContextPath()%>/latest">Categories</a>
                <a class="footer-link" href="<%=request.getContextPath()%>/latest">Latest</a>
            </nav>
        </div>
        
        <!-- Quick Links 2 -->
        <div class="footer-col">
            <nav class="footer-nav">
                <a class="footer-link" href="<%=request.getContextPath()%>/about">About Us</a>
                <a class="footer-link" href="<%=request.getContextPath()%>/contact">Contact Us</a>
                <a class="footer-link" href="<%=request.getContextPath()%>/privacy">Privacy Policy</a>
                <a class="footer-link" href="<%=request.getContextPath()%>/terms">Terms</a>
            </nav>
        </div>
    </div>
</footer>