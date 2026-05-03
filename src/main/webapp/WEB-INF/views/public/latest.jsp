<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>

    <html class="light" lang="en">

    <head>
        <meta charset="utf-8" />
        <meta content="width=device-width, initial-scale=1.0" name="viewport" />
        <title>Latest Journeys - Thoughts of Nomads</title>
        <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
        <link
            href="https://fonts.googleapis.com/css2?family=Epilogue:wght@400;600;700;800&amp;family=Work+Sans:wght@400;500;600;700&amp;display=swap"
            rel="stylesheet" />
        <link
            href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap"
            rel="stylesheet" />
        <link
            href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap"
            rel="stylesheet" />
        <script id="tailwind-config">
            tailwind.config = {
                darkMode: "class",
                theme: {
                    extend: {
                        "colors": {
                            "secondary-fixed-dim": "#ffb4a8",
                            "on-secondary-fixed-variant": "#82261b",
                            "on-secondary-container": "#731a11",
                            "tertiary": "#2a1800",
                            "surface-container-highest": "#e1e3e4",
                            "surface-container-high": "#e7e8e9",
                            "on-surface": "#191c1d",
                            "on-tertiary-fixed": "#2a1800",
                            "on-error": "#ffffff",
                            "on-tertiary-fixed-variant": "#643f00",
                            "surface-container": "#edeeef",
                            "secondary-fixed": "#ffdad4",
                            "inverse-on-surface": "#f0f1f2",
                            "surface-tint": "#535c85",
                            "primary-container": "#242e54",
                            "primary-fixed": "#dce1ff",
                            "on-secondary": "#ffffff",
                            "on-primary-container": "#8c96c2",
                            "on-error-container": "#93000a",
                            "on-background": "#191c1d",
                            "tertiary-fixed-dim": "#ffb957",
                            "outline": "#76767f",
                            "primary-fixed-dim": "#bbc4f3",
                            "on-tertiary-container": "#d18900",
                            "on-primary-fixed-variant": "#3b456c",
                            "on-primary": "#ffffff",
                            "on-surface-variant": "#45464e",
                            "surface-dim": "#d9dadb",
                            "outline-variant": "#c6c5cf",
                            "surface": "#f8f9fa",
                            "tertiary-container": "#462b00",
                            "secondary": "#a23d30",
                            "surface-container-lowest": "#ffffff",
                            "secondary-container": "#fd8270",
                            "background": "#f8f9fa",
                            "error": "#ba1a1a",
                            "on-tertiary": "#ffffff",
                            "on-primary-fixed": "#0e193e",
                            "inverse-surface": "#2e3132",
                            "surface-container-low": "#f3f4f5",
                            "on-secondary-fixed": "#410000",
                            "inverse-primary": "#bbc4f3",
                            "surface-variant": "#e1e3e4",
                            "primary": "#0e193e",
                            "tertiary-fixed": "#ffddb5",
                            "surface-bright": "#f8f9fa",
                            "error-container": "#ffdad6"
                        },
                        "borderRadius": {
                            "DEFAULT": "0.125rem",
                            "lg": "0.25rem",
                            "xl": "0.5rem",
                            "full": "0.75rem"
                        },
                        "spacing": {
                            "margin-mobile": "16px",
                            "margin-desktop": "48px",
                            "base": "8px",
                            "gutter": "24px",
                            "section-gap": "80px",
                            "container-max": "1280px"
                        },
                        "fontFamily": {
                            "headline-lg": ["Epilogue"],
                            "label-caps": ["Work Sans"],
                            "body-md": ["Work Sans"],
                            "body-lg": ["Work Sans"],
                            "display-lg": ["Epilogue"],
                            "headline-md": ["Epilogue"]
                        },
                        "fontSize": {
                            "headline-lg": ["32px", { "lineHeight": "1.2", "fontWeight": "600" }],
                            "label-caps": ["12px", { "lineHeight": "1.0", "letterSpacing": "0.1em", "fontWeight": "600" }],
                            "body-md": ["16px", { "lineHeight": "1.5", "fontWeight": "400" }],
                            "body-lg": ["18px", { "lineHeight": "1.6", "fontWeight": "400" }],
                            "display-lg": ["48px", { "lineHeight": "1.1", "letterSpacing": "-0.02em", "fontWeight": "700" }],
                            "headline-md": ["24px", { "lineHeight": "1.3", "fontWeight": "600" }]
                        }
                    }
                }
            }
        </script>
        <style>
            .material-symbols-outlined {
                font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
            }

            .material-symbols-outlined.fill {
                font-variation-settings: 'FILL' 1;
            }
        </style>
    </head>

    <body
        class="bg-background text-on-background font-body-md text-body-md antialiased selection:bg-primary-container selection:text-on-primary-container">
        <!-- TopNavBar -->
        <jsp:include page="/WEB-INF/views/includes/header.jsp" />
        <main class="max-w-[1280px] mx-auto px-margin-mobile md:px-margin-desktop py-12 md:py-section-gap">
            <!-- Header Section -->
            <header class="mb-12">
                <div
                    class="flex items-center gap-2 font-label-caps text-label-caps text-on-surface-variant uppercase mb-4">
                    <a class="hover:text-primary transition-colors" href="<%=request.getContextPath()%>/">Home</a>
                    <span class="material-symbols-outlined text-[14px]">chevron_right</span>
                    <span class="text-primary">Latest</span>
                </div>
                <h1 class="font-display-lg text-display-lg text-on-background mb-8">LATEST JOURNEYS</h1>
                <div
                    class="flex flex-col md:flex-row justify-between items-start md:items-center gap-6 border-b border-surface-variant pb-6">
                    <div class="flex flex-wrap gap-2">
                        <button
                            class="px-5 py-2 bg-primary-container text-white font-label-caps text-label-caps rounded-full hover:opacity-90 transition-opacity">All</button>
                        <button
                            class="px-5 py-2 bg-surface text-on-surface border border-outline-variant font-label-caps text-label-caps rounded-full hover:bg-surface-container transition-colors">Trekking</button>
                        <button
                            class="px-5 py-2 bg-surface text-on-surface border border-outline-variant font-label-caps text-label-caps rounded-full hover:bg-surface-container transition-colors">Solo</button>
                        <button
                            class="px-5 py-2 bg-surface text-on-surface border border-outline-variant font-label-caps text-label-caps rounded-full hover:bg-surface-container transition-colors">Culture</button>
                        <button
                            class="px-5 py-2 bg-surface text-on-surface border border-outline-variant font-label-caps text-label-caps rounded-full hover:bg-surface-container transition-colors">Food</button>
                    </div>
                    <div class="flex items-center gap-2">
                        <span class="font-label-caps text-label-caps text-on-surface-variant">Sort By:</span>
                        <select
                            class="bg-surface border border-outline-variant rounded px-3 py-1 font-body-md text-body-md text-on-surface focus:border-primary-container focus:ring-0">
                            <option>Newest First</option>
                            <option>Most Popular</option>
                            <option>Reading Time</option>
                        </select>
                    </div>
                </div>
            </header>
            <!-- Featured Card Hero -->
            <section class="mb-section-gap">
                <div
                    class="grid grid-cols-1 lg:grid-cols-12 gap-gutter bg-surface-container-lowest rounded-xl border border-surface-variant overflow-hidden shadow-sm hover:shadow-md transition-shadow duration-300">
                    <div class="lg:col-span-7 h-[400px] lg:h-[500px]">
                        <img alt="Featured Journey" class="w-full h-full object-cover"
                            data-alt="A breathtaking landscape view of a lone hiker standing on a rocky outcrop overlooking a vast, misty mountain valley during early morning. The scene is shot with a slightly desaturated, high-contrast premium editorial style, emphasizing the majestic scale of nature. Soft, cool morning light filters through the clouds, creating a sense of quiet adventure and discovery suitable for a modern nomad lifestyle brand."
                            src="https://lh3.googleusercontent.com/aida-public/AB6AXuByW-uh7u867KvN0ZazyvvKV1OnxeDFwQazELire-rp4FDNGGnr7lKtMsPknpx_LDL2uFxnjv2ORICVlxr53-pfuMSWGFCG6gpDfNg3uwcghFn1hXu6KpH1TlUfAjj0NdMlC8TnQaxIswzyp7VwTlj-AaUCRgYqtNqGW18KfhscL-x7lIQIpwPYIlfVCW9SnptXag8pK1mMP6NjWlZmC4NVgbN4wKWk4qK93DcyjdpL5zuIxd4GNlQYK6HVnAq7L7dGBJ31Kj9U2pw" />
                    </div>
                    <div class="lg:col-span-5 flex flex-col justify-center p-8 lg:p-12">
                        <div class="flex items-center gap-3 mb-6">
                            <span
                                class="inline-block px-3 py-1 bg-tertiary-fixed-dim text-tertiary-container font-label-caps text-label-caps rounded uppercase">JUST
                                PUBLISHED</span>
                            <span class="font-label-caps text-label-caps text-on-surface-variant uppercase">NEPAL</span>
                        </div>
                        <h2 class="font-headline-lg text-headline-lg text-on-background mb-4">The Silent Peaks: A Month
                            in the Annapurna Sanctuary</h2>
                        <p class="font-body-lg text-body-lg text-on-surface-variant mb-8 line-clamp-3">Beyond the
                            teahouses and the popular trails lies a quiet rhythm to the Himalayas. We spent thirty days
                            exploring the lesser-known ridges and valleys, documenting the stark beauty and resilient
                            culture of high-altitude life.</p>
                        <div class="flex items-center justify-between mb-8">
                            <div class="flex items-center gap-3">
                                <img alt="Author" class="w-10 h-10 rounded-full object-cover grayscale"
                                    data-alt="A small, circular black and white portrait of a female travel writer with a slight, confident smile. The image is cropped tightly, emphasizing professional credibility within a premium editorial design system."
                                    src="https://lh3.googleusercontent.com/aida-public/AB6AXuB8786p5Bw6lWHBnNtY1D45SFi5goF-YTTuqLYmHxbV10hAAdVLVYDfobh_CNFRAY6R3Ur4s0DFoIXUBa40PDxubWUfpNtNE8dHJZlFFX-wq88Hhc7O0wYG8SQhu9lFUwcMzQn__RumIrTucGmZ4MQ_1fFQhH0vtjjijQ9YsAtMeiik-XpXTaOigfOvfCj0HUacSVk9NKK67vc0PPB_5A42QN5rlK6YhA7y66fpPEeNq_Db-YZ-XpMnVFSBkmBGeBi-kGkk4IGY-RE" />
                                <div>
                                    <p class="font-label-caps text-label-caps text-on-background">SARAH JENKINS</p>
                                    <p class="font-body-md text-body-md text-on-surface-variant text-sm">Oct 24, 2024 •
                                        12 min read</p>
                                </div>
                            </div>
                        </div>
                        <button
                            class="bg-primary-container text-white font-label-caps text-label-caps uppercase px-8 py-4 rounded hover:bg-primary transition-colors w-full md:w-auto text-center">Read
                            Full Journey</button>
                    </div>
                </div>
            </section>
            <!-- Main Content Area -->
            <div class="grid grid-cols-1 lg:grid-cols-12 gap-gutter">
                <!-- Articles Grid -->
                <div class="lg:col-span-8">
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-gutter mb-12">
                        <!-- Article Card 1 -->
                        <article
                            class="flex flex-col bg-surface-container-lowest rounded-lg border border-surface-variant overflow-hidden group hover:shadow-[0px_4px_20px_rgba(36,46,84,0.05)] transition-all duration-300">
                            <div class="h-[250px] overflow-hidden relative">
                                <img alt="Japan Journey"
                                    class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500"
                                    data-alt="A minimalist architectural shot of an ancient temple structure in Kyoto, Japan, captured with a slightly desaturated color palette. The composition is clean and structured, with strong leading lines and soft, diffused light, evoking a sense of disciplined exploration typical of high-end travel editorial photography."
                                    src="https://lh3.googleusercontent.com/aida-public/AB6AXuCRFR8CnNWQmQP8raEvwblulaiCv_uT0dnbNzer4WMDXHR2aZ0XWB0_gQYKxWileJ-wY97S3DM5kIfR8K17gV73TExDMQDei256WkTOH8FXyrK3cqX5fyzhH3MGGmyOZdFgQcZUX5w6HuC3GLL-kjfehFhSbB3ZF3SFqs7vD9_XBvbUVCpGE5Zmc0RCzBdhBQOC7-ULPpCgJvtp56z6_f3znEgwKZ0F97MYQ5EHaK0Mp95OOyYPMix4D0dlP0me9MBwnZbBIhdkoOM" />
                            </div>
                            <div class="p-6 flex-1 flex flex-col">
                                <span
                                    class="inline-block px-2 py-1 bg-surface-container text-on-surface font-label-caps text-[10px] rounded uppercase self-start mb-3">JAPAN</span>
                                <h3
                                    class="font-headline-md text-[20px] leading-[1.3] font-semibold text-on-background mb-3 group-hover:text-primary-container transition-colors">
                                    Finding Stillness in the Heart of Kyoto</h3>
                                <p class="font-body-md text-body-md text-on-surface-variant line-clamp-2 mb-6 flex-1">
                                    Navigating the ancient capital's hidden gardens and quiet alleys, discovering a
                                    slow-travel approach to one of the world's most visited cities.</p>
                                <div class="flex items-center gap-3 mt-auto pt-4 border-t border-surface-variant">
                                    <img alt="Author" class="w-8 h-8 rounded-full object-cover grayscale"
                                        data-alt="Small circular headshot of a male author with a beard, styled in a muted, professional editorial tone."
                                        src="https://lh3.googleusercontent.com/aida-public/AB6AXuCPNWN12d7-g4T-A5fdNqWQp2wIdLnoVMJTXGcPMoVjwPUZ6jGbrPzpGqz2jiHH-HMbPoiBQYxQM3xgPwgucg4WgwKY5fnTwFtul_f2GI9cZCGItqUNCg5XAH9yJFd8xDHNkkgEtJaaNvHlqAdkGWe2WDNy6cyN5UlJPNKh5kYEgg1rMvExlcEKqIxO5dcCWO63Q4HGm5XS4_4DmS25cXxKVcXN07xycgFZGvSZG2GIQLOm5PorUyhXkQWVYk_dlRNm7VP34wroLew" />
                                    <p class="font-label-caps text-label-caps text-on-surface-variant text-[10px]">MARK
                                        DAVIS • 8 MIN READ</p>
                                </div>
                            </div>
                        </article>
                        <!-- Article Card 2 -->
                        <article
                            class="flex flex-col bg-surface-container-lowest rounded-lg border border-surface-variant overflow-hidden group hover:shadow-[0px_4px_20px_rgba(36,46,84,0.05)] transition-all duration-300">
                            <div class="h-[250px] overflow-hidden relative">
                                <img alt="Patagonia Journey"
                                    class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500"
                                    data-alt="A wide, sweeping shot of rugged coastal cliffs meeting a dark, turbulent ocean. The image features a cool, subdued color grading with high contrast between the dark rocks and white surf, representing a raw, untamed landscape suited for a serious nomad travel brand."
                                    src="https://lh3.googleusercontent.com/aida-public/AB6AXuBbmrXRZkfptHc_ql-QXjiSc605oSUNmlY9-nczMvFHUppNsGf8pFT0KAvi2pv6cwY_NLUsej4qRIDUqEX3gPL8OdwN-ACOwfpGrxBMnFMiZ3-5A1-QOmRvxqAXclU8B8r7SIh6-_3Jkqz6kgUQhUXfPd6I1Fh-M-xKKx9WWml7qTACg88iz4L1Kciib4dXVkcvm5VOSf_bBnAfCLkt33PI3gEcK0t_UGApewodwrE743r6qViS733HDjRvWD4uOPyqZYfmahIfk5Y" />
                            </div>
                            <div class="p-6 flex-1 flex flex-col">
                                <span
                                    class="inline-block px-2 py-1 bg-surface-container text-on-surface font-label-caps text-[10px] rounded uppercase self-start mb-3">PATAGONIA</span>
                                <h3
                                    class="font-headline-md text-[20px] leading-[1.3] font-semibold text-on-background mb-3 group-hover:text-primary-container transition-colors">
                                    The End of the Earth: A Guide to the W Trek</h3>
                                <p class="font-body-md text-body-md text-on-surface-variant line-clamp-2 mb-6 flex-1">
                                    Practical advice and philosophical musings from five days walking through the
                                    howling winds and dramatic granite spires of southern Chile.</p>
                                <div class="flex items-center gap-3 mt-auto pt-4 border-t border-surface-variant">
                                    <img alt="Author" class="w-8 h-8 rounded-full object-cover grayscale"
                                        data-alt="Small circular headshot of a female author, styled in a muted, professional editorial tone."
                                        src="https://lh3.googleusercontent.com/aida-public/AB6AXuCd_25i-T4FN0i7giy34MIQlkvmn2qYiAlm_twt8UIMbLTsymQJnRkuSkxhj6QAlqGom6BjbrwQwTRgFXAdgsDaVSSFv8msxgm3V5wxBVC-or0oEpdXF7BO9_BqWbipQVmW9h_pMV9JGJcWP0TIrAYCPNVNm1P5_CRIxnkaBNnck1JKrfX-y-X4I9jvegtkscnM1ARzGkFEkm7RjrHHxPiFG4EckobBMwxzCN8rHc-FfONE0e76-WOSb4bemsSKlsKV98Yp_-P20x0" />
                                    <p class="font-label-caps text-label-caps text-on-surface-variant text-[10px]">ELENA
                                        RUIZ • 15 MIN READ</p>
                                </div>
                            </div>
                        </article>
                        <!-- Article Card 3 -->
                        <article
                            class="flex flex-col bg-surface-container-lowest rounded-lg border border-surface-variant overflow-hidden group hover:shadow-[0px_4px_20px_rgba(36,46,84,0.05)] transition-all duration-300">
                            <div class="h-[250px] overflow-hidden relative">
                                <img alt="Morocco Journey"
                                    class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500"
                                    data-alt="A vibrant but tastefully desaturated street photography scene of a bustling market alley in Marrakech. The focus is on the intricate textures of hanging rugs and lanterns, lit by sharp shafts of sunlight piercing through an overhead awning, creating a rich, structured editorial aesthetic."
                                    src="https://lh3.googleusercontent.com/aida-public/AB6AXuDcDUaVDpLKoy-x1RZZyq0HisVUfnpZ5UTfWbytDqWlE_SLh7Afghc9vmI2qtSXsmz_YWv22ku0tQX-fuTxdcJpFSFTuVJYl_QRk2luUx9hTGttNNM_6SMT8kSjXDwDWFXy68V3rZFhH9tjAm-84WqNQ3i_kbSjibkYruehcHUdUv8YFDoGuF6EddvUcXxhDs_MTOThbZnb7YKYeDAIEzHgyyAnKQSPPmDYbRNyi8HeGpJVimRBrtSfls86bCZeLV3HESOUyYdmQGc" />
                            </div>
                            <div class="p-6 flex-1 flex flex-col">
                                <span
                                    class="inline-block px-2 py-1 bg-surface-container text-on-surface font-label-caps text-[10px] rounded uppercase self-start mb-3">MOROCCO</span>
                                <h3
                                    class="font-headline-md text-[20px] leading-[1.3] font-semibold text-on-background mb-3 group-hover:text-primary-container transition-colors">
                                    Navigating the Medina: Sensory Overload in Marrakech</h3>
                                <p class="font-body-md text-body-md text-on-surface-variant line-clamp-2 mb-6 flex-1">
                                    Embracing the chaos and discovering hidden courtyards of tranquility within the
                                    labyrinthine walls of the old city.</p>
                                <div class="flex items-center gap-3 mt-auto pt-4 border-t border-surface-variant">
                                    <img alt="Author" class="w-8 h-8 rounded-full object-cover grayscale"
                                        data-alt="Small circular headshot of a male author, styled in a muted, professional editorial tone."
                                        src="https://lh3.googleusercontent.com/aida-public/AB6AXuCCHH_2SDAS-ZtuRUbN8OoXZOgZSFN8bcPYpOC9R3U0NlDGiWd1Js0CEBSqKYeYbMbrJSAcJqa6QKX6M6l59VHQOu5vJpPQgD5JsTl2YvMorIVlJZLcg6ZkEkHCNUQexwjGFVieQpIcoSPD4SfAR-AkB4MJPLvHLi9lqGCaz77p8tKk6FZwrHbTR4ageY1oKeOax1Euo6-IwveYHjeMlWPOVOTVc8VtPa-UiF6wNZwupcuRGWjfcKf2QS7GrbytJRXNKtZKQgLWH_c" />
                                    <p class="font-label-caps text-label-caps text-on-surface-variant text-[10px]">JAMES
                                        WONG • 10 MIN READ</p>
                                </div>
                            </div>
                        </article>
                        <!-- Article Card 4 -->
                        <article
                            class="flex flex-col bg-surface-container-lowest rounded-lg border border-surface-variant overflow-hidden group hover:shadow-[0px_4px_20px_rgba(36,46,84,0.05)] transition-all duration-300">
                            <div class="h-[250px] overflow-hidden relative">
                                <img alt="Norway Journey"
                                    class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500"
                                    data-alt="A serene, high-contrast shot of a solitary wooden boat on a perfectly still, deep blue alpine lake surrounded by dark pine forests. The image uses a minimalist composition and cool color palette, reflecting a disciplined, premium visual style focused on solitude and exploration."
                                    src="https://lh3.googleusercontent.com/aida-public/AB6AXuCBnWgSUk4Ddoh4tyLb6m02s1zZheWFNQW71BmTMTEK3WZLW9ulZ3dZlgvZdOATtApl10szE0-8mywPu8OvKZctrrXs-eciKJjvrJdv8bq7HJH3_1fJTsr-yEZx2A0JM7xjh6JG1vzZpmwKb_ecPOJEtKyGqBvrTpIEBKDkx6HY1Klhn9gHMxh-Ej-B7KYMZupTrPXe2f4HSr_IU-tqIpeoWHjhXkorkEBysniVLc3dCMbFaEVN7pf_lfqAS9HtUcPe5qercAV1aro" />
                            </div>
                            <div class="p-6 flex-1 flex flex-col">
                                <span
                                    class="inline-block px-2 py-1 bg-surface-container text-on-surface font-label-caps text-[10px] rounded uppercase self-start mb-3">NORWAY</span>
                                <h3
                                    class="font-headline-md text-[20px] leading-[1.3] font-semibold text-on-background mb-3 group-hover:text-primary-container transition-colors">
                                    Arctic Solitude: Cabin Life in the Lofoten Islands</h3>
                                <p class="font-body-md text-body-md text-on-surface-variant line-clamp-2 mb-6 flex-1">A
                                    winter retreat exploring remote fjords, deep darkness, and the pursuit of creative
                                    focus in extreme environments.</p>
                                <div class="flex items-center gap-3 mt-auto pt-4 border-t border-surface-variant">
                                    <img alt="Author" class="w-8 h-8 rounded-full object-cover grayscale"
                                        data-alt="Small circular headshot of a female author, styled in a muted, professional editorial tone."
                                        src="https://lh3.googleusercontent.com/aida-public/AB6AXuCQBiVGJVhLL4LvDhnzaDMgsqZ9DxuOncUYJWS2XVaMzLAF7mFOm-oK6-SbadbZ-uPZqePLru0CUF3phwS-oLsuVDYRcZtza2uHjUC3CP98sELGjKCzXhwS9hy_nR9MxLIE7NUU3WlnNnt6xajdBjEJCNqiFpQKFX4vwOGL7qL06M5QvviLWOJogHEP3EmQ33WYgZP_tvC0y-EMlJYg2oTz8mh3WzcUSHEHeDAkskiRoZtWdsxTOnnJqagZI_kq1F51ikRS035UG6o" />
                                    <p class="font-label-caps text-label-caps text-on-surface-variant text-[10px]">SARAH
                                        JENKINS • 11 MIN READ</p>
                                </div>
                            </div>
                        </article>
                    </div>
                    <!-- Pagination -->
                    <div class="flex justify-center items-center gap-2 mt-12 pt-8 border-t border-surface-variant">
                        <button
                            class="px-4 py-2 text-on-surface-variant hover:text-primary font-label-caps text-label-caps transition-colors flex items-center gap-1">
                            <span class="material-symbols-outlined text-[16px]">chevron_left</span> Previous
                        </button>
                        <div class="flex gap-1">
                            <button
                                class="w-10 h-10 rounded bg-primary-container text-white font-label-caps text-label-caps flex items-center justify-center">1</button>
                            <button
                                class="w-10 h-10 rounded bg-surface hover:bg-surface-container text-on-surface border border-transparent hover:border-outline-variant font-label-caps text-label-caps flex items-center justify-center transition-all">2</button>
                            <button
                                class="w-10 h-10 rounded bg-surface hover:bg-surface-container text-on-surface border border-transparent hover:border-outline-variant font-label-caps text-label-caps flex items-center justify-center transition-all">3</button>
                            <span class="w-10 h-10 flex items-center justify-center text-on-surface-variant">...</span>
                            <button
                                class="w-10 h-10 rounded bg-surface hover:bg-surface-container text-on-surface border border-transparent hover:border-outline-variant font-label-caps text-label-caps flex items-center justify-center transition-all">10</button>
                        </div>
                        <button
                            class="px-4 py-2 text-on-surface-variant hover:text-primary font-label-caps text-label-caps transition-colors flex items-center gap-1">
                            Next <span class="material-symbols-outlined text-[16px]">chevron_right</span>
                        </button>
                    </div>
                </div>
                <!-- Sticky Sidebar -->
                <aside class="lg:col-span-4 space-y-8">
                    <div class="sticky top-[100px]">
                        <!-- Search Widget -->
                        <div class="bg-surface-container-lowest p-6 rounded-lg border border-surface-variant mb-8">
                            <h3 class="font-headline-md text-[18px] text-on-background mb-4">Search Archive</h3>
                            <div class="relative">
                                <span
                                    class="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-outline">search</span>
                                <input
                                    class="w-full bg-surface border border-outline-variant rounded pl-10 pr-4 py-2 font-body-md text-body-md text-on-surface focus:border-primary-container focus:ring-1 focus:ring-primary-container outline-none transition-all"
                                    placeholder="Keywords, destinations..." type="text" />
                            </div>
                        </div>
                        <!-- Trending Tags Widget -->
                        <div class="bg-surface-container-lowest p-6 rounded-lg border border-surface-variant mb-8">
                            <h3 class="font-headline-md text-[18px] text-on-background mb-4">Trending Explorations</h3>
                            <div class="flex flex-wrap gap-2">
                                <a class="px-3 py-1.5 bg-surface-container-low hover:bg-surface-container text-on-surface-variant font-label-caps text-[11px] rounded transition-colors"
                                    href="#">#Everest</a>
                                <a class="px-3 py-1.5 bg-surface-container-low hover:bg-surface-container text-on-surface-variant font-label-caps text-[11px] rounded transition-colors"
                                    href="#">#NomadLife</a>
                                <a class="px-3 py-1.5 bg-surface-container-low hover:bg-surface-container text-on-surface-variant font-label-caps text-[11px] rounded transition-colors"
                                    href="#">#BudgetTrek</a>
                                <a class="px-3 py-1.5 bg-surface-container-low hover:bg-surface-container text-on-surface-variant font-label-caps text-[11px] rounded transition-colors"
                                    href="#">#SlowTravel</a>
                                <a class="px-3 py-1.5 bg-surface-container-low hover:bg-surface-container text-on-surface-variant font-label-caps text-[11px] rounded transition-colors"
                                    href="#">#RemoteWork</a>
                                <a class="px-3 py-1.5 bg-surface-container-low hover:bg-surface-container text-on-surface-variant font-label-caps text-[11px] rounded transition-colors"
                                    href="#">#VanLife</a>
                            </div>
                        </div>
                        <!-- Newsletter Card -->
                        <div
                            class="bg-primary-container text-white p-8 rounded-lg text-center relative overflow-hidden shadow-lg">
                            <!-- Abstract Background Element -->
                            <div
                                class="absolute -top-12 -right-12 w-32 h-32 bg-primary-fixed-dim/20 rounded-full blur-xl">
                            </div>
                            <div class="absolute -bottom-12 -left-12 w-32 h-32 bg-primary/40 rounded-full blur-xl">
                            </div>
                            <div class="relative z-10">
                                <span
                                    class="material-symbols-outlined text-[32px] mb-4 text-tertiary-fixed-dim">mail</span>
                                <h3 class="font-headline-md text-[22px] mb-2">Join the Tribe</h3>
                                <p class="font-body-md text-[14px] text-primary-fixed mb-6">Dispatches from the road,
                                    editorial insights, and exclusive guides delivered monthly.</p>
                                <input
                                    class="w-full bg-white/10 border border-white/20 rounded px-4 py-2 mb-3 font-body-md text-white placeholder-white/50 focus:border-white outline-none"
                                    placeholder="Your email address" type="email" />
                                <button
                                    class="w-full bg-tertiary-fixed-dim text-tertiary-container font-label-caps text-label-caps uppercase py-3 rounded hover:bg-tertiary-fixed transition-colors">Subscribe</button>
                            </div>
                        </div>
                    </div>
                </aside>
            </div>
        </main>
        <!-- Footer -->
        <jsp:include page="/WEB-INF/views/includes/footer.jsp" />
    </body>

    </html>