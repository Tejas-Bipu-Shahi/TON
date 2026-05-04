<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <title>The Silence of the Himalayas: A Guide to the Annapurna Sanctuary - Thoughts of Nomads</title>
    
    <!-- Google Fonts & Material Icons -->
    <link href="https://fonts.googleapis.com/css2?family=Epilogue:wght@400;600;700&family=Work+Sans:wght@400;600&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet" />
    
    <style>
        /* ============================================================
           CSS VARIABLES (Design Tokens) & RESETS
           ============================================================ */
        :root {
            --primary: #0e193e;
            --primary-container: #242e54;
            --on-primary: #ffffff;
            --surface: #ffffff;
            --surface-container-lowest: #ffffff;
            --surface-container: #f8f9fa;
            --surface-variant: #e1e3e4;
            --on-surface: #191c1d;
            --on-surface-variant: #45464e;
            --background: #f8f9fa;
            --outline: #76767f;
            --outline-variant: #c6c5cf;
            --accent-orange: #a26b1c;
            
            --container-max: 1280px;
            --margin-desktop: 48px;
            --margin-mobile: 16px;
            --radius: 4px;
        }

        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        body {
            font-family: 'Work Sans', sans-serif;
            background-color: var(--background);
            color: var(--on-surface);
            line-height: 1.5;
            -webkit-font-smoothing: antialiased;
        }
        a { text-decoration: none; color: inherit; }
        img { max-width: 100%; display: block; }
        button { cursor: pointer; font-family: inherit; background: none; border: none; }

        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
            vertical-align: middle;
        }

        /* Reading Progress Bar (Optional JS hook) */
        .reading-progress-bar {
            position: fixed; top: 0; left: 0; height: 4px;
            background-color: #d18900; width: 30%; z-index: 100;
        }

        /* ============================================================
           ARTICLE PAGE LAYOUT
           ============================================================ */
        .article-layout { display: flex; flex-direction: column; min-height: 100vh; }
        .article-main {
            flex-grow: 1; max-width: var(--container-max); margin: 0 auto;
            width: 100%; padding: 48px var(--margin-mobile);
        }
        @media (min-width: 768px) {
            .article-main { padding: 48px var(--margin-desktop); }
        }

        .article-grid { display: grid; grid-template-columns: 1fr; gap: 48px; }
        @media (min-width: 1024px) {
            .article-grid { grid-template-columns: 2fr 1fr; }
        }

        /* ============================================================
           ARTICLE BODY (Left Column)
           ============================================================ */
        .article-body { display: flex; flex-direction: column; width: 100%; }

        /* Hero Image */
        .article-hero { position: relative; border-radius: var(--radius); overflow: hidden; margin-bottom: 24px; }
        .article-hero-img { width: 100%; height: auto; aspect-ratio: 16/9; object-fit: cover; }
        .article-hero-overlay {
            position: absolute; inset: 0;
            background: linear-gradient(to top, rgba(0,0,0,0.8) 0%, rgba(0,0,0,0) 60%);
            display: flex; flex-direction: column; justify-content: flex-end; padding: 32px;
        }
        @media (max-width: 767px) { .article-hero-overlay { padding: 16px; } }

        .article-hero-tag {
            font-family: 'Work Sans', sans-serif; font-size: 10px; font-weight: 700;
            background-color: rgba(255, 255, 255, 0.9); color: var(--primary);
            padding: 4px 12px; border-radius: var(--radius); display: inline-block;
            text-transform: uppercase; letter-spacing: 0.1em; align-self: flex-start; margin-bottom: 16px;
        }
        .article-hero-title {
            font-family: 'Epilogue', sans-serif; font-size: 36px; font-weight: 700;
            color: #ffffff; line-height: 1.2; margin: 0;
        }
        @media (max-width: 767px) { .article-hero-title { font-size: 24px; } }

        /* Meta Information */
        .article-meta {
            display: flex; align-items: center; gap: 16px; margin-bottom: 40px;
            padding-bottom: 24px; border-bottom: 1px solid var(--surface-variant);
        }
        .article-meta-avatar { width: 48px; height: 48px; border-radius: 50%; object-fit: cover; filter: grayscale(100%); }
        .article-meta-info { display: flex; flex-direction: column; }
        .article-author-name { font-size: 14px; font-weight: 600; color: var(--on-surface); margin-bottom: 4px; }
        .article-meta-details { display: flex; align-items: center; font-size: 12px; color: var(--on-surface-variant); gap: 8px; }
        .meta-dot { width: 4px; height: 4px; background-color: var(--outline-variant); border-radius: 50%; }

        /* Content Formatting */
        .article-content { font-size: 16px; color: var(--on-surface-variant); line-height: 1.8; }
        .article-content p { margin-bottom: 24px; }
        .article-content h2 {
            font-family: 'Epilogue', sans-serif; font-size: 24px; font-weight: 600;
            color: var(--on-surface); margin: 40px 0 16px 0;
        }
        .article-content blockquote {
            border-left: 4px solid #d18900; padding-left: 24px; margin: 32px 0;
            font-family: 'Epilogue', sans-serif; font-size: 20px; font-style: italic; color: var(--on-surface);
        }
        .article-content-img { width: 100%; border-radius: var(--radius); margin: 32px 0; border: 1px solid var(--surface-variant); }

        /* Author Box */
        .article-author-box {
            margin-top: 48px; padding: 24px; background-color: var(--surface-container-lowest);
            border: 1px solid var(--surface-variant); border-radius: var(--radius);
            display: flex; flex-direction: column; gap: 24px; align-items: flex-start;
        }
        @media (min-width: 640px) {
            .article-author-box { flex-direction: row; }
        }
        .article-author-box-avatar { width: 80px; height: 80px; border-radius: 8px; object-fit: cover; filter: grayscale(100%); }
        .article-author-box-info { display: flex; flex-direction: column; }
        .article-author-box-name { font-family: 'Epilogue', sans-serif; font-size: 18px; font-weight: 600; color: var(--on-surface); margin-bottom: 8px; }
        .article-author-box-name a:hover { text-decoration: underline; }
        .article-author-box-bio { font-size: 14px; color: var(--on-surface-variant); margin-bottom: 12px; line-height: 1.6; }
        .article-author-box-links { display: flex; gap: 12px; }
        .article-author-box-links a { color: var(--outline); transition: color 0.2s ease; }
        .article-author-box-links a:hover { color: var(--primary); }

        /* Tags */
        .article-tags { display: flex; flex-wrap: wrap; gap: 8px; margin-top: 24px; }
        .article-tag {
            padding: 6px 12px; background-color: var(--surface-variant); color: var(--on-surface-variant);
            font-size: 11px; font-weight: 600; border-radius: var(--radius); text-transform: uppercase; letter-spacing: 0.1em;
        }

        /* ============================================================
           SIDEBAR (Right Column)
           ============================================================ */
        .sidebar-sticky { position: sticky; top: 100px; display: flex; flex-direction: column; gap: 24px; }
        
        .sidebar-widget {
            background-color: var(--surface-container-lowest); padding: 24px;
            border: 1px solid var(--surface-variant); border-radius: var(--radius);
        }

        .sidebar-search { position: relative; }
        .sidebar-search-icon { position: absolute; left: 12px; top: 50%; transform: translateY(-50%); color: var(--outline); font-size: 20px;}
        .sidebar-search-input {
            width: 100%; background-color: var(--surface-container-lowest); border: 1px solid var(--outline-variant);
            border-radius: var(--radius); padding: 10px 12px 10px 40px; font-size: 14px; color: var(--on-surface); outline: none;
        }
        .sidebar-search-input:focus { border-color: var(--primary-container); }

        .sidebar-toc-title { font-family: 'Epilogue', sans-serif; font-size: 16px; font-weight: 600; color: var(--on-surface); margin-bottom: 16px; }
        .sidebar-toc-list { list-style: none; display: flex; flex-direction: column; gap: 12px; }
        .sidebar-toc-link { font-size: 14px; color: var(--on-surface-variant); transition: color 0.2s ease; }
        .sidebar-toc-link:hover { color: var(--primary); text-decoration: underline; }

        .sidebar-newsletter { background-color: var(--primary-container); color: var(--on-primary); padding: 32px; border-radius: var(--radius); text-align: center; }
        .sidebar-newsletter-icon { font-size: 32px; color: #f5a623; margin-bottom: 16px; }
        .sidebar-newsletter-title { font-family: 'Epilogue', sans-serif; font-size: 20px; font-weight: 600; margin-bottom: 12px; }
        .sidebar-newsletter-desc { font-size: 14px; color: #dce1ff; margin-bottom: 24px; line-height: 1.5; }
        .sidebar-newsletter-input {
            width: 100%; background-color: rgba(255,255,255,0.1); border: 1px solid rgba(255,255,255,0.2);
            border-radius: var(--radius); padding: 12px; margin-bottom: 12px; color: var(--on-primary); outline: none; font-size: 14px;
        }
        .sidebar-newsletter-input::placeholder { color: rgba(255,255,255,0.6); }
        .sidebar-newsletter-btn {
            width: 100%; background-color: #ffffff; color: var(--primary-container);
            font-size: 12px; font-weight: 700; text-transform: uppercase; letter-spacing: 0.1em;
            padding: 12px; border: none; border-radius: var(--radius); transition: background-color 0.2s ease;
        }
        .sidebar-newsletter-btn:hover { background-color: var(--surface-variant); }

        /* ============================================================
           RELATED ADVENTURES
           ============================================================ */
        .related-section {
            background-color: var(--surface-container); padding: 64px 16px;
            border-top: 1px solid var(--surface-variant);
        }
        .related-container { max-width: var(--container-max); margin: 0 auto; }
        @media (min-width: 768px) { .related-section { padding: 64px 48px; } }

        .related-title { font-family: 'Epilogue', sans-serif; font-size: 24px; font-weight: 600; color: var(--on-surface); margin-bottom: 32px; }
        .related-grid { display: grid; grid-template-columns: 1fr; gap: 24px; }
        @media (min-width: 768px) { .related-grid { grid-template-columns: repeat(3, 1fr); } }

        .standard-card {
            background-color: var(--surface-container-lowest); border-radius: var(--radius);
            border: 1px solid var(--surface-variant); overflow: hidden; display: flex; flex-direction: column;
            transition: box-shadow 0.3s ease; cursor: pointer;
        }
        .standard-card:hover { box-shadow: 0px 4px 20px rgba(36,46,84,0.08); }
        .standard-card:hover .card-img { transform: scale(1.05); }

        .card-img-wrapper { height: 200px; overflow: hidden; }
        .card-img { width: 100%; height: 100%; object-fit: cover; transition: transform 0.5s ease; }
        .card-content { padding: 24px; display: flex; flex-direction: column; flex-grow: 1; }
        
        .card-category-tag { font-size: 10px; font-weight: 700; color: var(--accent-orange); text-transform: uppercase; letter-spacing: 0.1em; margin-bottom: 12px; }
        .card-title { font-family: 'Epilogue', sans-serif; font-size: 18px; font-weight: 600; color: var(--on-surface); margin-bottom: 12px; line-height: 1.3; }
        .card-excerpt { font-size: 14px; color: var(--on-surface-variant); line-height: 1.5; }
    </style>
</head>
<body class="article-layout">
    
    <!-- Reading Progress Bar -->
    <div class="reading-progress-bar"></div>
    
    <!-- Header Include -->
    <jsp:include page="/WEB-INF/views/includes/header.jsp" />
    
    <!-- Main Content -->
    <main class="article-main">
        <div class="article-grid">
            
            <!-- Left Column: Article Body -->
            <article class="article-body">
                
                <!-- Hero Image & Title -->
                <div class="article-hero">
                    <img alt="Himalayan Mountains" class="article-hero-img" src="https://lh3.googleusercontent.com/aida-public/AB6AXuDGwjC4hBUYY8Fluz-be2y2hiJ1h1emSjNgUq7iVyeRydEfrVHNFkeczpuTO23ksfw-da2pYvgaXQsBdFM0r-n309KqGurFBpMstEDseyufNbJ6ybHq5B-5vc9hMvIorHkjgy4AweqU9XQbCEMXT4ya1rAM3tlY_RF_hdmvux7iz8lu-J-cvO0SIxQGl_DMBR5n04MUPrbkh0nRG4UgbR20PK5TR3Z78jyMf48G6muFud6GRxqneT7jDulhSt3zfo5Qqc-ksCjH2pg" />
                    <div class="article-hero-overlay">
                        <span class="article-hero-tag">High-Altitude Trekking</span>
                        <h1 class="article-hero-title">The Silence of the Himalayas: A Guide to the Annapurna Sanctuary</h1>
                    </div>
                </div>
                
                <!-- Meta Information -->
                <div class="article-meta">
                    <img alt="Sarah Jenkins" class="article-meta-avatar" src="https://lh3.googleusercontent.com/aida-public/AB6AXuD6VvikodaM4SMNlAPljDzB8fbP6bx4TIobfD9JnTjAP6lTzrpECofcgiczF5__r6JgdNi5G6yqypks-NE5Mzw3w15hGSHS45VykLsSz7eo2bd9_7e8YM6_HvqOryAmpEUd6_9635araoduB-fuzPsVLrYKDqSjO355yOKFvOhHSDdzQjvsZI-dl_VKlnTfrnj3lrLrZ7AK80MDgna2e7nR-WYILbuvLCu9xm6k-UJkg2Eewa9uxHAV45kU1vSpxo4M9daaqSRrwcY" />
                    <div class="article-meta-info">
                        <span class="article-author-name">Sarah Jenkins</span>
                        <div class="article-meta-details">
                            <span>Oct 24, 2026</span>
                            <span class="meta-dot"></span>
                            <span>12 min read</span>
                        </div>
                    </div>
                </div>
                
                <!-- Article Content -->
                <div class="article-content">
                    <p>There is a specific kind of silence that exists only above 4,000 meters. It is not an empty silence, but a heavy, expectant one, thick with the history of shifting tectonic plates and the sparse, ragged breath of those who wander here. This is the Annapurna Sanctuary, a high glacial basin nestled like a secret within a ring of colossal Himalayan peaks.</p>
                    
                    <h2>The Ascent</h2>
                    <p>The trek begins in the humid, verdant foothills, where rhododendron forests cling to steep hillsides. The trail, uneven and demanding, forces a rhythm upon you—step, breathe, step, breathe. As days blur into one another, the landscape transforms drastically. The lush greenery recedes, replaced by an austere, monochromatic world of rock and ice.</p>
                    
                    <blockquote>
                        "In the mountains, you don't conquer the peak; you conquer yourself. The sanctuary demands respect, and in return, it offers a profound sense of insignificance."
                    </blockquote>
                    
                    <p>Reaching Machapuchare Base Camp is a turning point. The physical toll is undeniable, but the visual reward is staggering. The fishtail peak of Machapuchare, considered sacred and thus unclimbed, dominates the skyline, its sheer face glowing ethereal in the alpenglow.</p>
                    
                    <h2>Living with Locals</h2>
                    <p>The tea houses along the route are sparse sanctuaries of warmth. Here, over plates of dal bhat—the staple lentil and rice dish that powers every trekker in Nepal—stories are shared around cast-iron stoves. The Gurung people, native to this region, exude a quiet resilience that mirrors the mountains they call home.</p>
                    
                    <img alt="Himalayan Tea House" class="article-content-img" src="https://lh3.googleusercontent.com/aida-public/AB6AXuBP8zIxcl6sGbxgJR0Mgpr3OalHIQC6OimOcoCLQC8ep1An-dc62r9Ry04cgibbKlBvLVQOEH_dwha5BF_FOFI0Mbc7Soc2uSajRMUJRkYEm1VHsEOkNGVm2EDYs8BAV_62k9jiFWdYYSWhd3WudBfXFSpaJW-TnT14qInw-NJ1WGVLJ3N1DdFZAgK2FPrjuDL3cpJU1irmgGUJGek5qtvVbQbPjlIZemssyrphJB6N3acBRHjBS1cxA1qxHihdbtnM8z3YaFBlqxM" />
                    
                    <h2>Final Thoughts</h2>
                    <p>Entering the sanctuary itself is a humbling experience. Standing surrounded by 360 degrees of soaring peaks—Annapurna I, Annapurna South, Hiunchuli—you realize the silence isn't an absence of sound, but the overwhelming presence of nature in its rawest form. It is a journey that breaks you down only to build you back up, stronger and more aware.</p>
                </div>
                
                <!-- Author Bio Box -->
                <div class="article-author-box">
                    <img alt="Sarah Jenkins" class="article-author-box-avatar" src="https://lh3.googleusercontent.com/aida-public/AB6AXuBinIDseli6Na_I3o5JsukKM1p98SyoIZn1K72WN52I4O-g5EYZfxPAeD6GSGvgPQEhqyRmvYDzi_w2zCTEWJdH5BfgjOtqXawwCApDmSS6HIvEq-xLQXds6gG4aDChFU9zEXDRUMyEs4dE_DDRpxmRm-0OBxAh3NQR4IbXSC3y1Uh4c4GDMdA_rNvhy9FOZQZsnWgybGgsvTvvsQ2wLwAjdIAXQ5e00mi7v3hxXLOh3Dr_dMO3iogVyZ4eCpNFhEAxe3vjpEHV5VY" />
                    <div class="article-author-box-info">
                        <h3 class="article-author-box-name"><a href="#">Sarah Jenkins</a></h3>
                        <p class="article-author-box-bio">Sarah Jenkins is a seasoned explorer with over a decade of experience traversing remote mountain ranges. Her writing focuses on the intersection of human endurance and pristine natural environments. When not on the trail, she advocates for sustainable tourism in fragile alpine ecosystems.</p>
                        <div class="article-author-box-links">
                            <a href="#"><span class="material-symbols-outlined">camera_alt</span></a>
                            <a href="#"><span class="material-symbols-outlined">chat_bubble</span></a>
                        </div>
                    </div>
                </div>
                
                <!-- Tags -->
                <div class="article-tags">
                    <span class="article-tag">#Nepal</span>
                    <span class="article-tag">#Annapurna</span>
                    <span class="article-tag">#Trekking</span>
                    <span class="article-tag">#Solukhumbu</span>
                </div>
            </article>
            
            <!-- Right Column: Sidebar -->
            <aside class="article-sidebar">
                <div class="sidebar-sticky">
                    
                    <!-- Search Bar -->
                    <div class="sidebar-widget">
                        <div class="sidebar-search">
                            <span class="material-symbols-outlined sidebar-search-icon">search</span>
                            <input class="sidebar-search-input" placeholder="Search stories..." type="text" />
                        </div>
                    </div>
                    
                    <!-- Table of Contents -->
                    <div class="sidebar-widget">
                        <h4 class="sidebar-toc-title">Contents</h4>
                        <ul class="sidebar-toc-list">
                            <li><a class="sidebar-toc-link" href="#">Introduction</a></li>
                            <li><a class="sidebar-toc-link" href="#">The Ascent</a></li>
                            <li><a class="sidebar-toc-link" href="#">Living with Locals</a></li>
                            <li><a class="sidebar-toc-link" href="#">Final Thoughts</a></li>
                        </ul>
                    </div>
                    
                    <!-- Newsletter Widget -->
                    <div class="sidebar-newsletter">
                        <span class="material-symbols-outlined sidebar-newsletter-icon">mail</span>
                        <h4 class="sidebar-newsletter-title">Join the Tribe</h4>
                        <p class="sidebar-newsletter-desc">Get editorial dispatches from the world's remote corners delivered to your inbox.</p>
                        <input class="sidebar-newsletter-input" placeholder="Your email address" type="email" />
                        <button class="sidebar-newsletter-btn">Subscribe</button>
                    </div>
                    
                </div>
            </aside>
        </div>
    </main>
    
    <!-- Related Adventures Section (Full Width Background) -->
    <section class="related-section">
        <div class="related-container">
            <h3 class="related-title">Related Adventures</h3>
            <div class="related-grid">
                
                <div class="standard-card">
                    <div class="card-img-wrapper">
                        <img alt="Desert" class="card-img" src="https://lh3.googleusercontent.com/aida-public/AB6AXuDg-i9Spsi8Q3uKBLC1x2Ek2gVG6waLl3ju_nlDbCmAq1dmI46qOP9PabenS8sRmsjWX3QO8MGXuyEay_4ozFId7tNbp_QtYN9l0vsRfWzRo5SJWWWDIRVO_5l8003u2r_wPT4Qj_h4E17Z7MEbB35_N_OxpfNuPchRr29eEnQMv1cZEuwnfnbeO2WF7aGRU3ksOczBxl7JTE_YqQaJaPrlyLCVFrjBEtIWIuYWkbtLY9v3XFDzdZKb0SxMIeoCMm4lF27znm6JPzc" />
                    </div>
                    <div class="card-content">
                        <span class="card-category-tag">Desert Exploration</span>
                        <h4 class="card-title">Crossing the Atacama: Silence and Salt</h4>
                        <p class="card-excerpt">A journey through the driest place on earth reveals hidden lagoons, bizarre rock formations, and a profound sense of isolation.</p>
                    </div>
                </div>
                
                <div class="standard-card">
                    <div class="card-img-wrapper">
                        <img alt="Canyon" class="card-img" src="https://lh3.googleusercontent.com/aida-public/AB6AXuAFcncABmIMSr2VLoZ9dZK4PC8aTi0yqvhDDk1yojPFqmDcnkYLyLARilIanlGvbz98I9uzXryec3nhSVHTsJn3DFgj8KkD5N3dxnFpJXIUhw1yy1z0KD4Pe3a6qeHKf9_OlKF43xor5LUZZ6K_DFAdDsEOfeJ9TEmCw0MYbtl0ABO7vvJxw6J0CPeMqBxjajhPqb5gmJoxJ8LbKaOyRB_GpxmVrWB_KM-MYXe1HZ5FB1qK_gtCtQpWVXUeq51FCvIO5z5j5wfbeTA" />
                    </div>
                    <div class="card-content">
                        <span class="card-category-tag">Canyon Trekking</span>
                        <h4 class="card-title">Navigating the Narrows: Zion's Heart</h4>
                        <p class="card-excerpt">Wading through slot canyons carved over millennia, understanding the flow of water and stone in America's rugged southwest.</p>
                    </div>
                </div>
                
                <div class="standard-card">
                    <div class="card-img-wrapper">
                        <img alt="Lake" class="card-img" src="https://lh3.googleusercontent.com/aida-public/AB6AXuARvAntndvl8q5OTeHgrbXbHHFXX4-T12nIa3-FfEB5k4gVfWiknoUwBi0FvOwtgOAEgHRLxfzMHiQlwnW-Pk7F-701ugovayTAN802qca0lcl5rfrbaihVVp-M5HkXCP08dPf5Q1oNnCeKdCW6XHjNpaaDkJEg8Iq2PKBBFd9jihft_Prj2tgZyNX5bCfulxWrpeS-RfsLmBPN0Vci9gL8No2Ks_FNlXEO2jCy4EyOvZXLY5rkN0-KG4lykEL-8ySubRoOd8twcq4" />
                    </div>
                    <div class="card-content">
                        <span class="card-category-tag">Alpine Lakes</span>
                        <h4 class="card-title">Mirrors of the Sky: Patagonia's Hidden Tarns</h4>
                        <p class="card-excerpt">Discovering glacial lakes perched precariously beneath the sheer granite spires of the Fitz Roy massif.</p>
                    </div>
                </div>
                
            </div>
        </div>
    </section>
    
    <!-- Footer Include -->
    <jsp:include page="/WEB-INF/views/includes/footer.jsp" />
</body>
</html>