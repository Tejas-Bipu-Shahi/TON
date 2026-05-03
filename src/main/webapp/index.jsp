<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
        <!DOCTYPE html>

        <html class="light" lang="en">

        <head>
                <meta charset="utf-8" />
                <meta content="width=device-width, initial-scale=1.0" name="viewport" />
                <title>Thoughts of Nomads</title>
                <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
                <link href="https://fonts.googleapis.com" rel="preconnect" />
                <link crossorigin="" href="https://fonts.gstatic.com" rel="preconnect" />
                <link href="https://fonts.googleapis.com/css2?family=Epilogue:wght@400;600;700&amp;family=Work+Sans:wght@400;600&amp;display=swap"
                        rel="stylesheet" />
                <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap"
                        rel="stylesheet" />
                <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap"
                        rel="stylesheet" />
                <script id="tailwind-config">
                        tailwind.config = {
                                darkMode: "class",
                                theme: {
                                        extend: {
                                                "colors": {
                                                        "outline": "#76767f",
                                                        "secondary-container": "#fd8270",
                                                        "on-primary-container": "#8c96c2",
                                                        "inverse-surface": "#2e3132",
                                                        "background": "#f8f9fa",
                                                        "tertiary-container": "#462b00",
                                                        "surface-bright": "#f8f9fa",
                                                        "surface-container-high": "#e7e8e9",
                                                        "inverse-primary": "#bbc4f3",
                                                        "surface-tint": "#535c85",
                                                        "surface-container-highest": "#e1e3e4",
                                                        "on-primary": "#ffffff",
                                                        "tertiary": "#2a1800",
                                                        "error": "#ba1a1a",
                                                        "primary-container": "#242e54",
                                                        "surface-dim": "#d9dadb",
                                                        "surface": "#f8f9fa",
                                                        "primary-fixed-dim": "#bbc4f3",
                                                        "on-error-container": "#93000a",
                                                        "on-tertiary": "#ffffff",
                                                        "secondary": "#a23d30",
                                                        "tertiary-fixed": "#ffddb5",
                                                        "secondary-fixed-dim": "#ffb4a8",
                                                        "on-primary-fixed-variant": "#3b456c",
                                                        "on-background": "#191c1d",
                                                        "outline-variant": "#c6c5cf",
                                                        "on-tertiary-container": "#d18900",
                                                        "on-secondary-fixed": "#410000",
                                                        "tertiary-fixed-dim": "#ffb957",
                                                        "surface-container": "#edeeef",
                                                        "on-secondary": "#ffffff",
                                                        "on-secondary-container": "#731a11",
                                                        "on-surface-variant": "#45464e",
                                                        "on-tertiary-fixed-variant": "#643f00",
                                                        "primary": "#0e193e",
                                                        "surface-variant": "#e1e3e4",
                                                        "surface-container-low": "#f3f4f5",
                                                        "on-error": "#ffffff",
                                                        "error-container": "#ffdad6",
                                                        "on-secondary-fixed-variant": "#82261b",
                                                        "on-surface": "#191c1d",
                                                        "secondary-fixed": "#ffdad4",
                                                        "inverse-on-surface": "#f0f1f2",
                                                        "surface-container-lowest": "#ffffff",
                                                        "on-primary-fixed": "#0e193e",
                                                        "primary-fixed": "#dce1ff",
                                                        "on-tertiary-fixed": "#2a1800"
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
                                                        "headline-md": [
                                                                "Epilogue"
                                                        ],
                                                        "label-caps": [
                                                                "Work Sans"
                                                        ],
                                                        "body-md": [
                                                                "Work Sans"
                                                        ],
                                                        "headline-lg": [
                                                                "Epilogue"
                                                        ],
                                                        "body-lg": [
                                                                "Work Sans"
                                                        ],
                                                        "display-lg": [
                                                                "Epilogue"
                                                        ]
                                                },
                                                "fontSize": {
                                                        "headline-md": [
                                                                "24px",
                                                                {
                                                                        "lineHeight": "1.3",
                                                                        "fontWeight": "600"
                                                                }
                                                        ],
                                                        "label-caps": [
                                                                "12px",
                                                                {
                                                                        "lineHeight": "1.0",
                                                                        "letterSpacing": "0.1em",
                                                                        "fontWeight": "600"
                                                                }
                                                        ],
                                                        "body-md": [
                                                                "16px",
                                                                {
                                                                        "lineHeight": "1.5",
                                                                        "fontWeight": "400"
                                                                }
                                                        ],
                                                        "headline-lg": [
                                                                "32px",
                                                                {
                                                                        "lineHeight": "1.2",
                                                                        "fontWeight": "600"
                                                                }
                                                        ],
                                                        "body-lg": [
                                                                "18px",
                                                                {
                                                                        "lineHeight": "1.6",
                                                                        "fontWeight": "400"
                                                                }
                                                        ],
                                                        "display-lg": [
                                                                "48px",
                                                                {
                                                                        "lineHeight": "1.1",
                                                                        "letterSpacing": "-0.02em",
                                                                        "fontWeight": "700"
                                                                }
                                                        ]
                                                }
                                        },
                                },
                        }
                </script>
                <style>
                        .material-symbols-outlined {
                                font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
                        }
                </style>
        </head>

        <body class="bg-background text-on-background antialiased font-body-md text-body-md">
                <!-- TopNavBar -->
                <jsp:include page="/WEB-INF/views/includes/header.jsp" />
                <!-- Hero Section -->
                <header class="relative w-full h-[819px] flex items-center justify-start bg-surface-container-highest">
                        <div class="absolute inset-0 z-0">
                                <img alt="" class="w-full h-full object-cover object-center"
                                        data-alt="A breathtaking landscape of a rugged mountain pass viewed from a classic road trip vehicle. The scene is bathed in the golden light of early morning, casting long shadows across the valley. The sky is clear, pale blue, contrasting with the dark greens and earthy browns of the terrain. The mood is adventurous, inspiring, and vast, perfectly suiting a premium editorial travel brand."
                                        src="https://lh3.googleusercontent.com/aida-public/AB6AXuAx0KvZtVOsZeiePSzu3IW7UmdrLENlMC0OFKAKdfmzAOFE363Enj_leN19hImv4ifwFCoSojk2Jb2Hm69Wb6_52yqHhq8UhojRpelj_gPTcD5hn8-eYglCk_3UxR9gnW9ZELHwdxdBaAaW2L-4GwjOruJ2r8nhWNhIlbvG9WlN0AjXAHiXBaP3aQXg5hTMmEAw9ECdHwfUT9EngIGWnDh6ht1q3vT4IlSbamk2KGwPx76VNAkSm8QO8UKAww378qTRAUoMEqv81jw" />
                                <div class="absolute inset-0 bg-primary/40 mix-blend-multiply"></div>
                        </div>
                        <div
                                class="relative z-10 w-full max-w-container-max mx-auto px-margin-mobile md:px-margin-desktop">
                                <div class="max-w-2xl">
                                        <h1 class="font-display-lg text-display-lg text-on-primary mb-base">Your Next
                                                Adventure Awaits</h1>
                                        <form action="<%=request.getContextPath()%>/search" method="GET" class="mt-8 bg-surface p-2 rounded flex items-center shadow-sm">
                                                <span
                                                        class="material-symbols-outlined text-outline ml-2 mr-3">search</span>
                                                <input class="w-full bg-transparent border-none focus:ring-0 text-on-surface font-body-md text-body-md placeholder-outline-variant p-2"
                                                        placeholder="Where to next?" type="text" name="q" />
                                        </form>
                                        <p
                                                class="font-label-caps text-label-caps text-surface-container mt-2 opacity-80 uppercase tracking-widest">
                                                Search by destination, author, or category</p>
                                </div>
                        </div>
                </header>
                <!-- Top Picks Section -->
                <section
                        class="w-full max-w-container-max mx-auto px-margin-mobile md:px-margin-desktop py-section-gap">
                        <h2 class="font-headline-lg text-headline-lg text-on-surface mb-gutter">Top Picks</h2>
                        <div class="grid grid-cols-1 md:grid-cols-3 gap-gutter">
                                <!-- Card 1 -->
                                <article
                                        class="group cursor-pointer border border-surface-variant rounded bg-surface hover:shadow-lg transition-shadow duration-300">
                                        <div class="w-full h-64 overflow-hidden rounded-t">
                                                <img alt=""
                                                        class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500"
                                                        data-alt="A solitary hiker trekking across a vast, stark desert landscape towards distant mountains under a bright, high-contrast sun. The colors are muted, focusing on earthy terracotta and dusty blues, emphasizing the professional editorial minimalism of the design. The lighting is harsh yet beautiful, highlighting the isolation and scale of the journey."
                                                        src="https://lh3.googleusercontent.com/aida-public/AB6AXuDG6EfvItlcdTwuTI3nRR1-Lp7u1bmz4J-btTxf86e5edif2q3xaYvD1hM_Q7I8nQDQekdaItcpgx4zykw8XSv2-ed3DsFaWEpbFVjPWLf8hCvfMDrFzaKhgux8SjyslvWSNZl5UoJ-vXWT7Pc76Xm_T_LkFVV9QrwmPCRfA2w08saQmUHeU2gLMnXBmRXAi8x-t6aPM3aFP1GQZ_KFn7uPlrvyXrzSFGoGkWfuviYGAWNblw39KA88SAf_D35ty_do3MZ0HXXDSD0" />
                                        </div>
                                        <div class="p-6">
                                                <span
                                                        class="inline-block bg-surface-container px-2 py-1 mb-3 rounded font-label-caps text-label-caps text-secondary uppercase tracking-widest">Trekking</span>
                                                <h3 class="font-headline-md text-headline-md text-on-surface mb-2">
                                                        Crossing the Empty Quarter</h3>
                                                <p
                                                        class="font-body-md text-body-md text-on-surface-variant mb-4 line-clamp-2">
                                                        An arduous journey through one of the most unforgiving
                                                        landscapes on earth, discovering beauty in desolation.</p>
                                                <p
                                                        class="font-label-caps text-label-caps text-outline uppercase tracking-widest">
                                                        By Elena Rostova</p>
                                        </div>
                                </article>
                                <!-- Card 2 -->
                                <article
                                        class="group cursor-pointer border border-surface-variant rounded bg-surface hover:shadow-lg transition-shadow duration-300">
                                        <div class="w-full h-64 overflow-hidden rounded-t">
                                                <img alt=""
                                                        class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500"
                                                        data-alt="A pristine, minimalist view of a calm sea meeting a white sand beach at dawn. The light is soft and diffused, creating a serene, almost monochromatic blue-gray palette with subtle warm tones near the horizon. The composition is highly structured, suitable for a premium travel magazine layout."
                                                        src="https://lh3.googleusercontent.com/aida-public/AB6AXuBUQH7Bp24cG_kdaFrf1lACtzQKQ5H2I7V8_6mwmX68VMeB7Pkel1IpqyspD7OBGt926gjzn2-8h6MqoLpwyXxuA0BcpQ4t3dggI_GVeTOCMD1HEgkOVimyYPofHWx_2afnYXA5TGxTCqG2-SuobyKNIqSA60NEmTas5gNfhqogLYsDL0NpTaEMrInsAoCj4u0WigZMvPfXw8_-mhiNtZ3_9-dBYK1xUHs2e8ouD1ZR7Pnyi2LqQzYxgqtmDbeeWyLWvRPqjWZYWhw" />
                                        </div>
                                        <div class="p-6">
                                                <span
                                                        class="inline-block bg-surface-container px-2 py-1 mb-3 rounded font-label-caps text-label-caps text-secondary uppercase tracking-widest">Coastal</span>
                                                <h3 class="font-headline-md text-headline-md text-on-surface mb-2">The
                                                        Silence of the Azores</h3>
                                                <p
                                                        class="font-body-md text-body-md text-on-surface-variant mb-4 line-clamp-2">
                                                        Finding isolation and raw natural power on the rugged edges of
                                                        the Atlantic Ocean.</p>
                                                <p
                                                        class="font-label-caps text-label-caps text-outline uppercase tracking-widest">
                                                        By Marcus Thorne</p>
                                        </div>
                                </article>
                                <!-- Card 3 -->
                                <article
                                        class="group cursor-pointer border border-surface-variant rounded bg-surface hover:shadow-lg transition-shadow duration-300">
                                        <div class="w-full h-64 overflow-hidden rounded-t">
                                                <img alt=""
                                                        class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500"
                                                        data-alt="A moody, high-contrast architectural shot of a dense, ancient European city seen from above in the early evening. The lighting mixes cool blue dusk with warm, scattered artificial lights from windows and streets. The structural density conveys a sense of rich history and complex urban exploration."
                                                        src="https://lh3.googleusercontent.com/aida-public/AB6AXuCqu4evWJbrSTEqWxv9z3ix6M_VZ0rkxg_r99jSozaDrVHTuuuHVeELv85ZBOnvGbhT4O2_0xM62TUkC_aqwahR23bMrD3kN1pz0MY-GG6XqKaYokvE-HYcmX4p7kS3uuUwsiQoqZxJ-FxdfzwibqFWsO5C4FSIYBcDh_a35SnItm4yqV2wn-RNjXrdqOO8iJrqWFP3HHqFi1kuYuY2327Zb91nFUSdE_zzxOFKw8GpiSettbJO4tofTH3lRD1t9VlNMAGv6cRLi40" />
                                        </div>
                                        <div class="p-6">
                                                <span
                                                        class="inline-block bg-surface-container px-2 py-1 mb-3 rounded font-label-caps text-label-caps text-secondary uppercase tracking-widest">Urban</span>
                                                <h3 class="font-headline-md text-headline-md text-on-surface mb-2">Lost
                                                        in Old Tbilisi</h3>
                                                <p
                                                        class="font-body-md text-body-md text-on-surface-variant mb-4 line-clamp-2">
                                                        Wandering through the crumbling courtyards and vibrant streets
                                                        of a city straddling two worlds.</p>
                                                <p
                                                        class="font-label-caps text-label-caps text-outline uppercase tracking-widest">
                                                        By Sarah Jenkins</p>
                                        </div>
                                </article>
                        </div>
                </section>
                <section
                        class="w-full max-w-container-max mx-auto px-margin-mobile md:px-margin-desktop pb-section-gap">
                        <h2 class="font-headline-lg text-headline-lg text-on-surface mb-gutter">Latest Stories</h2>
                        <div class="grid grid-cols-1 md:grid-cols-3 gap-gutter">
                                <!-- Card 1 -->
                                <article
                                        class="group cursor-pointer border border-surface-variant rounded bg-surface hover:shadow-lg transition-shadow duration-300">
                                        <div class="w-full h-64 overflow-hidden rounded-t">
                                                <img alt=""
                                                        class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500"
                                                        data-alt="A majestic view of a mountain range at dawn, with peaks catching the first golden rays of sun against a deep blue morning sky."
                                                        src="https://lh3.googleusercontent.com/aida-public/AB6AXuAx0KvZtVOsZeiePSzu3IW7UmdrLENlMC0OFKAKdfmzAOFE363Enj_leN19hImv4ifwFCoSojk2Jb2Hm69Wb6_52yqHhq8UhojRpelj_gPTcD5hn8-eYglCk_3UxR9gnW9ZELHwdxdBaAaW2L-4GwjOruJ2r8nhWNhIlbvG9WlN0AjXAHiXBaP3aQXg5hTMmEAw9ECdHwfUT9EngIGWnDh6ht1q3vT4IlSbamk2KGwPx76VNAkSm8QO8UKAww378qTRAUoMEqv81jw" />
                                        </div>
                                        <div class="p-6">
                                                <span
                                                        class="inline-block bg-surface-container px-2 py-1 mb-3 rounded font-label-caps text-label-caps text-secondary uppercase tracking-widest">Trekking</span>
                                                <h3 class="font-headline-md text-headline-md text-on-surface mb-2">
                                                        Summiting the Andes</h3>
                                                <p
                                                        class="font-body-md text-body-md text-on-surface-variant mb-4 line-clamp-2">
                                                        A first-hand account of the grueling climb to the peak of
                                                        Huascarán.</p>
                                                <p
                                                        class="font-label-caps text-label-caps text-outline uppercase tracking-widest">
                                                        Oct 24, 2023</p>
                                        </div>
                                </article>
                                <!-- Card 2 -->
                                <article
                                        class="group cursor-pointer border border-surface-variant rounded bg-surface hover:shadow-lg transition-shadow duration-300">
                                        <div class="w-full h-64 overflow-hidden rounded-t">
                                                <img alt=""
                                                        class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500"
                                                        data-alt="A bustling neon street in Tokyo at night, filled with colorful signs, umbrellas, and the vibrant energy of the city."
                                                        src="https://lh3.googleusercontent.com/aida-public/AB6AXuCqu4evWJbrSTEqWxv9z3ix6M_VZ0rkxg_r99jSozaDrVHTuuuHVeELv85ZBOnvGbhT4O2_0xM62TUkC_aqwahR23bMrD3kN1pz0MY-GG6XqKaYokvE-HYcmX4p7kS3uuUwsiQoqZxJ-FxdfzwibqFWsO5C4FSIYBcDh_a35SnItm4yqV2wn-RNjXrdqOO8iJrqWFP3HHqFi1kuYuY2327Zb91nFUSdE_zzxOFKw8GpiSettbJO4tofTH3lRD1t9VlNMAGv6cRLi40" />
                                        </div>
                                        <div class="p-6">
                                                <span
                                                        class="inline-block bg-surface-container px-2 py-1 mb-3 rounded font-label-caps text-label-caps text-secondary uppercase tracking-widest">Urban</span>
                                                <h3 class="font-headline-md text-headline-md text-on-surface mb-2">
                                                        Tokyo's Hidden Alleys</h3>
                                                <p
                                                        class="font-body-md text-body-md text-on-surface-variant mb-4 line-clamp-2">
                                                        Finding the soul of the city in its quietest, most colorful
                                                        corners.</p>
                                                <p
                                                        class="font-label-caps text-label-caps text-outline uppercase tracking-widest">
                                                        Oct 22, 2023</p>
                                        </div>
                                </article>
                                <!-- Card 3 -->
                                <article
                                        class="group cursor-pointer border border-surface-variant rounded bg-surface hover:shadow-lg transition-shadow duration-300">
                                        <div class="w-full h-64 overflow-hidden rounded-t">
                                                <img alt=""
                                                        class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500"
                                                        data-alt="A tropical beach in Bali with crystal clear turquoise water, white sand, and lush greenery in the background."
                                                        src="https://lh3.googleusercontent.com/aida-public/AB6AXuBUQH7Bp24cG_kdaFrf1lACtzQKQ5H2I7V8_6mwmX68VMeB7Pkel1IpqyspD7OBGt926gjzn2-8h6MqoLpwyXxuA0BcpQ4t3dggI_GVeTOCMD1HEgkOVimyYPofHWx_2afnYXA5TGxTCqG2-SuobyKNIqSA60NEmTas5gNfhqogLYsDL0NpTaEMrInsAoCj4u0WigZMvPfXw8_-mhiNtZ3_9-dBYK1xUHs2e8ouD1ZR7Pnyi2LqQzYxgqtmDbeeWyLWvRPqjWZYWhw" />
                                        </div>
                                        <div class="p-6">
                                                <span
                                                        class="inline-block bg-surface-container px-2 py-1 mb-3 rounded font-label-caps text-label-caps text-secondary uppercase tracking-widest">Coastal</span>
                                                <h3 class="font-headline-md text-headline-md text-on-surface mb-2">The
                                                        Secrets of Bali</h3>
                                                <p
                                                        class="font-body-md text-body-md text-on-surface-variant mb-4 line-clamp-2">
                                                        Beyond the resorts: discovering the untouched shores of the Nusa
                                                        islands.</p>
                                                <p
                                                        class="font-label-caps text-label-caps text-outline uppercase tracking-widest">
                                                        Oct 20, 2023</p>
                                        </div>
                                </article>
                        </div>
                </section>
                <!-- Footer -->
                <jsp:include page="/WEB-INF/views/includes/footer.jsp" />
        </body>

        </html>