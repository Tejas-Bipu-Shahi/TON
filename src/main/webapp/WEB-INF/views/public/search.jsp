<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    // Simulated backend logic: If the query is "Atlantis", we show the empty state.
    String query = request.getParameter("q");
    if (query == null || query.isEmpty()) query = "Kathmandu";
    boolean hasResults = !query.equalsIgnoreCase("Atlantis");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <title>Search Results: "<%= query %>" - Thoughts of Nomads</title>
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Epilogue:wght@400;600;700&family=Work+Sans:wght@400;600&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet" />

    <style>
        /* ============================================================
           CSS VARIABLES (Design Tokens)
           ============================================================ */
        :root {
            --primary: #0e193e;
            --primary-container: #242e54;
            --on-primary: #ffffff;
            --secondary: #a23d30;
            --surface: #f8f9fa;
            --surface-container-lowest: #ffffff;
            --surface-container: #edeeef;
            --surface-variant: #e1e3e4;
            --on-surface: #191c1d;
            --on-surface-variant: #45464e;
            --background: #f8f9fa;
            --outline: #76767f;
            --outline-variant: #c6c5cf;
            --container-max: 1280px;
            --margin-desktop: 48px;
            --margin-mobile: 16px;
            --radius: 4px;
            --radius-xl: 12px;
        }

        /* Basic Reset */
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
        button { cursor: pointer; font-family: inherit; }

        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
            vertical-align: middle;
        }

        /* ============================================================
           SEARCH PAGE LAYOUT
           ============================================================ */
        .search-layout { display: flex; flex-direction: column; min-height: 100vh; }
        .search-main { flex-grow: 1; }

        .search-container {
            max-width: var(--container-max);
            margin: 0 auto;
            padding: 0 var(--margin-mobile);
        }
        @media (min-width: 768px) {
            .search-container { padding: 0 var(--margin-desktop); }
        }

        /* Header Section */
        .search-header-section {
            background-color: var(--surface-container-lowest);
            padding: 32px 0 24px 0;
            border-bottom: 1px solid var(--surface-variant);
        }

        .breadcrumbs {
            display: flex; align-items: center; gap: 8px;
            font-size: 12px; color: var(--on-surface-variant);
            margin-bottom: 24px;
        }
        .breadcrumbs a:hover { color: var(--primary); text-decoration: underline; }
        .breadcrumb-icon { font-size: 14px; }

        .search-headline { margin-bottom: 24px; }
        .search-title {
            font-family: 'Epilogue', sans-serif;
            font-size: 32px; font-weight: 600; margin-bottom: 8px;
        }
        .search-subtitle { font-size: 16px; color: var(--on-surface-variant); }

        /* Refiner Bar */
        .search-refiner-bar {
            display: flex; flex-direction: column; gap: 12px;
            background-color: var(--surface);
            border: 1px solid var(--surface-variant);
            border-radius: var(--radius); padding: 12px;
        }
        @media (min-width: 768px) {
            .search-refiner-bar { flex-direction: row; align-items: center; justify-content: space-between; }
        }

        .search-form { position: relative; width: 100%; }
        @media (min-width: 768px) { .search-form { width: 40%; } }

        .search-input-icon {
            position: absolute; left: 12px; top: 50%; transform: translateY(-50%);
            color: var(--on-surface-variant); font-size: 20px;
        }
        .search-input {
            width: 100%; padding: 12px 12px 12px 40px;
            background-color: var(--surface-container-lowest);
            border: 1px solid var(--outline-variant); border-radius: var(--radius);
            font-family: 'Work Sans', sans-serif; font-size: 14px; color: var(--on-surface);
            outline: none; transition: border-color 0.2s ease;
        }
        .search-input:focus { border-color: var(--primary); }

        .search-filters { display: flex; gap: 12px; width: 100%; }
        @media (min-width: 768px) { .search-filters { width: auto; } }

        .filter-dropdown-wrapper { position: relative; width: 100%; }
        @media (min-width: 768px) { .filter-dropdown-wrapper { width: 180px; } }

        .filter-select {
            width: 100%; appearance: none;
            background-color: var(--surface-container-lowest);
            border: 1px solid var(--outline-variant); border-radius: var(--radius);
            padding: 12px 32px 12px 12px; font-size: 14px;
            color: var(--on-surface); outline: none; cursor: pointer;
        }
        .filter-icon {
            position: absolute; right: 12px; top: 50%; transform: translateY(-50%);
            color: var(--on-surface-variant); font-size: 20px; pointer-events: none;
        }

        /* Results Section */
        .search-results-section { padding: 40px 0; }
        
        .article-grid {
            display: grid; grid-template-columns: 1fr; gap: 24px;
        }
        @media (min-width: 768px) {
            .article-grid { grid-template-columns: repeat(3, 1fr); }
        }

        /* Reusable Card (From Index) */
        .article-card {
            border: 1px solid var(--surface-variant); border-radius: var(--radius);
            background-color: var(--surface-container-lowest); cursor: pointer;
            transition: box-shadow 0.3s ease; display: flex; flex-direction: column;
        }
        .article-card:hover { box-shadow: 0 10px 25px rgba(0,0,0,0.1); }
        
        .card-image-wrapper {
            width: 100%; height: 200px; overflow: hidden; position: relative;
            border-top-left-radius: var(--radius); border-top-right-radius: var(--radius);
        }
        .card-image { width: 100%; height: 100%; object-fit: cover; transition: transform 0.5s ease; }
        .article-card:hover .card-image { transform: scale(1.05); }

        .card-tag-overlay {
            position: absolute; top: 12px; left: 12px;
            background-color: rgba(255, 255, 255, 0.95); padding: 4px 8px; border-radius: var(--radius);
            font-size: 10px; font-weight: 600; text-transform: uppercase; color: var(--on-surface);
        }

        .card-content { padding: 24px; display: flex; flex-direction: column; flex-grow: 1; }
        .card-title { font-family: 'Epilogue', sans-serif; font-size: 20px; font-weight: 600; margin-bottom: 8px; }
        .card-excerpt { font-size: 14px; color: var(--on-surface-variant); line-height: 1.5; }
        .card-meta { margin-top: auto; padding-top: 16px; font-size: 12px; color: var(--outline); }

        /* Pagination */
        .pagination { display: flex; justify-content: center; align-items: center; gap: 8px; margin-top: 48px; }
        .page-btn, .page-num {
            background: none; border: 1px solid var(--outline-variant); color: var(--on-surface-variant);
            padding: 8px 12px; border-radius: var(--radius); transition: all 0.2s ease;
        }
        .page-btn { text-transform: uppercase; font-weight: 600; font-size: 12px; letter-spacing: 0.1em; }
        .page-btn:hover, .page-num:hover { background-color: var(--surface-variant); color: var(--on-surface); }
        .page-num.active { background-color: var(--primary); color: var(--on-primary); border-color: var(--primary); }

        /* Empty State */
        .empty-state-wrapper { display: flex; justify-content: center; margin-bottom: 64px; }
        .empty-card {
            background-color: var(--surface-container-lowest); border: 1px solid var(--surface-variant);
            border-radius: var(--radius-xl); padding: 48px; max-width: 500px; text-align: center;
            display: flex; flex-direction: column; align-items: center;
        }
        .empty-icon-wrapper {
            background-color: var(--surface-container); width: 64px; height: 64px; border-radius: 50%;
            display: flex; align-items: center; justify-content: center; color: var(--on-surface-variant); margin-bottom: 24px;
        }
        .empty-title { font-family: 'Epilogue', sans-serif; font-size: 24px; font-weight: 600; margin-bottom: 12px; }
        .empty-subtitle { color: var(--on-surface-variant); margin-bottom: 24px; }
        
        .btn-solid {
            background-color: var(--primary); color: var(--on-primary); border: none;
            padding: 12px 24px; border-radius: var(--radius); font-weight: 600; text-transform: uppercase;
            font-size: 12px; letter-spacing: 0.1em; display: inline-flex; align-items: center; gap: 8px;
        }

        /* Suggested Paths */
        .suggested-paths-wrapper { text-align: center; }
        .suggested-title { font-family: 'Epilogue', sans-serif; font-size: 24px; font-weight: 600; margin-bottom: 32px; }
        .suggested-card { position: relative; border-radius: var(--radius-xl); overflow: hidden; height: 200px; }
        .suggested-card img { width: 100%; height: 100%; object-fit: cover; transition: transform 0.5s ease; }
        .suggested-card:hover img { transform: scale(1.05); }
        .suggested-overlay {
            position: absolute; inset: 0; background: linear-gradient(to top, rgba(0,0,0,0.8), transparent);
            display: flex; align-items: flex-end; padding: 24px;
        }
        .suggested-overlay h4 { color: #ffffff; font-family: 'Epilogue', sans-serif; font-size: 24px; }
    </style>
</head>

<body class="search-layout">
    <jsp:include page="/WEB-INF/views/includes/header.jsp" />
    
    <main class="search-main">
        <section class="search-header-section">
            <div class="search-container">
                <nav class="breadcrumbs">
                    <a href="<%=request.getContextPath()%>/">Home</a>
                    <span class="material-symbols-outlined breadcrumb-icon">chevron_right</span>
                    <span>Search</span>
                </nav>
                
                <div class="search-headline">
                    <h1 class="search-title">Search Results for: "<%= query %>"</h1>
                    <p class="search-subtitle">Showing <%= hasResults ? "12" : "0" %> journeys found</p>
                </div>
                
                <div class="search-refiner-bar">
                    <form action="<%=request.getContextPath()%>/search" method="GET" class="search-form">
                        <span class="material-symbols-outlined search-input-icon">search</span>
                        <input name="q" class="search-input" placeholder="Search journeys..." type="text" value="<%= query %>" />
                    </form>
                    <div class="search-filters">
                        <div class="filter-dropdown-wrapper">
                            <select class="filter-select">
                                <option>Most Relevant</option>
                                <option>Newest First</option>
                                <option>Most Read</option>
                            </select>
                            <span class="material-symbols-outlined filter-icon">expand_more</span>
                        </div>
                        <div class="filter-dropdown-wrapper">
                            <select class="filter-select">
                                <option>All Authors</option>
                                <option>Sarah Jenkins</option>
                                <option>David Chen</option>
                                <option>Elena Rodriguez</option>
                            </select>
                            <span class="material-symbols-outlined filter-icon">filter_list</span>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        
        <section class="search-results-section">
            <div class="search-container">
                
                <% if (hasResults) { %>
                    <!-- STATE 1: RESULTS FOUND -->
                    <div class="article-grid">
                        <article class="article-card">
                            <div class="card-image-wrapper">
                                <img alt="Kathmandu cityscape" class="card-image" src="https://lh3.googleusercontent.com/aida-public/AB6AXuCVCdiSqEKC_l4pD9kjBBqEUvxjuBn66w4DtQXsqmXxwKzQjtmPsv-n56hDRzN6taylqcFeed8J93MacG3G_fsABCJh5TllzWubz_jsb9T_pcdmn9bPZ8sqcoVlRGnSSZmRLTrXHwrjXAZzA8cK30pulYlq0ZfL3wSUpgC_lvj2kXWvq0-g-xsIv0VZKGiS_Z0-94EXNnH3dRj2UPnSdm8p2gb0HiH0J6noSimzQBBIbVz7SDrjRatKNqVPJHuJ2EBNjrH5UVU_uqw" />
                                <div class="card-tag-overlay">#SlowTravel</div>
                            </div>
                            <div class="card-content">
                                <h2 class="card-title">Finding Stillness in the Chaos of Kathmandu</h2>
                                <p class="card-excerpt">Navigating the labyrinthine streets of Thamel reveals hidden courtyards and ancient stupas that demand a slower pace of exploration.</p>
                                <p class="card-meta">Sarah Jenkins • Oct 12, 2026</p>
                            </div>
                        </article>

                        <article class="article-card">
                            <div class="card-image-wrapper">
                                <img alt="Swayambhunath Stupa" class="card-image" src="https://lh3.googleusercontent.com/aida-public/AB6AXuA0sdQI7FlSqJ2Ezdvy8DlCxmdNW404PLjWgGj3Rw_lbMpOP2XyfQDZMTzo1JampbRGvt4d-elrvgkFc8GaH92GRMb8OXNMA5SRLhdCIAjpJxuc6nCZ9Jg_Rpa-1U7ncv-sI8QivrZw0ZyyOVDj3J57GRjFW12Xxg5izwjPwzeDVYCB7uCppKEt5QWzKP6TK52jYxaapynBYLpMfUkkxP8VMlcnxlEN4OjTiFKYahVsQxbQXTekbtUvsNBZNpT7KX_wMlK5GuMDyBw" />
                                <div class="card-tag-overlay">#Heritage</div>
                            </div>
                            <div class="card-content">
                                <h2 class="card-title">The Monkey Temple: A Kathmandu Sunrise</h2>
                                <p class="card-excerpt">Ascending the 365 steps before dawn offers a rare moment of clarity amidst the spinning prayer wheels and chanting monks.</p>
                                <p class="card-meta">David Chen • Sep 28, 2026</p>
                            </div>
                        </article>

                        <article class="article-card">
                            <div class="card-image-wrapper">
                                <img alt="Digital Nomad Cafe" class="card-image" src="https://lh3.googleusercontent.com/aida-public/AB6AXuDi2caFkp4nmbuM5Dr_iM9GCyVfz1k78KrhERk9_MZRlQHHyr_X9-Z48-tNZLuKNkdvQSPbF5lVcJWKFFEK5bR7JygYhtYzNOSBwS5Ps9-s6T8Av9XsNXDk7pygM8B-1GZZi5q4mT2XaGqHBaGaljR0vi1WZdCn2_pWmY4DsS8d981EqnjREGu5-wKstreiYQronkCE-KZ1ytY_piFolgxfHvSGwbTs9X3KnrjJS7lxLtJgluiVxITnwXwNOudX0f_c7wShA7w3b3M" />
                                <div class="card-tag-overlay">#RemoteWork</div>
                            </div>
                            <div class="card-content">
                                <h2 class="card-title">Working Remotely from Kathmandu: A Guide</h2>
                                <p class="card-excerpt">Overcoming infrastructure challenges to find the perfect blend of productivity and profound cultural immersion in the valley.</p>
                                <p class="card-meta">Elena Rodriguez • Aug 15, 2026</p>
                            </div>
                        </article>
                    </div>

                    <div class="pagination">
                        <button class="page-btn">Previous</button>
                        <button class="page-num active">1</button>
                        <button class="page-num">2</button>
                        <button class="page-num">3</button>
                        <span class="page-dots">...</span>
                        <button class="page-num">10</button>
                        <button class="page-btn">Next</button>
                    </div>

                <% } else { %>
                    <!-- STATE 2: EMPTY RESULTS -->
                    <div class="empty-state-wrapper">
                        <div class="empty-card">
                            <div class="empty-icon-wrapper">
                                <span class="material-symbols-outlined" style="font-size: 28px;">location_off</span>
                            </div>
                            <h2 class="empty-title">Journey Not Found</h2>
                            <p class="empty-subtitle">Sorry, that journey hasn't been written yet. The coordinates for "<%= query %>" remain uncharted in our archives.</p>
                            <a href="<%=request.getContextPath()%>/" class="btn-solid">
                                <span class="material-symbols-outlined" style="font-size: 16px;">home</span>
                                Return to Home
                            </a>
                        </div>
                    </div>

                    <div class="suggested-paths-wrapper">
                        <h3 class="suggested-title">Perhaps explore these paths instead:</h3>
                        <div class="article-grid">
                            <div class="suggested-card">
                                <img src="https://lh3.googleusercontent.com/aida-public/AB6AXuAx0KvZtVOsZeiePSzu3IW7UmdrLENlMC0OFKAKdfmzAOFE363Enj_leN19hImv4ifwFCoSojk2Jb2Hm69Wb6_52yqHhq8UhojRpelj_gPTcD5hn8-eYglCk_3UxR9gnW9ZELHwdxdBaAaW2L-4GwjOruJ2r8nhWNhIlbvG9WlN0AjXAHiXBaP3aQXg5hTMmEAw9ECdHwfUT9EngIGWnDh6ht1q3vT4IlSbamk2KGwPx76VNAkSm8QO8UKAww378qTRAUoMEqv81jw" alt="Trekking" />
                                <div class="suggested-overlay"><h4>Trekking</h4></div>
                            </div>
                            <div class="suggested-card">
                                <img src="https://lh3.googleusercontent.com/aida-public/AB6AXuDG6EfvItlcdTwuTI3nRR1-Lp7u1bmz4J-btTxf86e5edif2q3xaYvD1hM_Q7I8nQDQekdaItcpgx4zykw8XSv2-ed3DsFaWEpbFVjPWLf8hCvfMDrFzaKhgux8SjyslvWSNZl5UoJ-vXWT7Pc76Xm_T_LkFVV9QrwmPCRfA2w08saQmUHeU2gLMnXBmRXAi8x-t6aPM3aFP1GQZ_KFn7uPlrvyXrzSFGoGkWfuviYGAWNblw39KA88SAf_D35ty_do3MZ0HXXDSD0" alt="Solo" />
                                <div class="suggested-overlay"><h4>Solo</h4></div>
                            </div>
                            <div class="suggested-card">
                                <img src="https://lh3.googleusercontent.com/aida-public/AB6AXuCqu4evWJbrSTEqWxv9z3ix6M_VZ0rkxg_r99jSozaDrVHTuuuHVeELv85ZBOnvGbhT4O2_0xM62TUkC_aqwahR23bMrD3kN1pz0MY-GG6XqKaYokvE-HYcmX4p7kS3uuUwsiQoqZxJ-FxdfzwibqFWsO5C4FSIYBcDh_a35SnItm4yqV2wn-RNjXrdqOO8iJrqWFP3HHqFi1kuYuY2327Zb91nFUSdE_zzxOFKw8GpiSettbJO4tofTH3lRD1t9VlNMAGv6cRLi40" alt="Culture" />
                                <div class="suggested-overlay"><h4>Culture</h4></div>
                            </div>
                        </div>
                    </div>
                <% } %>
                
            </div>
        </section>
    </main>
    
    <jsp:include page="/WEB-INF/views/includes/footer.jsp" />
</body>
</html>