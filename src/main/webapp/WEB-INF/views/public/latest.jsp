<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <title>Latest Journeys - Thoughts of Nomads</title>
    
    <!-- Google Fonts -->
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
            --secondary: #a23d30;
            --surface: #ffffff;
            --surface-container-lowest: #ffffff;
            --surface-container: #f3f4f5;
            --surface-variant: #e1e3e4;
            --on-surface: #191c1d;
            --on-surface-variant: #45464e;
            --background: #f8f9fa;
            --outline: #76767f;
            --outline-variant: #c6c5cf;
            --accent-yellow: #f5a623; /* For the newsletter button & highlight tags */
            
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

        /* ============================================================
           LATEST PAGE LAYOUT
           ============================================================ */
        .latest-layout { display: flex; flex-direction: column; min-height: 100vh; }
        .latest-main {
            flex-grow: 1;
            max-width: var(--container-max);
            margin: 0 auto;
            padding: 48px var(--margin-mobile);
            width: 100%;
        }
        @media (min-width: 768px) {
            .latest-main { padding: 48px var(--margin-desktop); }
        }

        /* Header & Breadcrumbs */
        .latest-header { margin-bottom: 48px; }
        .breadcrumbs {
            display: flex; align-items: center; gap: 8px;
            font-size: 10px; font-weight: 600; color: var(--on-surface-variant);
            text-transform: uppercase; letter-spacing: 0.1em; margin-bottom: 16px;
        }
        .breadcrumb-link:hover { color: var(--primary); text-decoration: underline; }
        .breadcrumb-icon { font-size: 14px; }
        .breadcrumb-current { color: var(--primary); }

        .latest-title {
            font-family: 'Epilogue', sans-serif; font-size: 36px; font-weight: 700;
            color: var(--on-surface); margin-bottom: 32px; text-transform: uppercase;
        }

        /* Filters & Sort Bar */
        .latest-filters-bar {
            display: flex; flex-direction: column; gap: 24px;
            border-bottom: 1px solid var(--surface-variant); padding-bottom: 24px;
        }
        @media (min-width: 768px) {
            .latest-filters-bar { flex-direction: row; justify-content: space-between; align-items: center; }
        }

        .filter-buttons { display: flex; flex-wrap: wrap; gap: 8px; }
        .filter-btn {
            padding: 8px 20px; background-color: var(--surface-container-lowest);
            color: var(--on-surface); border: 1px solid var(--outline-variant);
            font-size: 10px; font-weight: 600; text-transform: uppercase; letter-spacing: 0.1em;
            border-radius: 9999px; transition: all 0.2s ease;
        }
        .filter-btn:hover { background-color: var(--surface-container); }
        .filter-btn.active { background-color: var(--primary-container); color: var(--on-primary); border-color: var(--primary-container); }

        .sort-container { display: flex; align-items: center; gap: 8px; }
        .sort-label { font-size: 10px; font-weight: 600; text-transform: uppercase; letter-spacing: 0.1em; color: var(--on-surface-variant); }
        .sort-select {
            background-color: transparent; border: 1px solid var(--outline-variant);
            border-radius: var(--radius); padding: 8px 12px; font-family: 'Work Sans', sans-serif;
            font-size: 14px; color: var(--on-surface); outline: none; cursor: pointer;
        }

        /* ============================================================
           FEATURED SECTION
           ============================================================ */
        .featured-section { margin-bottom: 64px; }
        .featured-card {
            display: grid; grid-template-columns: 1fr;
            background-color: var(--surface-container-lowest);
            border-radius: var(--radius); border: 1px solid var(--surface-variant);
            overflow: hidden; transition: box-shadow 0.3s ease;
        }
        @media (min-width: 1024px) {
            .featured-card { grid-template-columns: 1.5fr 1fr; }
        }
        .featured-card:hover { box-shadow: 0px 4px 20px rgba(36,46,84,0.08); }

        .featured-image-wrapper { height: 300px; }
        @media (min-width: 1024px) { .featured-image-wrapper { height: 100%; min-height: 400px; } }
        .featured-image { width: 100%; height: 100%; object-fit: cover; }

        .featured-content { padding: 32px; display: flex; flex-direction: column; justify-content: center; }
        @media (min-width: 1024px) { .featured-content { padding: 48px; } }

        .featured-tags { display: flex; align-items: center; gap: 12px; margin-bottom: 24px; }
        .tag-highlight {
            background-color: #fcebd2; color: #a26b1c; padding: 4px 12px;
            font-size: 10px; font-weight: 700; border-radius: var(--radius); text-transform: uppercase; letter-spacing: 0.1em;
        }
        .tag-default { font-size: 10px; font-weight: 600; color: var(--on-surface); text-transform: uppercase; letter-spacing: 0.1em; }

        .featured-title { font-family: 'Epilogue', sans-serif; font-size: 32px; font-weight: 600; color: var(--on-surface); margin-bottom: 16px; line-height: 1.2; }
        .featured-excerpt { font-size: 16px; color: var(--on-surface-variant); margin-bottom: 32px; line-height: 1.6; }
        
        .featured-meta { display: flex; align-items: center; margin-bottom: 32px; }
        .author-info { display: flex; align-items: center; gap: 12px; }
        .author-avatar { width: 40px; height: 40px; border-radius: 50%; object-fit: cover; filter: grayscale(100%); }
        .author-name { font-size: 10px; font-weight: 700; color: var(--on-surface); margin-bottom: 4px; letter-spacing: 0.1em; }
        .author-date { font-size: 12px; color: var(--on-surface-variant); }

        .btn-read-full {
            background-color: var(--primary-container); color: var(--on-primary);
            font-size: 12px; font-weight: 600; text-transform: uppercase; letter-spacing: 0.1em;
            padding: 16px; border-radius: var(--radius); transition: background-color 0.2s ease; width: 100%; text-align: center;
        }
        .btn-read-full:hover { background-color: var(--primary); }

        /* ============================================================
           GRID LAYOUT (Articles + Sidebar)
           ============================================================ */
        .content-grid-layout {
            display: grid; grid-template-columns: 1fr; gap: 48px;
        }
        @media (min-width: 1024px) {
            .content-grid-layout { grid-template-columns: 2fr 1fr; }
        }

        .articles-grid {
            display: grid; grid-template-columns: 1fr; gap: 24px; margin-bottom: 48px;
        }
        @media (min-width: 768px) {
            .articles-grid { grid-template-columns: repeat(2, 1fr); }
        }

        .standard-card {
            background-color: var(--surface-container-lowest); border-radius: var(--radius);
            border: 1px solid var(--surface-variant); display: flex; flex-direction: column;
            overflow: hidden; transition: box-shadow 0.3s ease;
        }
        .standard-card:hover { box-shadow: 0px 4px 20px rgba(36,46,84,0.08); }

        .card-img-wrapper { height: 200px; overflow: hidden; }
        .card-img { width: 100%; height: 100%; object-fit: cover; transition: transform 0.5s ease; }
        .standard-card:hover .card-img { transform: scale(1.05); }

        .card-content { padding: 24px; flex-grow: 1; display: flex; flex-direction: column; }
        .card-tag {
            display: inline-block; padding: 4px 8px; background-color: var(--surface-container);
            color: var(--on-surface); font-size: 9px; font-weight: 600; border-radius: var(--radius);
            text-transform: uppercase; letter-spacing: 0.1em; align-self: flex-start; margin-bottom: 16px;
        }
        .card-title {
            font-family: 'Epilogue', sans-serif; font-size: 20px; font-weight: 600;
            color: var(--on-surface); margin-bottom: 12px; line-height: 1.3;
        }
        .card-excerpt {
            font-size: 14px; color: var(--on-surface-variant); margin-bottom: 24px; flex-grow: 1;
            display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden;
        }

        .card-footer {
            display: flex; align-items: center; gap: 12px; margin-top: auto;
            padding-top: 16px; border-top: 1px solid var(--surface-variant);
        }
        .card-author-avatar {
            width: 32px; 
            height: 32px; 
            border-radius: 50%; 
            object-fit: cover; 
            filter: grayscale(100%);
        }
        .card-meta { font-size: 10px; color: var(--on-surface); font-weight: 700; letter-spacing: 0.1em; }

        /* Pagination */
        .pagination { display: flex; justify-content: center; align-items: center; gap: 8px; padding-top: 32px; border-top: 1px solid var(--surface-variant); }
        .pagination-btn, .page-number {
            border: 1px solid transparent; color: var(--on-surface-variant);
            width: 32px; height: 32px; border-radius: var(--radius); display: flex;
            align-items: center; justify-content: center; font-size: 12px; font-weight: 600; transition: all 0.2s ease;
        }
        .pagination-btn { width: auto; padding: 0 12px; text-transform: uppercase; letter-spacing: 0.1em; }
        .pagination-btn:hover, .page-number:hover { background-color: var(--surface-variant); color: var(--on-surface); }
        .page-number.active { background-color: var(--primary-container); color: var(--on-primary); }

        /* ============================================================
           SIDEBAR WIDGETS
           ============================================================ */
        .sidebar-sticky { position: sticky; top: 100px; display: flex; flex-direction: column; gap: 24px; }
        
        .widget {
            background-color: var(--surface-container-lowest); padding: 24px;
            border-radius: var(--radius); border: 1px solid var(--surface-variant);
        }
        .widget-title { font-family: 'Work Sans', sans-serif; font-size: 14px; color: var(--on-surface); margin-bottom: 16px; font-weight: 600; }

        .widget-search { position: relative; }
        .widget-search-icon { position: absolute; left: 12px; top: 50%; transform: translateY(-50%); color: var(--outline); font-size: 20px;}
        .widget-search-input {
            width: 100%; background-color: var(--surface-container-lowest); border: 1px solid var(--outline-variant);
            border-radius: var(--radius); padding: 10px 12px 10px 40px; font-size: 14px; color: var(--on-surface); outline: none;
        }
        .widget-search-input:focus { border-color: var(--primary-container); }

        .widget-tags { display: flex; flex-wrap: wrap; gap: 8px; }
        .tag-link {
            padding: 6px 12px; background-color: var(--background); color: var(--on-surface-variant);
            font-size: 11px; border-radius: var(--radius); text-decoration: none; border: 1px solid var(--surface-variant);
        }
        .tag-link:hover { background-color: var(--surface-variant); color: var(--on-surface); }

        /* Custom Newsletter Widget */
        .widget-newsletter {
            background-color: var(--primary-container); color: var(--on-primary);
            padding: 32px; border-radius: var(--radius); text-align: center;
        }
        .newsletter-icon { font-size: 32px; color: var(--accent-yellow); margin-bottom: 16px; }
        .newsletter-title { font-family: 'Epilogue', sans-serif; font-size: 24px; margin-bottom: 12px; font-weight: 600;}
        .newsletter-desc { font-size: 14px; color: #dce1ff; margin-bottom: 24px; line-height: 1.5;}
        
        .newsletter-input-side {
            width: 100%; background-color: rgba(255, 255, 255, 0.1); border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: var(--radius); padding: 12px; margin-bottom: 12px; color: var(--on-primary); outline: none;
        }
        .newsletter-input-side::placeholder { color: rgba(255, 255, 255, 0.6); }
        .newsletter-btn-side {
            width: 100%; background-color: var(--accent-yellow); color: #462b00;
            font-size: 12px; font-weight: 700; text-transform: uppercase; letter-spacing: 0.1em;
            padding: 12px; border-radius: var(--radius); border: none; transition: background-color 0.2s ease;
        }
        .newsletter-btn-side:hover { opacity: 0.9; }
    </style>
</head>

<body class="latest-layout">
    <!-- TopNavBar Include -->
    <jsp:include page="/WEB-INF/views/includes/header.jsp" />
    
    <main class="latest-main">
        <!-- Header Section -->
        <header class="latest-header">
            <div class="breadcrumbs">
                <a class="breadcrumb-link" href="<%=request.getContextPath()%>/">Home</a>
                <span class="material-symbols-outlined breadcrumb-icon">chevron_right</span>
                <span class="breadcrumb-current">Latest</span>
            </div>
            <h1 class="latest-title">LATEST JOURNEYS</h1>
            <div class="latest-filters-bar">
                <div class="filter-buttons">
                    <button class="filter-btn active">All</button>
                    <button class="filter-btn">Trekking</button>
                    <button class="filter-btn">Solo</button>
                    <button class="filter-btn">Culture</button>
                    <button class="filter-btn">Food</button>
                </div>
                <div class="sort-container">
                    <span class="sort-label">Sort By:</span>
                    <select class="sort-select">
                        <option>Newest First</option>
                        <option>Most Popular</option>
                        <option>Reading Time</option>
                    </select>
                </div>
            </div>
        </header>

        <!-- Featured Card Hero -->
        <section class="featured-section">
            <div class="featured-card">
                <div class="featured-image-wrapper">
                    <img alt="Featured Journey" class="featured-image"
                        src="https://lh3.googleusercontent.com/aida-public/AB6AXuByW-uh7u867KvN0ZazyvvKV1OnxeDFwQazELire-rp4FDNGGnr7lKtMsPknpx_LDL2uFxnjv2ORICVlxr53-pfuMSWGFCG6gpDfNg3uwcghFn1hXu6KpH1TlUfAjj0NdMlC8TnQaxIswzyp7VwTlj-AaUCRgYqtNqGW18KfhscL-x7lIQIpwPYIlfVCW9SnptXag8pK1mMP6NjWlZmC4NVgbN4wKWk4qK93DcyjdpL5zuIxd4GNlQYK6HVnAq7L7dGBJ31Kj9U2pw" />
                </div>
                <div class="featured-content">
                    <div class="featured-tags">
                        <span class="tag-highlight">JUST PUBLISHED</span>
                        <span class="tag-default">NEPAL</span>
                    </div>
                    <h2 class="featured-title">The Silent Peaks: A Month in the Annapurna Sanctuary</h2>
                    <p class="featured-excerpt">Beyond the teahouses and the popular trails lies a quiet rhythm to the Himalayas. We spent thirty days exploring the lesser-known ridges and valleys, documenting the stark beauty and resilient culture of high-altitude life.</p>
                    <div class="featured-meta">
                        <div class="author-info">
                            <img alt="Author" class="author-avatar"
                                src="https://lh3.googleusercontent.com/aida-public/AB6AXuB8786p5Bw6lWHBnNtY1D45SFi5goF-YTTuqLYmHxbV10hAAdVLVYDfobh_CNFRAY6R3Ur4s0DFoIXUBa40PDxubWUfpNtNE8dHJZlFFX-wq88Hhc7O0wYG8SQhu9lFUwcMzQn__RumIrTucGmZ4MQ_1fFQhH0vtjjijQ9YsAtMeiik-XpXTaOigfOvfCj0HUacSVk9NKK67vc0PPB_5A42QN5rlK6YhA7y66fpPEeNq_Db-YZ-XpMnVFSBkmBGeBi-kGkk4IGY-RE" />
                            <div>
                                <p class="author-name">SARAH JENKINS</p>
                                <p class="author-date">Oct 24, 2026 • 12 min read</p>
                            </div>
                        </div>
                    </div>
                    <button class="btn-read-full">Read Full Journey</button>
                </div>
            </div>
        </section>

        <!-- Main Content Area -->
        <div class="content-grid-layout">
            <!-- Articles Grid -->
            <div class="main-articles">
                <div class="articles-grid">
                    <!-- Article Card 1 -->
                    <article class="standard-card">
                        <div class="card-img-wrapper">
                            <img alt="Japan Journey" class="card-img"
                                src="https://lh3.googleusercontent.com/aida-public/AB6AXuCRFR8CnNWQmQP8raEvwblulaiCv_uT0dnbNzer4WMDXHR2aZ0XWB0_gQYKxWileJ-wY97S3DM5kIfR8K17gV73TExDMQDei256WkTOH8FXyrK3cqX5fyzhH3MGGmyOZdFgQcZUX5w6HuC3GLL-kjfehFhSbB3ZF3SFqs7vD9_XBvbUVCpGE5Zmc0RCzBdhBQOC7-ULPpCgJvtp56z6_f3znEgwKZ0F97MYQ5EHaK0Mp95OOyYPMix4D0dlP0me9MBwnZbBIhdkoOM" />
                        </div>
                        <div class="card-content">
                            <span class="card-tag">JAPAN</span>
                            <h3 class="card-title">Finding Stillness in the Heart of Kyoto</h3>
                            <p class="card-excerpt">Navigating the ancient capital's hidden gardens and quiet alleys, discovering a slow-travel approach to one of the world's most visited cities.</p>
                            <div class="card-footer">
                                <img alt="Author" class="card-author-avatar"
                                    src="https://lh3.googleusercontent.com/aida-public/AB6AXuCPNWN12d7-g4T-A5fdNqWQp2wIdLnoVMJTXGcPMoVjwPUZ6jGbrPzpGqz2jiHH-HMbPoiBQYxQM3xgPwgucg4WgwKY5fnTwFtul_f2GI9cZCGItqUNCg5XAH9yJFd8xDHNkkgEtJaaNvHlqAdkGWe2WDNy6cyN5UlJPNKh5kYEgg1rMvExlcEKqIxO5dcCWO63Q4HGm5XS4_4DmS25cXxKVcXN07xycgFZGvSZG2GIQLOm5PorUyhXkQWVYk_dlRNm7VP34wroLew" />
                                <p class="card-meta">MARK DAVIS • 8 MIN READ</p>
                            </div>
                        </div>
                    </article>
                    
                    <!-- Article Card 2 -->
                    <article class="standard-card">
                        <div class="card-img-wrapper">
                            <img alt="Patagonia Journey" class="card-img"
                                src="https://lh3.googleusercontent.com/aida-public/AB6AXuBbmrXRZkfptHc_ql-QXjiSc605oSUNmlY9-nczMvFHUppNsGf8pFT0KAvi2pv6cwY_NLUsej4qRIDUqEX3gPL8OdwN-ACOwfpGrxBMnFMiZ3-5A1-QOmRvxqAXclU8B8r7SIh6-_3Jkqz6kgUQhUXfPd6I1Fh-M-xKKx9WWml7qTACg88iz4L1Kciib4dXVkcvm5VOSf_bBnAfCLkt33PI3gEcK0t_UGApewodwrE743r6qViS733HDjRvWD4uOPyqZYfmahIfk5Y" />
                        </div>
                        <div class="card-content">
                            <span class="card-tag">PATAGONIA</span>
                            <h3 class="card-title">The End of the Earth: A Guide to the W Trek</h3>
                            <p class="card-excerpt">Practical advice and philosophical musings from five days walking through the howling winds and dramatic granite spires of southern Chile.</p>
                            <div class="card-footer">
                                <img alt="Author" class="card-author-avatar"
                                    src="https://lh3.googleusercontent.com/aida-public/AB6AXuCd_25i-T4FN0i7giy34MIQlkvmn2qYiAlm_twt8UIMbLTsymQJnRkuSkxhj6QAlqGom6BjbrwQwTRgFXAdgsDaVSSFv8msxgm3V5wxBVC-or0oEpdXF7BO9_BqWbipQVmW9h_pMV9JGJcWP0TIrAYCPNVNm1P5_CRIxnkaBNnck1JKrfX-y-X4I9jvegtkscnM1ARzGkFEkm7RjrHHxPiFG4EckobBMwxzCN8rHc-FfONE0e76-WOSb4bemsSKlsKV98Yp_-P20x0" />
                                <p class="card-meta">ELENA RUIZ • 15 MIN READ</p>
                            </div>
                        </div>
                    </article>
                    
                    <!-- Article Card 3 -->
                    <article class="standard-card">
                        <div class="card-img-wrapper">
                            <img alt="Morocco Journey" class="card-img"
                                src="https://lh3.googleusercontent.com/aida-public/AB6AXuDcDUaVDpLKoy-x1RZZyq0HisVUfnpZ5UTfWbytDqWlE_SLh7Afghc9vmI2qtSXsmz_YWv22ku0tQX-fuTxdcJpFSFTuVJYl_QRk2luUx9hTGttNNM_6SMT8kSjXDwDWFXy68V3rZFhH9tjAm-84WqNQ3i_kbSjibkYruehcHUdUv8YFDoGuF6EddvUcXxhDs_MTOThbZnb7YKYeDAIEzHgyyAnKQSPPmDYbRNyi8HeGpJVimRBrtSfls86bCZeLV3HESOUyYdmQGc" />
                        </div>
                        <div class="card-content">
                            <span class="card-tag">MOROCCO</span>
                            <h3 class="card-title">Navigating the Medina: Sensory Overload in Marrakech</h3>
                            <p class="card-excerpt">Embracing the chaos and discovering hidden courtyards of tranquility within the labyrinthine walls of the old city.</p>
                            <div class="card-footer">
                                <img alt="Author" class="card-author-avatar"
                                    src="https://lh3.googleusercontent.com/aida-public/AB6AXuCCHH_2SDAS-ZtuRUbN8OoXZOgZSFN8bcPYpOC9R3U0NlDGiWd1Js0CEBSqKYeYbMbrJSAcJqa6QKX6M6l59VHQOu5vJpPQgD5JsTl2YvMorIVlJZLcg6ZkEkHCNUQexwjGFVieQpIcoSPD4SfAR-AkB4MJPLvHLi9lqGCaz77p8tKk6FZwrHbTR4ageY1oKeOax1Euo6-IwveYHjeMlWPOVOTVc8VtPa-UiF6wNZwupcuRGWjfcKf2QS7GrbytJRXNKtZKQgLWH_c" />
                                <p class="card-meta">JAMES WONG • 10 MIN READ</p>
                            </div>
                        </div>
                    </article>
                    
                    <!-- Article Card 4 -->
                    <article class="standard-card">
                        <div class="card-img-wrapper">
                            <img alt="Norway Journey" class="card-img"
                                src="https://lh3.googleusercontent.com/aida-public/AB6AXuCBnWgSUk4Ddoh4tyLb6m02s1zZheWFNQW71BmTMTEK3WZLW9ulZ3dZlgvZdOATtApl10szE0-8mywPu8OvKZctrrXs-eciKJjvrJdv8bq7HJH3_1fJTsr-yEZx2A0JM7xjh6JG1vzZpmwKb_ecPOJEtKyGqBvrTpIEBKDkx6HY1Klhn9gHMxh-Ej-B7KYMZupTrPXe2f4HSr_IU-tqIpeoWHjhXkorkEBysniVLc3dCMbFaEVN7pf_lfqAS9HtUcPe5qercAV1aro" />
                        </div>
                        <div class="card-content">
                            <span class="card-tag">NORWAY</span>
                            <h3 class="card-title">Arctic Solitude: Cabin Life in the Lofoten Islands</h3>
                            <p class="card-excerpt">A winter retreat exploring remote fjords, deep darkness, and the pursuit of creative focus in extreme environments.</p>
                            <div class="card-footer">
                                <img alt="Author" class="card-author-avatar"
                                    src="https://lh3.googleusercontent.com/aida-public/AB6AXuCQBiVGJVhLL4LvDhnzaDMgsqZ9DxuOncUYJWS2XVaMzLAF7mFOm-oK6-SbadbZ-uPZqePLru0CUF3phwS-oLsuVDYRcZtza2uHjUC3CP98sELGjKCzXhwS9hy_nR9MxLIE7NUU3WlnNnt6xajdBjEJCNqiFpQKFX4vwOGL7qL06M5QvviLWOJogHEP3EmQ33WYgZP_tvC0y-EMlJYg2oTz8mh3WzcUSHEHeDAkskiRoZtWdsxTOnnJqagZI_kq1F51ikRS035UG6o" />
                                <p class="card-meta">SARAH JENKINS • 11 MIN READ</p>
                            </div>
                        </div>
                    </article>
                </div>
                
                <!-- Pagination -->
                <div class="pagination">
                    <button class="pagination-btn"><span class="material-symbols-outlined pagination-icon">chevron_left</span> Previous</button>
                    <button class="page-number active">1</button>
                    <button class="page-number">2</button>
                    <button class="page-number">3</button>
                    <span class="page-dots">...</span>
                    <button class="page-number">10</button>
                    <button class="pagination-btn">Next <span class="material-symbols-outlined pagination-icon">chevron_right</span></button>
                </div>
            </div>
            
            <!-- Sticky Sidebar -->
            <aside class="sidebar">
                <div class="sidebar-sticky">
                    <!-- Search Widget -->
                    <div class="widget">
                        <h3 class="widget-title">Search Archive</h3>
                        <div class="widget-search">
                            <span class="material-symbols-outlined widget-search-icon">search</span>
                            <input class="widget-search-input" placeholder="Keywords, destinations..." type="text" />
                        </div>
                    </div>
                    
                    <!-- Trending Tags Widget -->
                    <div class="widget">
                        <h3 class="widget-title">Trending Explorations</h3>
                        <div class="widget-tags">
                            <a class="tag-link" href="#">#Everest</a>
                            <a class="tag-link" href="#">#NomadLife</a>
                            <a class="tag-link" href="#">#BudgetTrek</a>
                            <a class="tag-link" href="#">#SlowTravel</a>
                            <a class="tag-link" href="#">#RemoteWork</a>
                            <a class="tag-link" href="#">#VanLife</a>
                        </div>
                    </div>
                    
                    <!-- Custom Newsletter Card -->
                    <div class="widget-newsletter">
                        <span class="material-symbols-outlined newsletter-icon">mail</span>
                        <h3 class="newsletter-title">Join the Tribe</h3>
                        <p class="newsletter-desc">Dispatches from the road, editorial insights, and exclusive guides delivered monthly.</p>
                        <input class="newsletter-input-side" placeholder="Your email address" type="email" />
                        <button class="newsletter-btn-side">Subscribe</button>
                    </div>
                </div>
            </aside>
        </div>
    </main>
    
    <!-- Footer Include -->
    <jsp:include page="/WEB-INF/views/includes/footer.jsp" />
</body>
</html>