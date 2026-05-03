<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>

    <html lang="en">

    <head>
        <meta charset="utf-8" />
        <meta content="width=device-width, initial-scale=1.0" name="viewport" />
        <title>The Silence of the Himalayas: A Guide to the Annapurna Sanctuary - Thoughts of Nomads</title>
        <link
            href="https://fonts.googleapis.com/css2?family=Epilogue:wght@400;600;700&amp;family=Work+Sans:wght@400;600&amp;display=swap"
            rel="stylesheet" />
        <link
            href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap"
            rel="stylesheet" />
        <link
            href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap"
            rel="stylesheet" />
        <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
        <script id="tailwind-config">
            tailwind.config = {
                darkMode: "class",
                theme: {
                    extend: {
                        "colors": {
                            "surface-variant": "#e1e3e4",
                            "surface-container-low": "#f3f4f5",
                            "on-error": "#ffffff",
                            "on-tertiary-fixed-variant": "#643f00",
                            "on-surface-variant": "#45464e",
                            "on-secondary-container": "#731a11",
                            "primary": "#0e193e",
                            "surface-container-lowest": "#ffffff",
                            "on-primary-fixed": "#0e193e",
                            "primary-fixed": "#dce1ff",
                            "on-tertiary-fixed": "#2a1800",
                            "on-secondary-fixed-variant": "#82261b",
                            "error-container": "#ffdad6",
                            "inverse-on-surface": "#f0f1f2",
                            "secondary-fixed": "#ffdad4",
                            "on-surface": "#191c1d",
                            "on-primary-fixed-variant": "#3b456c",
                            "on-background": "#191c1d",
                            "secondary-fixed-dim": "#ffb4a8",
                            "tertiary-fixed": "#ffddb5",
                            "secondary": "#a23d30",
                            "on-tertiary": "#ffffff",
                            "on-error-container": "#93000a",
                            "surface-container": "#edeeef",
                            "on-secondary": "#ffffff",
                            "tertiary-fixed-dim": "#ffb957",
                            "outline-variant": "#c6c5cf",
                            "on-tertiary-container": "#d18900",
                            "on-secondary-fixed": "#410000",
                            "error": "#ba1a1a",
                            "tertiary": "#2a1800",
                            "surface": "#f8f9fa",
                            "surface-dim": "#d9dadb",
                            "primary-fixed-dim": "#bbc4f3",
                            "primary-container": "#242e54",
                            "tertiary-container": "#462b00",
                            "background": "#f8f9fa",
                            "secondary-container": "#fd8270",
                            "outline": "#76767f",
                            "inverse-surface": "#2e3132",
                            "on-primary-container": "#8c96c2",
                            "on-primary": "#ffffff",
                            "surface-container-high": "#e7e8e9",
                            "surface-bright": "#f8f9fa",
                            "surface-tint": "#535c85",
                            "surface-container-highest": "#e1e3e4",
                            "inverse-primary": "#bbc4f3"
                        },
                        "borderRadius": {
                            "DEFAULT": "0.125rem",
                            "lg": "0.25rem",
                            "xl": "0.5rem",
                            "full": "0.75rem"
                        },
                        "spacing": {
                            "section-gap": "80px",
                            "margin-desktop": "48px",
                            "container-max": "1280px",
                            "margin-mobile": "16px",
                            "gutter": "24px",
                            "base": "8px"
                        },
                        "fontFamily": {
                            "display-lg": ["Epilogue"],
                            "body-lg": ["Work Sans"],
                            "headline-lg": ["Epilogue"],
                            "body-md": ["Work Sans"],
                            "label-caps": ["Work Sans"],
                            "headline-md": ["Epilogue"]
                        },
                        "fontSize": {
                            "display-lg": ["48px", { "lineHeight": "1.1", "letterSpacing": "-0.02em", "fontWeight": "700" }],
                            "body-lg": ["18px", { "lineHeight": "1.6", "fontWeight": "400" }],
                            "headline-lg": ["32px", { "lineHeight": "1.2", "fontWeight": "600" }],
                            "body-md": ["16px", { "lineHeight": "1.5", "fontWeight": "400" }],
                            "label-caps": ["12px", { "lineHeight": "1.0", "letterSpacing": "0.1em", "fontWeight": "600" }],
                            "headline-md": ["24px", { "lineHeight": "1.3", "fontWeight": "600" }]
                        }
                    }
                }
            }
        </script>
        <style type="text/tailwindcss">
            @layer utilities {
            .reading-progress-bar {
                position: fixed;
                top: 0;
                left: 0;
                height: 4px;
                background-color: #d18900; /* on-tertiary-container / Mustard equivalent */
                width: 30%; /* Mock progress */
                z-index: 100;
            }
        }
    </style>
    </head>

    <body class="bg-background text-on-background antialiased font-body-md">
        <!-- Reading Progress Bar -->
        <div class="reading-progress-bar"></div>
        <!-- TopNavBar -->
        <jsp:include page="/WEB-INF/views/includes/header.jsp" />
        <!-- Main Content Layout -->
        <main class="max-w-[1280px] mx-auto w-full px-margin-mobile md:px-margin-desktop py-section-gap">
            <div class="grid grid-cols-1 md:grid-cols-12 gap-gutter">
                <!-- Article Canvas (Main Body) -->
                <article class="md:col-span-8 lg:col-span-8 flex flex-col items-center">
                    <!-- Hero Header inside article for better flow if sidebar is present -->
                    <div class="w-full mb-12 relative overflow-hidden rounded">
                        <img alt="A high-impact photograph of a majestic, snow-capped mountain range in the Himalayas. The image features a bright, crisp blue sky contrasting with the harsh, icy peaks. The lighting is strong, casting deep shadows in the crevasses, evoking a sense of awe and the stark reality of high-altitude environments. The style is premium editorial photography, slightly desaturated with high contrast."
                            class="w-full h-[512px] object-cover rounded-lg border border-surface-variant"
                            data-alt="A high-impact photograph of a majestic, snow-capped mountain range in the Himalayas. The image features a bright, crisp blue sky contrasting with the harsh, icy peaks. The lighting is strong, casting deep shadows in the crevasses, evoking a sense of awe and the stark reality of high-altitude environments. The style is premium editorial photography, slightly desaturated with high contrast."
                            src="https://lh3.googleusercontent.com/aida-public/AB6AXuDGwjC4hBUYY8Fluz-be2y2hiJ1h1emSjNgUq7iVyeRydEfrVHNFkeczpuTO23ksfw-da2pYvgaXQsBdFM0r-n309KqGurFBpMstEDseyufNbJ6ybHq5B-5vc9hMvIorHkjgy4AweqU9XQbCEMXT4ya1rAM3tlY_RF_hdmvux7iz8lu-J-cvO0SIxQGl_DMBR5n04MUPrbkh0nRG4UgbR20PK5TR3Z78jyMf48G6muFud6GRxqneT7jDulhSt3zfo5Qqc-ksCjH2pg" />
                        <div
                            class="absolute inset-0 bg-gradient-to-t from-black/60 to-transparent flex flex-col justify-end p-8 rounded-lg">
                            <span
                                class="font-label-caps text-label-caps bg-surface-variant text-on-surface-variant px-3 py-1 rounded inline-block w-max mb-4 shadow-sm border border-outline-variant uppercase">High-Altitude
                                Trekking</span>
                            <h1 class="font-display-lg text-display-lg text-white mb-4">The Silence of the Himalayas: A
                                Guide to the Annapurna Sanctuary</h1>
                        </div>
                    </div>
                    <!-- Article Meta -->
                    <div
                        class="w-full max-w-[800px] flex items-center space-x-4 mb-12 border-b border-surface-variant pb-6 text-on-surface-variant">
                        <img alt="A professional headshot of Sarah Jenkins, a travel writer. She has a warm expression, wearing outdoor gear, with a blurred natural background. The lighting is soft natural daylight. The overall tone is authentic and approachable, fitting for a seasoned explorer profile."
                            class="w-12 h-12 rounded-full object-cover"
                            data-alt="A professional headshot of Sarah Jenkins, a travel writer. She has a warm expression, wearing outdoor gear, with a blurred natural background. The lighting is soft natural daylight. The overall tone is authentic and approachable, fitting for a seasoned explorer profile."
                            src="https://lh3.googleusercontent.com/aida-public/AB6AXuD6VvikodaM4SMNlAPljDzB8fbP6bx4TIobfD9JnTjAP6lTzrpECofcgiczF5__r6JgdNi5G6yqypks-NE5Mzw3w15hGSHS45VykLsSz7eo2bd9_7e8YM6_HvqOryAmpEUd6_9635araoduB-fuzPsVLrYKDqSjO355yOKFvOhHSDdzQjvsZI-dl_VKlnTfrnj3lrLrZ7AK80MDgna2e7nR-WYILbuvLCu9xm6k-UJkg2Eewa9uxHAV45kU1vSpxo4M9daaqSRrwcY" />
                        <div class="flex flex-col">
                            <span class="font-body-md text-body-md font-semibold text-primary-container">Sarah
                                Jenkins</span>
                            <div class="flex items-center text-sm space-x-2">
                                <span>Oct 24, 2024</span>
                                <span class="w-1 h-1 bg-outline rounded-full"></span>
                                <span>12 min read</span>
                            </div>
                        </div>
                    </div>
                    <!-- Main Body Content -->
                    <div
                        class="w-full max-w-[800px] prose prose-lg prose-slate max-w-none font-body-lg text-body-lg text-on-surface">
                        <p class="mb-8">There is a specific kind of silence that exists only above 4,000 meters. It is
                            not an empty silence, but a heavy, expectant one, thick with the history of shifting
                            tectonic plates and the sparse, ragged breath of those who wander here. This is the
                            Annapurna Sanctuary, a high glacial basin nestled like a secret within a ring of colossal
                            Himalayan peaks.</p>
                        <h2 class="font-headline-lg text-headline-lg text-primary-container mt-12 mb-6">The Ascent</h2>
                        <p class="mb-8">The trek begins in the humid, verdant foothills, where rhododendron forests
                            cling to steep hillsides. The trail, uneven and demanding, forces a rhythm upon you—step,
                            breathe, step, breathe. As days blur into one another, the landscape transforms drastically.
                            The lush greenery recedes, replaced by an austere, monochromatic world of rock and ice.</p>
                        <blockquote
                            class="border-l-4 border-on-tertiary-container pl-6 py-2 my-10 italic font-headline-md text-headline-md text-on-surface-variant">
                            "In the mountains, you don't conquer the peak; you conquer yourself. The sanctuary demands
                            respect, and in return, it offers a profound sense of insignificance."
                        </blockquote>
                        <p class="mb-8">Reaching Machapuchare Base Camp is a turning point. The physical toll is
                            undeniable, but the visual reward is staggering. The fishtail peak of Machapuchare,
                            considered sacred and thus unclimbed, dominates the skyline, its sheer face glowing ethereal
                            in the alpenglow.</p>
                        <h2 class="font-headline-lg text-headline-lg text-primary-container mt-12 mb-6">Living with
                            Locals</h2>
                        <p class="mb-8">The tea houses along the route are sparse sanctuaries of warmth. Here, over
                            plates of dal bhat—the staple lentil and rice dish that powers every trekker in
                            Nepal—stories are shared around cast-iron stoves. The Gurung people, native to this region,
                            exude a quiet resilience that mirrors the mountains they call home.</p>
                        <img alt="A high-quality editorial image showing a small, rustic tea house nestled among towering Himalayan peaks. Trekkers are seen resting outside. The image emphasizes the scale of the mountains compared to human structures. The lighting is crisp afternoon sun, creating deep shadows. The color palette features cool slate grays and muted earth tones."
                            class="w-full rounded mb-8 border border-surface-variant shadow-sm"
                            data-alt="A high-quality editorial image showing a small, rustic tea house nestled among towering Himalayan peaks. Trekkers are seen resting outside. The image emphasizes the scale of the mountains compared to human structures. The lighting is crisp afternoon sun, creating deep shadows. The color palette features cool slate grays and muted earth tones."
                            src="https://lh3.googleusercontent.com/aida-public/AB6AXuBP8zIxcl6sGbxgJR0Mgpr3OalHIQC6OimOcoCLQC8ep1An-dc62r9Ry04cgibbKlBvLVQOEH_dwha5BF_FOFI0Mbc7Soc2uSajRMUJRkYEm1VHsEOkNGVm2EDYs8BAV_62k9jiFWdYYSWhd3WudBfXFSpaJW-TnT14qInw-NJ1WGVLJ3N1DdFZAgK2FPrjuDL3cpJU1irmgGUJGek5qtvVbQbPjlIZemssyrphJB6N3acBRHjBS1cxA1qxHihdbtnM8z3YaFBlqxM" />
                        <h2 class="font-headline-lg text-headline-lg text-primary-container mt-12 mb-6">Final Thoughts
                        </h2>
                        <p class="mb-8">Entering the sanctuary itself is a humbling experience. Standing surrounded by
                            360 degrees of soaring peaks—Annapurna I, Annapurna South, Hiunchuli—you realize the silence
                            isn't an absence of sound, but the overwhelming presence of nature in its rawest form. It is
                            a journey that breaks you down only to build you back up, stronger and more aware.</p>
                    </div>
                    <!-- Author Bio Box -->
                    <div
                        class="w-full max-w-[800px] mt-16 p-8 bg-surface border border-outline-variant rounded flex flex-col md:flex-row items-center md:items-start gap-6">
                        <img alt="A professional headshot of Sarah Jenkins, a travel writer. She has a warm expression, wearing outdoor gear, with a blurred natural background. The lighting is soft natural daylight. The overall tone is authentic and approachable, fitting for a seasoned explorer profile."
                            class="w-24 h-24 rounded-full object-cover border-2 border-primary-container"
                            data-alt="A professional headshot of Sarah Jenkins, a travel writer. She has a warm expression, wearing outdoor gear, with a blurred natural background. The lighting is soft natural daylight. The overall tone is authentic and approachable, fitting for a seasoned explorer profile."
                            src="https://lh3.googleusercontent.com/aida-public/AB6AXuBinIDseli6Na_I3o5JsukKM1p98SyoIZn1K72WN52I4O-g5EYZfxPAeD6GSGvgPQEhqyRmvYDzi_w2zCTEWJdH5BfgjOtqXawwCApDmSS6HIvEq-xLQXds6gG4aDChFU9zEXDRUMyEs4dE_DDRpxmRm-0OBxAh3NQR4IbXSC3y1Uh4c4GDMdA_rNvhy9FOZQZsnWgybGgsvTvvsQ2wLwAjdIAXQ5e00mi7v3hxXLOh3Dr_dMO3iogVyZ4eCpNFhEAxe3vjpEHV5VY" />
                        <div>
                            <h3 class="font-headline-md text-headline-md text-primary-container mb-2"><a
                                    class="hover:underline" href="#">Sarah Jenkins</a></h3>
                            <p class="font-body-md text-body-md text-on-surface-variant mb-4">Sarah Jenkins is a
                                seasoned explorer with over a decade of experience traversing remote mountain ranges.
                                Her writing focuses on the intersection of human endurance and pristine natural
                                environments. When not on the trail, she advocates for sustainable tourism in fragile
                                alpine ecosystems.</p>
                            <div class="flex gap-3">
                                <a class="text-on-surface-variant hover:text-primary-container transition-colors"
                                    href="#">
                                    <span class="material-symbols-outlined text-xl">camera_alt</span>
                                    <!-- Placeholder for IG -->
                                </a>
                                <a class="text-on-surface-variant hover:text-primary-container transition-colors"
                                    href="#">
                                    <span class="material-symbols-outlined text-xl">chat_bubble</span>
                                    <!-- Placeholder for Twitter -->
                                </a>
                            </div>
                        </div>
                    </div>
                    <!-- Tags -->
                    <div class="w-full max-w-[800px] mt-8 flex flex-wrap gap-2">
                        <span
                            class="bg-surface-variant text-on-surface-variant font-label-caps text-label-caps px-3 py-1 rounded hover:bg-surface-container-high transition-colors cursor-pointer border border-outline-variant">#Nepal</span>
                        <span
                            class="bg-surface-variant text-on-surface-variant font-label-caps text-label-caps px-3 py-1 rounded hover:bg-surface-container-high transition-colors cursor-pointer border border-outline-variant">#Annapurna</span>
                        <span
                            class="bg-surface-variant text-on-surface-variant font-label-caps text-label-caps px-3 py-1 rounded hover:bg-surface-container-high transition-colors cursor-pointer border border-outline-variant">#Trekking</span>
                        <span
                            class="bg-surface-variant text-on-surface-variant font-label-caps text-label-caps px-3 py-1 rounded hover:bg-surface-container-high transition-colors cursor-pointer border border-outline-variant">#Solukhumbu</span>
                    </div>
                </article>
                <!-- Sidebar (Desktop) -->
                <aside class="hidden md:block md:col-span-4 lg:col-span-4">
                    <div class="sticky top-28 space-y-8">
                        <!-- Search Bar -->
                        <div class="bg-surface p-6 border border-outline-variant rounded">
                            <div class="relative group">
                                <span
                                    class="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-outline group-focus-within:text-primary-container transition-colors">search</span>
                                <input
                                    class="w-full bg-white border border-outline-variant rounded py-2 pl-10 pr-4 text-body-md focus:outline-none focus:border-primary-container focus:ring-1 focus:ring-primary-container transition-all"
                                    placeholder="Search stories..." type="text" />
                            </div>
                        </div>
                        <!-- Table of Contents -->
                        <div class="bg-surface p-6 border border-outline-variant rounded">
                            <h4 class="font-headline-md text-headline-md text-primary-container mb-4">Contents</h4>
                            <ul class="space-y-3 font-body-md text-on-surface-variant">
                                <li><a class="hover:text-primary-container hover:underline transition-all"
                                        href="#">Introduction</a></li>
                                <li><a class="hover:text-primary-container hover:underline transition-all" href="#">The
                                        Ascent</a></li>
                                <li><a class="hover:text-primary-container hover:underline transition-all"
                                        href="#">Living with Locals</a></li>
                                <li><a class="hover:text-primary-container hover:underline transition-all"
                                        href="#">Final Thoughts</a></li>
                            </ul>
                        </div>
                        <!-- Newsletter Box -->
                        <div class="bg-primary-container p-6 rounded text-white text-center">
                            <span class="material-symbols-outlined text-4xl mb-4 text-on-tertiary-container">mail</span>
                            <h4 class="font-headline-md text-headline-md mb-2">Join the Tribe</h4>
                            <p class="font-body-md text-primary-fixed-dim mb-6 text-sm">Get editorial dispatches from
                                the world's remote corners delivered to your inbox.</p>
                            <input
                                class="w-full bg-white border border-outline-variant rounded py-2 px-4 text-body-md text-on-surface mb-4 focus:outline-none focus:border-on-tertiary-container"
                                placeholder="Your email address" type="email" />
                            <button
                                class="w-full font-label-caps text-label-caps bg-surface text-primary-container py-3 rounded hover:bg-surface-variant transition-colors uppercase">Subscribe</button>
                        </div>
                    </div>
                </aside>
            </div>
        </main>
        <!-- Next Journeys Section -->
        <section
            class="max-w-[1280px] mx-auto w-full px-margin-mobile md:px-margin-desktop py-16 border-t border-outline-variant">
            <h3 class="font-headline-lg text-headline-lg text-primary-container mb-8">Related Adventures</h3>
            <div class="grid grid-cols-1 md:grid-cols-3 gap-gutter">
                <!-- Card 1 -->
                <div
                    class="flex flex-col border border-outline-variant rounded bg-surface hover:shadow-[0px_4px_20px_rgba(36,46,84,0.05)] transition-shadow duration-300 overflow-hidden group cursor-pointer">
                    <div class="relative h-48 overflow-hidden">
                        <img alt="A vast, arid desert landscape under a clear blue sky. A lone traveler is walking along a ridge. The lighting is golden hour, casting long shadows and highlighting the textures of the sand and rock. The aesthetic is minimal and vast, emphasizing isolation and scale."
                            class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500"
                            data-alt="A vast, arid desert landscape under a clear blue sky. A lone traveler is walking along a ridge. The lighting is golden hour, casting long shadows and highlighting the textures of the sand and rock. The aesthetic is minimal and vast, emphasizing isolation and scale."
                            src="https://lh3.googleusercontent.com/aida-public/AB6AXuDg-i9Spsi8Q3uKBLC1x2Ek2gVG6waLl3ju_nlDbCmAq1dmI46qOP9PabenS8sRmsjWX3QO8MGXuyEay_4ozFId7tNbp_QtYN9l0vsRfWzRo5SJWWWDIRVO_5l8003u2r_wPT4Qj_h4E17Z7MEbB35_N_OxpfNuPchRr29eEnQMv1cZEuwnfnbeO2WF7aGRU3ksOczBxl7JTE_YqQaJaPrlyLCVFrjBEtIWIuYWkbtLY9v3XFDzdZKb0SxMIeoCMm4lF27znm6JPzc" />
                    </div>
                    <div class="p-6 flex flex-col flex-grow">
                        <span class="font-label-caps text-label-caps text-on-tertiary-container mb-2 uppercase">Desert
                            Exploration</span>
                        <h4
                            class="font-headline-md text-headline-md text-primary-container mb-3 group-hover:text-on-tertiary-container transition-colors">
                            Crossing the Atacama: Silence and Salt</h4>
                        <p class="font-body-md text-on-surface-variant text-sm line-clamp-3">A journey through the
                            driest place on earth reveals hidden lagoons, bizarre rock formations, and a profound sense
                            of isolation.</p>
                    </div>
                </div>
                <!-- Card 2 -->
                <div
                    class="flex flex-col border border-outline-variant rounded bg-surface hover:shadow-[0px_4px_20px_rgba(36,46,84,0.05)] transition-shadow duration-300 overflow-hidden group cursor-pointer">
                    <div class="relative h-48 overflow-hidden">
                        <img alt="A dramatic shot of a deep, winding canyon carved by a river. The rock walls are sheer and textured. The lighting is moody and overcast, emphasizing the raw geological power of the landscape. The colors are muted earth tones, slate blues, and grays."
                            class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500"
                            data-alt="A dramatic shot of a deep, winding canyon carved by a river. The rock walls are sheer and textured. The lighting is moody and overcast, emphasizing the raw geological power of the landscape. The colors are muted earth tones, slate blues, and grays."
                            src="https://lh3.googleusercontent.com/aida-public/AB6AXuAFcncABmIMSr2VLoZ9dZK4PC8aTi0yqvhDDk1yojPFqmDcnkYLyLARilIanlGvbz98I9uzXryec3nhSVHTsJn3DFgj8KkD5N3dxnFpJXIUhw1yy1z0KD4Pe3a6qeHKf9_OlKF43xor5LUZZ6K_DFAdDsEOfeJ9TEmCw0MYbtl0ABO7vvJxw6J0CPeMqBxjajhPqb5gmJoxJ8LbKaOyRB_GpxmVrWB_KM-MYXe1HZ5FB1qK_gtCtQpWVXUeq51FCvIO5z5j5wfbeTA" />
                    </div>
                    <div class="p-6 flex flex-col flex-grow">
                        <span class="font-label-caps text-label-caps text-on-tertiary-container mb-2 uppercase">Canyon
                            Trekking</span>
                        <h4
                            class="font-headline-md text-headline-md text-primary-container mb-3 group-hover:text-on-tertiary-container transition-colors">
                            Navigating the Narrows: Zion's Heart</h4>
                        <p class="font-body-md text-on-surface-variant text-sm line-clamp-3">Wading through slot canyons
                            carved over millennia, understanding the flow of water and stone in America's rugged
                            southwest.</p>
                    </div>
                </div>
                <!-- Card 3 -->
                <div
                    class="flex flex-col border border-outline-variant rounded bg-surface hover:shadow-[0px_4px_20px_rgba(36,46,84,0.05)] transition-shadow duration-300 overflow-hidden group cursor-pointer">
                    <div class="relative h-48 overflow-hidden">
                        <img alt="A high-altitude mountain lake reflecting the surrounding jagged peaks. The water is deep, vibrant blue. The scene is pristine and untouched, with patches of snow on the rocky shores. The style is crisp, high-contrast landscape photography highlighting the cold, clean air."
                            class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500"
                            data-alt="A high-altitude mountain lake reflecting the surrounding jagged peaks. The water is deep, vibrant blue. The scene is pristine and untouched, with patches of snow on the rocky shores. The style is crisp, high-contrast landscape photography highlighting the cold, clean air."
                            src="https://lh3.googleusercontent.com/aida-public/AB6AXuARvAntndvl8q5OTeHgrbXbHHFXX4-T12nIa3-FfEB5k4gVfWiknoUwBi0FvOwtgOAEgHRLxfzMHiQlwnW-Pk7F-701ugovayTAN802qca0lcl5rfrbaihVVp-M5HkXCP08dPf5Q1oNnCeKdCW6XHjNpaaDkJEg8Iq2PKBBFd9jihft_Prj2tgZyNX5bCfulxWrpeS-RfsLmBPN0Vci9gL8No2Ks_FNlXEO2jCy4EyOvZXLY5rkN0-KG4lykEL-8ySubRoOd8twcq4" />
                    </div>
                    <div class="p-6 flex flex-col flex-grow">
                        <span class="font-label-caps text-label-caps text-on-tertiary-container mb-2 uppercase">Alpine
                            Lakes</span>
                        <h4
                            class="font-headline-md text-headline-md text-primary-container mb-3 group-hover:text-on-tertiary-container transition-colors">
                            Mirrors of the Sky: Patagonia's Hidden Tarns</h4>
                        <p class="font-body-md text-on-surface-variant text-sm line-clamp-3">Discovering glacial lakes
                            perched precariously beneath the sheer granite spires of the Fitz Roy massif.</p>
                    </div>
                </div>
            </div>
        </section>
        <!-- Footer -->
        <jsp:include page="/WEB-INF/views/includes/footer.jsp" />
    </body>

    </html>