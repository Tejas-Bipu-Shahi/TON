<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <title>High-Altitude Trekking - Thoughts of Nomads</title>
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Epilogue:wght@400;600;700&family=Work+Sans:wght@400;600&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet" />

    <style>
        /* ============================================================
           CSS VARIABLES (Design Tokens) & RESETS
           ============================================================ */
        :root {
            --primary: #0e193e;
            --on-primary: #ffffff;
            --surface: #ffffff;
            --surface-container-lowest: #ffffff;
            --surface-container: #f3f4f5;
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
           CATEGORY LAYOUT
           ============================================================ */
        .category-layout {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }
        .category-main {
            flex-grow: 1;
            max-width: var(--container-max);
            margin: 0 auto;
            width: 100%;
            padding: 48px var(--margin-mobile);
            display: flex;
            flex-direction: column;
            gap: 48px;
        }
        @media (min-width: 768px) {
            .category-main { padding: 48px var(--margin-desktop); }
        }

        /* ============================================================
           HEADER & BREADCRUMBS
           ============================================================ */
        .category-header { display: flex; flex-direction: column; gap: 16px; }
        .breadcrumbs {
            display: flex; align-items: center; gap: 8px;
            font-size: 12px; color: var(--on-surface-variant);
        }
        .breadcrumb-link:hover { color: var(--primary); text-decoration: underline; }
        .breadcrumb-icon { font-size: 14px; }
        .breadcrumb-current { color: var(--on-surface); font-weight: 600; }
        
        .category-title {
            font-family: 'Epilogue', sans-serif;
            font-size: 32px; font-weight: 600; color: var(--primary);
            margin-bottom: 8px;
        }
        .category-subtitle { font-size: 16px; color: var(--on-surface-variant); }

        /* ============================================================
           REFINER BAR (Search & Sort)
           ============================================================ */
        .category-refiner-bar {
            display: flex; flex-direction: column; gap: 16px;
            background-color: var(--surface-container-lowest);
            padding: 12px; border: 1px solid var(--outline-variant);
            border-radius: var(--radius);
        }
        @media (min-width: 768px) {
            .category-refiner-bar { flex-direction: row; align-items: center; justify-content: space-between; }
        }

        .category-search-wrapper { position: relative; width: 100%; }
        @media (min-width: 768px) { .category-search-wrapper { width: 350px; } }
        
        .search-icon {
            position: absolute; left: 12px; top: 50%; transform: translateY(-50%);
            color: var(--outline); font-size: 18px;
        }
        .category-search-input {
            width: 100%; padding: 10px 12px 10px 40px;
            border: 1px solid var(--outline-variant); border-radius: var(--radius);
            background-color: var(--surface-container-lowest);
            font-family: 'Work Sans', sans-serif; font-size: 14px; outline: none;
            transition: border-color 0.2s ease;
        }
        .category-search-input:focus { border-color: var(--primary); }

        .category-filters { display: flex; gap: 12px; width: 100%; }
        @media (min-width: 768px) { .category-filters { width: auto; } }

        .filter-wrapper { position: relative; width: 100%; }
        @media (min-width: 768px) { .filter-wrapper { width: 180px; } }

        .filter-select {
            width: 100%; appearance: none; cursor: pointer;
            background-color: var(--surface-container-lowest);
            border: 1px solid var(--outline-variant); border-radius: var(--radius);
            padding: 10px 32px 10px 12px; font-family: 'Work Sans', sans-serif;
            font-size: 14px; color: var(--on-surface); outline: none;
        }
        .filter-icon {
            position: absolute; right: 12px; top: 50%; transform: translateY(-50%);
            color: var(--outline); font-size: 18px; pointer-events: none;
        }

        /* ============================================================
           RESULTS GRID & CARDS
           ============================================================ */
        .category-grid {
            display: grid; grid-template-columns: 1fr; gap: 24px;
        }
        @media (min-width: 640px) { .category-grid { grid-template-columns: repeat(2, 1fr); } }
        @media (min-width: 1024px) { .category-grid { grid-template-columns: repeat(4, 1fr); } }

        .standard-card {
            border: 1px solid var(--surface-variant); border-radius: var(--radius);
            background-color: var(--surface-container-lowest); cursor: pointer;
            display: flex; flex-direction: column; overflow: hidden;
            transition: box-shadow 0.3s ease;
        }
        .standard-card:hover { box-shadow: 0 10px 25px rgba(0,0,0,0.08); }

        .card-img-wrapper { width: 100%; height: 200px; overflow: hidden; }
        .card-img { width: 100%; height: 100%; object-fit: cover; transition: transform 0.5s ease; }
        .standard-card:hover .card-img { transform: scale(1.05); }

        .card-content { padding: 24px; display: flex; flex-direction: column; flex-grow: 1; }
        
        .card-category-tag {
            align-self: flex-start; background-color: var(--surface-container);
            color: var(--on-surface); padding: 4px 8px; border-radius: var(--radius);
            font-size: 10px; font-weight: 600; letter-spacing: 0.1em; margin-bottom: 16px;
        }
        
        .card-title {
            font-family: 'Epilogue', sans-serif; font-size: 18px; font-weight: 600;
            color: var(--on-surface); margin-bottom: 8px; line-height: 1.3;
        }
        
        .card-excerpt {
            font-size: 14px; color: var(--on-surface-variant); margin-bottom: 24px;
            line-height: 1.5; display: -webkit-box; -webkit-line-clamp: 3; -webkit-box-orient: vertical; overflow: hidden;
        }

        .card-footer {
            margin-top: auto; padding-top: 16px; border-top: 1px solid var(--surface-variant);
            display: flex; align-items: center; gap: 12px;
        }
        
        .card-author-avatar { width: 32px; height: 32px; border-radius: 50%; object-fit: cover; }
        .card-author-info { display: flex; flex-direction: column; }
        .card-author-name { font-size: 12px; font-weight: 600; color: var(--on-surface); }
        .card-meta { font-size: 12px; color: var(--on-surface-variant); }

        /* ============================================================
           PAGINATION
           ============================================================ */
        .pagination { display: flex; justify-content: center; align-items: center; gap: 8px; margin-top: 16px; }
        .pagination-btn, .page-number {
            border: 1px solid var(--outline-variant); color: var(--on-surface-variant);
            width: 36px; height: 36px; border-radius: var(--radius); display: flex;
            align-items: center; justify-content: center; font-size: 14px; transition: all 0.2s ease;
        }
        .pagination-btn:hover:not(.disabled), .page-number:hover {
            background-color: var(--surface-variant); color: var(--on-surface);
        }
        .page-number.active { background-color: var(--primary); color: var(--on-primary); border-color: var(--primary); font-weight: 600;}
        .pagination-icon { font-size: 18px; }
        .pagination-btn.disabled { opacity: 0.5; cursor: not-allowed; }
        .page-dots { color: var(--on-surface-variant); padding: 0 4px; }
    </style>
</head>

<body class="category-layout">
    <jsp:include page="/WEB-INF/views/includes/header.jsp" />
    
    <main class="category-main">
        <!-- Header Section -->
        <section class="category-header">
            <nav aria-label="Breadcrumb" class="breadcrumbs">
                <a class="breadcrumb-link" href="<%=request.getContextPath()%>/">Home</a>
                <span class="material-symbols-outlined breadcrumb-icon">chevron_right</span>
                <a class="breadcrumb-link" href="<%=request.getContextPath()%>/category">Categories</a>
                <span class="material-symbols-outlined breadcrumb-icon">chevron_right</span>
                <span class="breadcrumb-current">Trekking</span>
            </nav>
            <div class="category-headline">
                <h1 class="category-title">Exploring: High-Altitude Trekking</h1>
                <p class="category-subtitle">Showing 12 journeys found in this category.</p>
            </div>
        </section>
        
        <!-- Refiner Bar -->
        <section class="category-refiner-bar">
            <div class="category-search-wrapper">
                <span class="material-symbols-outlined search-icon">search</span>
                <input class="category-search-input" placeholder="Search trekking routes..." type="text"/>
            </div>
            <div class="category-filters">
                <div class="filter-wrapper">
                    <select class="filter-select">
                        <option>Sort By: Newest</option>
                        <option>Sort By: Popular</option>
                        <option>Sort By: Difficulty</option>
                    </select>
                    <span class="material-symbols-outlined filter-icon">expand_more</span>
                </div>
                <div class="filter-wrapper">
                    <select class="filter-select">
                        <option>Author: All</option>
                        <option>Elena Rostova</option>
                        <option>Marcus Chen</option>
                    </select>
                    <span class="material-symbols-outlined filter-icon">expand_more</span>
                </div>
            </div>
        </section>
        
        <!-- Results Grid -->
        <section class="category-results-section">
            <div class="category-grid">
                <!-- Card 1 -->
                <article class="standard-card">
                    <div class="card-img-wrapper">
                        <img alt="Mountain Peak" class="card-img" src="https://lh3.googleusercontent.com/aida-public/AB6AXuAqZW4EPym-BrQ1VePHJS0yHpD_OIDcVXGZDq6jSwa5Cq65HVdiJ0A7yabuvafG59GAWkylOdaWlYddw2RBqFflzlgzJXQypvvx1a5jSMGFtqAKgZyPltMXWYcIroJVrFukSKm_qWyFVApXYeRI-0zJY0nQqIq59tazM11EBYvWrojqK-4dMX9ezyA_1jEaMcsPAmjC7FRUt5Rj4RXujRtuTLatZsgEnVtJo9ywM9J60IB5F35X-zMT1QDgz-apbrIadb5Kg7Vf-kk"/>
                    </div>
                    <div class="card-content">
                        <span class="card-category-tag">TREKKING</span>
                        <h2 class="card-title">The Silence of the Annapurna Circuit</h2>
                        <p class="card-excerpt">A fourteen-day journey through changing climates, ancient monasteries, and the sheer scale of the Himalayas.</p>
                        <div class="card-footer">
                            <img alt="Author" class="card-author-avatar" src="https://lh3.googleusercontent.com/aida-public/AB6AXuBwVkPSyvFyVFz3KO53Tn37Ci_k7rwoOzsdvriJ04hWPzMDd0dJYjPoDVZuw5MfdttEmfZkoExKc0V29qLJJIPxMMkurADsB8mxYSs6YPQcQYG9AOwq09mcuuD3SnQ8QWRpuqKK1NZSnFF4VFi8XNvMLxCTGjIhS2g3MjJvHop4oWpxx-nL3CoLQEx4m7saE7_aCTsk8xDTIYsmXHpuEs0J-cz1jigKTRtdippvQnuKlzwlf4zURdPdGjL1m1GeZaj_HbAshlGLQkI"/>
                            <div class="card-author-info">
                                <span class="card-author-name">Elena Rostova</span>
                                <span class="card-meta">Oct 12, 2026</span>
                            </div>
                        </div>
                    </div>
                </article>
                
                <!-- Card 2 -->
                <article class="standard-card">
                    <div class="card-img-wrapper">
                        <img alt="Hikers on trail" class="card-img" src="https://lh3.googleusercontent.com/aida-public/AB6AXuDgC0RSiVRmYRr7G9r4O0V5DnUIKWy2BnMXHG0IYZgFjEUcVa0s9s1h4Mwl-d-BVvoE7dbil4dvfuxPp4wneIoLSvm1HlA7cfgKpHsiONSELZhPVysUpnQ8zQ1IaeDJQg01_DmOoCUEZwjZu8QZTxot0TfW3WW78QUgMHfFb4fPLX-GBIve3mqmeyt6FefLlHHPZzsagIaD0PYoB-Q1R4Rt53Yvd0xndrmrysJvPFLqvCNx7YgDalE6Pg4oMcxhUHNTRS5aOP3jGmE"/>
                    </div>
                    <div class="card-content">
                        <span class="card-category-tag">TREKKING</span>
                        <h2 class="card-title">Navigating the Torres del Paine</h2>
                        <p class="card-excerpt">Wind, rain, and unexpected clarity at the end of the world in Patagonia's most demanding circuit.</p>
                        <div class="card-footer">
                            <img alt="Author" class="card-author-avatar" src="https://lh3.googleusercontent.com/aida-public/AB6AXuCL_ewb1DxEPxTQFXFoEx7IBvSDzKav-YIlV0qQ2ZIo81Zzg50mEzt7VmF-DSvtXV-CgS9AtJAvJ75XR3Nju-LZovvOI-6DsNtUzn7eX8LLp1sh41vx5fUeDjPB7jnW5Ver-GgOnFwZoxNJrJES4_1C-uITwuqtNmk88vVttLyngO-kWOsHkkKa8nS4iWrOCdHsbo4XvM1PbCdTkTNHNo5qOiPof7QimHrbI1zFL6Mq-9tbpcjOmRPChxL9ZIoLdhBk4MAv_zr7Wek"/>
                            <div class="card-author-info">
                                <span class="card-author-name">Marcus Chen</span>
                                <span class="card-meta">Nov 04, 2026</span>
                            </div>
                        </div>
                    </div>
                </article>
                
                <!-- Card 3 -->
                <article class="standard-card">
                    <div class="card-img-wrapper">
                        <img alt="Alpine Lake" class="card-img" src="https://lh3.googleusercontent.com/aida-public/AB6AXuDdLTgnCl40Eu4LeCK1g2lP4CWtfF-qd00R1hxWtxuFxHJdfhuBVgfIMISFnuZOZ3BLfScy1JOkuUjZo6qmf9U55OVQMKyYovtvtGgPhVnuT6WvyYfM6-RuBbtBChgAO8tS29kiAX483ltGxhx-gwTPncsb8Y6HUZccz4TS3Txxw5bgVWv9rTsZfum9y892idKBe6E9b3rtCXzgV7hj19Neu8d3soWqOzJGSI_Rnwhhe5Z7z1xKo-uvHHmsWmwVbWtsD1kpxDWPhkw"/>
                    </div>
                    <div class="card-content">
                        <span class="card-category-tag">TREKKING</span>
                        <h2 class="card-title">The Hidden Lakes of the Karakoram</h2>
                        <p class="card-excerpt">Finding isolation and impossible colors above 4,000 meters in one of the world's least forgiving ranges.</p>
                        <div class="card-footer">
                            <img alt="Author" class="card-author-avatar" src="https://lh3.googleusercontent.com/aida-public/AB6AXuAL-wvf5VCZDn0Gb_zSOkWH8tHR2CaHniHTMmXJPpA-E4XeJrRaAD4eQdTA4t41o-e24_88UvOD80uJklsXupuoUFFmcS6lNdXVDdi6QDAMM1YDFJw08stvaNsU-JsfuvBNV_EWPn1T94Zt6m0z2fRosoUWjhRZr0w7hnmwvSz7YNusu87UXSHJw1FmF3LZg8uL_eQlOVO1qZ2fBcxkPpyKKq66IWhRTwauqCSZdmdPVKvpvPyEDBLodA6L58UM4DAErWFdjatWz_c"/>
                            <div class="card-author-info">
                                <span class="card-author-name">Sarah Jenkins</span>
                                <span class="card-meta">Dec 18, 2026</span>
                            </div>
                        </div>
                    </div>
                </article>
                
                <!-- Card 4 -->
                <article class="standard-card">
                    <div class="card-img-wrapper">
                        <img alt="Snowy ridge" class="card-img" src="https://lh3.googleusercontent.com/aida-public/AB6AXuDgSYRIC-pj6AGe0-xYJpdDFJnhSsvl8eoBMSf1YcLQIufGuuaYPdZb8nG0RVT2zc7OXiZgFWzwgpFPQ0NVZADA0TCjbGAOD6RukQngA__aI4wbINXbWBzm1a9OzWTYrzqB1mCWY8BMqF7Yu0YvOQdTbpSvAmF93MhVs7jawkg19cdrCy61-MAvP-TwEV8vwACIg9XxN3jDuFlp890svyXxcVBX52XnCe8VBMVjTfTt2fG2b1AQlYYGRH-mVWpCBMHB55isolpnQeo"/>
                    </div>
                    <div class="card-content">
                        <span class="card-category-tag">TREKKING</span>
                        <h2 class="card-title">Ridge Walking the Swiss Alps</h2>
                        <p class="card-excerpt">Balancing on the edge of Europe, where the views are as sharp as the drop-offs.</p>
                        <div class="card-footer">
                            <img alt="Author" class="card-author-avatar" src="https://lh3.googleusercontent.com/aida-public/AB6AXuA9hJhH1T582rlWgj1Rkm_EwKfDU6s4HdqfPf625sSUoy6B9-EggbSOMqsMx6kn-uyHl2ZXOxlXQJbIwrlrmrKW32GP7qf5wBNHw8bjb3BfHVznub_cnSEnefXZh7aeA9lbdjj7qil-b5yAvKUs8cEexdQLXJ9ZjEH5O9DY2iiHV4G75xxNFreduBjIaz25PYjVfPQXBU7M9nAWpEBpIExNKthhf7Oa8L7i3N9DF1L9bltwqPdW6tOucqyUk0BQ4r3MS9Wh_hFSdfg"/>
                            <div class="card-author-info">
                                <span class="card-author-name">Elena Rostova</span>
                                <span class="card-meta">Jan 05, 2026</span>
                            </div>
                        </div>
                    </div>
                </article>
            </div>
            
            <!-- Pagination -->
            <div class="pagination">
                <button class="pagination-btn disabled"><span class="material-symbols-outlined pagination-icon">chevron_left</span></button>
                <div class="pagination-numbers" style="display: flex; gap: 8px;">
                    <button class="page-number active">1</button>
                    <button class="page-number">2</button>
                    <button class="page-number">3</button>
                    <span class="page-dots">...</span>
                </div>
                <button class="pagination-btn"><span class="material-symbols-outlined pagination-icon">chevron_right</span></button>
            </div>
        </section>
    </main>
    
    <jsp:include page="/WEB-INF/views/includes/footer.jsp" />
</body>
</html>