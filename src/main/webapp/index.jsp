<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <title>Thoughts of Nomads</title>
    <!-- Combined all design logic into internal CSS as requested -->
    <style>
        /* ── GLOBAL DESIGN TOKENS ─────────────────────────────── */
        :root {
            --primary: #0e193e;
            --primary-container: #242e54;
            --on-primary: #ffffff;
            --surface: #f8f9fa;
            --surface-container-lowest: #ffffff;
            --surface-variant: #e1e3e4;
            --on-surface: #191c1d;
            --on-surface-variant: #45464e;
            --outline-variant: #c6c5cf;
            --accent-tag: #a26b1c;
            --container-max: 1280px;
            --margin-desktop: 48px;
            --margin-mobile: 16px;
            --radius: 4px;
        }

        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Work Sans', sans-serif; background-color: var(--surface); color: var(--on-surface); line-height: 1.5; -webkit-font-smoothing: antialiased; }
        a { text-decoration: none; color: inherit; }
        img { display: block; max-width: 100%; }

        /* ── HERO SECTION: Frame-within-a-Frame ──────────────── */
        .hero-header {
            width: 100%;
            background-color: #f1f1f1;
            padding: 40px var(--margin-mobile);
        }
        @media (min-width: 768px) { .hero-header { padding: 60px var(--margin-desktop); } }

        .hero-device-frame {
            max-width: var(--container-max);
            margin: 0 auto;
            background-color: #1a1c1e; /* Dark frame color */
            padding: 20px;
            border-radius: 24px;
            box-shadow: 0 20px 50px rgba(0,0,0,0.15);
            position: relative;
        }

        .hero-inner-content {
            position: relative;
            height: 500px;
            border-radius: 8px;
            overflow: hidden;
        }

        .hero-image { width: 100%; height: 100%; object-fit: cover; }
        .hero-overlay {
            position: absolute; inset: 0;
            background: linear-gradient(to bottom, rgba(0,0,0,0.2) 0%, rgba(0,0,0,0.6) 100%);
            display: flex; flex-direction: column; justify-content: center; padding: 48px;
        }

        .hero-title {
            font-family: 'Epilogue', sans-serif;
            font-size: clamp(32px, 5vw, 64px);
            font-weight: 700; color: #ffffff; margin-bottom: 24px;
        }

        .hero-search-form { position: relative; width: 100%; max-width: 500px; }
        .search-icon { position: absolute; left: 16px; top: 50%; transform: translateY(-50%); color: var(--on-surface-variant); }
        .hero-search-input {
            width: 100%; padding: 16px 16px 16px 48px; border: none; border-radius: 4px;
            font-size: 16px; outline: none; background-color: #ffffff;
        }
        .hero-subtitle { color: rgba(255,255,255,0.8); font-size: 12px; text-transform: uppercase; letter-spacing: 0.1em; margin-top: 12px; }

        /* ── SECTION HEADINGS ──────────────────────────────── */
        .home-section { max-width: var(--container-max); margin: 0 auto; padding: 64px var(--margin-mobile); }
        @media (min-width: 768px) { .home-section { padding: 80px var(--margin-desktop); } }
        .section-title { font-family: 'Epilogue', sans-serif; font-size: 32px; font-weight: 700; margin-bottom: 40px; color: #1a1c1e; }

        /* ── ARTICLE CARDS ─────────────────────────────────── */
        .article-grid { display: grid; grid-template-columns: 1fr; gap: 32px; }
        @media (min-width: 640px) { .article-grid { grid-template-columns: repeat(2, 1fr); } }
        @media (min-width: 1024px) { .article-grid { grid-template-columns: repeat(3, 1fr); } }

        .article-card { display: flex; flex-direction: column; cursor: pointer; }
        .card-image-wrapper { width: 100%; aspect-ratio: 16 / 11; overflow: hidden; margin-bottom: 20px; border: 1px solid var(--surface-variant); }
        .card-image { width: 100%; height: 100%; object-fit: cover; transition: transform 0.4s ease; }
        .article-card:hover .card-image { transform: scale(1.05); }

        .card-content { display: flex; flex-direction: column; gap: 12px; }
        .card-tag {
            font-size: 10px; font-weight: 700; text-transform: uppercase; letter-spacing: 0.1em;
            color: #d18900; background-color: #fff9eb; padding: 4px 10px; border-radius: 2px; width: max-content;
        }
        .card-title { font-family: 'Epilogue', sans-serif; font-size: 22px; font-weight: 600; color: #1a1c1e; line-height: 1.3; }
        .card-excerpt { font-size: 15px; color: #4a4a4a; line-height: 1.6; }
        .card-meta { font-size: 11px; font-weight: 700; color: #888888; text-transform: uppercase; letter-spacing: 0.05em; margin-top: 4px; }
    </style>
    <!-- Fonts and Icons Load -->
    <link href="https://fonts.googleapis.com/css2?family=Epilogue:wght@400;600;700&family=Work+Sans:wght@400;500;600&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet" />
</head>

<body>
    <!-- TopNavBar -->
    <jsp:include page="/WEB-INF/views/includes/header.jsp" />
    
    <!-- Hero Section with Device Frame -->
    <header class="hero-header">
        <div class="hero-device-frame">
            <div class="hero-inner-content">
                <img alt="Scenic mountain road" class="hero-image"
                     src="https://lh3.googleusercontent.com/aida-public/AB6AXuAx0KvZtVOsZeiePSzu3IW7UmdrLENlMC0OFKAKdfmzAOFE363Enj_leN19hImv4ifwFCoSojk2Jb2Hm69Wb6_52yqHhq8UhojRpelj_gPTcD5hn8-eYglCk_3UxR9gnW9ZELHwdxdBaAaW2L-4GwjOruJ2r8nhWNhIlbvG9WlN0AjXAHiXBaP3aQXg5hTMmEAw9ECdHwfUT9EngIGWnDh6ht1q3vT4IlSbamk2KGwPx76VNAkSm8QO8UKAww378qTRAUoMEqv81jw" />
                <div class="hero-overlay">
                    <h1 class="hero-title">Your Next Adventure Awaits</h1>
                    <form action="<%=request.getContextPath()%>/search" method="GET" class="hero-search-form">
                        <span class="material-symbols-outlined search-icon">search</span>
                        <input class="hero-search-input" placeholder="Where to next?" type="text" name="q" />
                    </form>
                    <p class="hero-subtitle">Search by destination, author, or category</p>
                </div>
            </div>
        </div>
    </header>

    <!-- Top Picks Section -->
    <section class="home-section">
        <h2 class="section-title">Top Picks</h2>
        <div class="article-grid">
            
            <article class="article-card" onclick="window.location.href='#'">
                <div class="card-image-wrapper">
                    <img alt="Desert trekking" class="card-image" src="https://lh3.googleusercontent.com/aida-public/AB6AXuDG6EfvItlcdTwuTI3nRR1-Lp7u1bmz4J-btTxf86e5edif2q3xaYvD1hM_Q7I8nQDQekdaItcpgx4zykw8XSv2-ed3DsFaWEpbFVjPWLf8hCvfMDrFzaKhgux8SjyslvWSNZl5UoJ-vXWT7Pc76Xm_T_LkFVV9QrwmPCRfA2w08saQmUHeU2gLMnXBmRXAi8x-t6aPM3aFP1GQZ_KFn7uPlrvyXrzSFGoGkWfuviYGAWNblw39KA88SAf_D35ty_do3MZ0HXXDSD0" />
                </div>
                <div class="card-content">
                    <span class="card-tag">Trekking</span>
                    <h3 class="card-title">Crossing the Empty Quarter</h3>
                    <p class="card-excerpt">An arduous journey through one of the most unforgiving landscapes on earth, discovering beauty in desolation.</p>
                    <p class="card-meta">By Elena Rostova</p>
                </div>
            </article>

            <article class="article-card" onclick="window.location.href='#'">
                <div class="card-image-wrapper">
                    <img alt="Coastal view" class="card-image" src="https://lh3.googleusercontent.com/aida-public/AB6AXuBUQH7Bp24cG_kdaFrf1lACtzQKQ5H2I7V8_6mwmX68VMeB7Pkel1IpqyspD7OBGt926gjzn2-8h6MqoLpwyXxuA0BcpQ4t3dggI_GVeTOCMD1HEgkOVimyYPofHWx_2afnYXA5TGxTCqG2-SuobyKNIqSA60NEmTas5gNfhqogLYsDL0NpTaEMrInsAoCj4u0WigZMvPfXw8_-mhiNtZ3_9-dBYK1xUHs2e8ouD1ZR7Pnyi2LqQzYxgqtmDbeeWyLWvRPqjWZYWhw" />
                </div>
                <div class="card-content">
                    <span class="card-tag">Coastal</span>
                    <h3 class="card-title">The Silence of the Azores</h3>
                    <p class="card-excerpt">Finding isolation and raw natural power on the rugged edges of the Atlantic Ocean.</p>
                    <p class="card-meta">By Marcus Thorne</p>
                </div>
            </article>

            <article class="article-card" onclick="window.location.href='#'">
                <div class="card-image-wrapper">
                    <img alt="Urban view" class="card-image" src="https://lh3.googleusercontent.com/aida-public/AB6AXuCqu4evWJbrSTEqWxv9z3ix6M_VZ0rkxg_r99jSozaDrVHTuuuHVeELv85ZBOnvGbhT4O2_0xM62TUkC_aqwahR23bMrD3kN1pz0MY-GG6XqKaYokvE-HYcmX4p7kS3uuUwsiQoqZxJ-FxdfzwibqFWsO5C4FSIYBcDh_a35SnItm4yqV2wn-RNjXrdqOO8iJrqWFP3HHqFi1kuYuY2327Zb91nFUSdE_zzxOFKw8GpiSettbJO4tofTH3lRD1t9VlNMAGv6cRLi40" />
                </div>
                <div class="card-content">
                    <span class="card-tag">Urban</span>
                    <h3 class="card-title">Lost in Old Tbilisi</h3>
                    <p class="card-excerpt">Wandering through the crumbling courtyards and vibrant streets of a city straddling two worlds.</p>
                    <p class="card-meta">By Sarah Jenkins</p>
                </div>
            </article>

        </div>
    </section>

    <!-- Latest Stories Section -->
    <section class="home-section" style="padding-top: 0;">
        <h2 class="section-title">Latest Stories</h2>
        <div class="article-grid">
            
            <article class="article-card">
                <div class="card-image-wrapper">
                    <img alt="Andes mountains" class="card-image" src="https://lh3.googleusercontent.com/aida-public/AB6AXuAx0KvZtVOsZeiePSzu3IW7UmdrLENlMC0OFKAKdfmzAOFE363Enj_leN19hImv4ifwFCoSojk2Jb2Hm69Wb6_52yqHhq8UhojRpelj_gPTcD5hn8-eYglCk_3UxR9gnW9ZELHwdxdBaAaW2L-4GwjOruJ2r8nhWNhIlbvG9WlN0AjXAHiXBaP3aQXg5hTMmEAw9ECdHwfUT9EngIGWnDh6ht1q3vT4IlSbamk2KGwPx76VNAkSm8QO8UKAww378qTRAUoMEqv81jw" />
                </div>
                <div class="card-content">
                    <span class="card-tag">Trekking</span>
                    <h3 class="card-title">Summiting the Andes</h3>
                    <p class="card-excerpt">A first-hand account of the grueling climb to the peak of Huascarán.</p>
                    <p class="card-meta">Oct 24, 2026</p>
                </div>
            </article>

            <article class="article-card">
                <div class="card-image-wrapper">
                    <img alt="Tokyo alleys" class="card-image" src="https://lh3.googleusercontent.com/aida-public/AB6AXuCqu4evWJbrSTEqWxv9z3ix6M_VZ0rkxg_r99jSozaDrVHTuuuHVeELv85ZBOnvGbhT4O2_0xM62TUkC_aqwahR23bMrD3kN1pz0MY-GG6XqKaYokvE-HYcmX4p7kS3uuUwsiQoqZxJ-FxdfzwibqFWsO5C4FSIYBcDh_a35SnItm4yqV2wn-RNjXrdqOO8iJrqWFP3HHqFi1kuYuY2327Zb91nFUSdE_zzxOFKw8GpiSettbJO4tofTH3lRD1t9VlNMAGv6cRLi40" />
                </div>
                <div class="card-content">
                    <span class="card-tag">Urban</span>
                    <h3 class="card-title">Tokyo's Hidden Alleys</h3>
                    <p class="card-excerpt">Finding the soul of the city in its quietest, most colorful corners.</p>
                    <p class="card-meta">Oct 22, 2026</p>
                </div>
            </article>

            <article class="article-card">
                <div class="card-image-wrapper">
                    <img alt="Bali shores" class="card-image" src="https://lh3.googleusercontent.com/aida-public/AB6AXuBUQH7Bp24cG_kdaFrf1lACtzQKQ5H2I7V8_6mwmX68VMeB7Pkel1IpqyspD7OBGt926gjzn2-8h6MqoLpwyXxuA0BcpQ4t3dggI_GVeTOCMD1HEgkOVimyYPofHWx_2afnYXA5TGxTCqG2-SuobyKNIqSA60NEmTas5gNfhqogLYsDL0NpTaEMrInsAoCj4u0WigZMvPfXw8_-mhiNtZ3_9-dBYK1xUHs2e8ouD1ZR7Pnyi2LqQzYxgqtmDbeeWyLWvRPqjWZYWhw" />
                </div>
                <div class="card-content">
                    <span class="card-tag">Coastal</span>
                    <h3 class="card-title">The Secrets of Bali</h3>
                    <p class="card-excerpt">Beyond the resorts: discovering the untouched shores of the Nusa islands.</p>
                    <p class="card-meta">Oct 20, 2026</p>
                </div>
            </article>

        </div>
    </section>

    <!-- Footer -->
    <jsp:include page="/WEB-INF/views/includes/footer.jsp" />
</body>
</html>