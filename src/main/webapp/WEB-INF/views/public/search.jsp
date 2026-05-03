<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>

    <html lang="en">

    <head>
        <meta charset="utf-8" />
        <meta content="width=device-width, initial-scale=1.0" name="viewport" />
        <title>Thoughts of Nomads - Search Results: Kathmandu</title>
        <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
        <link
            href="https://fonts.googleapis.com/css2?family=Epilogue:wght@400;600;700;800&amp;family=Work+Sans:wght@400;500;600&amp;display=swap"
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
                            "primary-fixed-dim": "#bbc4f3",
                            "surface-container-highest": "#e1e3e4",
                            "on-tertiary-fixed": "#2a1800",
                            "on-error-container": "#93000a",
                            "tertiary-fixed": "#ffddb5",
                            "tertiary": "#2a1800",
                            "tertiary-fixed-dim": "#ffb957",
                            "on-tertiary-container": "#d18900",
                            "surface-container-high": "#e7e8e9",
                            "surface-container-low": "#f3f4f5",
                            "on-surface-variant": "#45464e",
                            "on-primary-fixed-variant": "#3b456c",
                            "outline": "#76767f",
                            "secondary-fixed": "#ffdad4",
                            "on-secondary": "#ffffff",
                            "surface-tint": "#535c85",
                            "inverse-surface": "#2e3132",
                            "surface-container-lowest": "#ffffff",
                            "primary-fixed": "#dce1ff",
                            "on-background": "#191c1d",
                            "inverse-on-surface": "#f0f1f2",
                            "surface-variant": "#e1e3e4",
                            "tertiary-container": "#462b00",
                            "background": "#f8f9fa",
                            "on-secondary-fixed-variant": "#82261b",
                            "surface-dim": "#d9dadb",
                            "outline-variant": "#c6c5cf",
                            "on-tertiary": "#ffffff",
                            "surface": "#f8f9fa",
                            "on-error": "#ffffff",
                            "surface-bright": "#f8f9fa",
                            "surface-container": "#edeeef",
                            "secondary": "#a23d30",
                            "on-primary-fixed": "#0e193e",
                            "on-primary": "#ffffff",
                            "on-secondary-container": "#731a11",
                            "inverse-primary": "#bbc4f3",
                            "secondary-fixed-dim": "#ffb4a8",
                            "error-container": "#ffdad6",
                            "on-tertiary-fixed-variant": "#643f00",
                            "on-primary-container": "#8c96c2",
                            "on-secondary-fixed": "#410000",
                            "secondary-container": "#fd8270",
                            "primary-container": "#242e54",
                            "primary": "#0e193e",
                            "on-surface": "#191c1d",
                            "error": "#ba1a1a"
                        },
                        "borderRadius": {
                            "DEFAULT": "0.125rem",
                            "lg": "0.25rem",
                            "xl": "0.5rem",
                            "full": "0.75rem"
                        },
                        "spacing": {
                            "base": "8px",
                            "margin-desktop": "48px",
                            "container-max": "1280px",
                            "margin-mobile": "16px",
                            "gutter": "24px",
                            "section-gap": "80px"
                        },
                        "fontFamily": {
                            "label-caps": ["Work Sans"],
                            "body-lg": ["Work Sans"],
                            "headline-md": ["Epilogue"],
                            "display-lg": ["Epilogue"],
                            "headline-lg": ["Epilogue"],
                            "body-md": ["Work Sans"]
                        },
                        "fontSize": {
                            "label-caps": ["12px", { "lineHeight": "1.0", "letterSpacing": "0.1em", "fontWeight": "600" }],
                            "body-lg": ["18px", { "lineHeight": "1.6", "fontWeight": "400" }],
                            "headline-md": ["24px", { "lineHeight": "1.3", "fontWeight": "600" }],
                            "display-lg": ["48px", { "lineHeight": "1.1", "letterSpacing": "-0.02em", "fontWeight": "700" }],
                            "headline-lg": ["32px", { "lineHeight": "1.2", "fontWeight": "600" }],
                            "body-md": ["16px", { "lineHeight": "1.5", "fontWeight": "400" }]
                        }
                    }
                }
            }
        </script>
    </head>

    <body class="bg-background text-on-background min-h-screen flex flex-col antialiased">
        <!-- TopNavBar -->
        <jsp:include page="/WEB-INF/views/includes/header.jsp" />
        <!-- Main Content Canvas -->
        <main class="flex-grow flex flex-col">
            <!-- Header Section -->
            <section class="w-full bg-surface-container-lowest pt-8 pb-6 border-b border-surface-variant">
                <div class="max-w-container-max mx-auto px-margin-mobile md:px-margin-desktop">
                    <!-- Breadcrumbs -->
                    <nav aria-label="Breadcrumb"
                        class="flex items-center space-x-2 text-on-surface-variant font-label-caps text-[10px] mb-6">
                        <a class="hover:text-primary transition-colors" href="<%=request.getContextPath()%>/">Home</a>
                        <span class="material-symbols-outlined text-[14px]">chevron_right</span>
                        <span class="text-primary-container">Search</span>
                    </nav>
                    <!-- Headline -->
                    <div class="mb-6">
                        <h1 class="font-display-lg text-headline-lg text-on-surface mb-2">Search Results for:
                            "<%= request.getAttribute("query") != null && !request.getAttribute("query").toString().isEmpty() ? request.getAttribute("query") : "All" %>"</h1>
                        <p class="font-body-md text-body-md text-on-surface-variant">Showing 12 journeys found</p>
                    </div>
                    <!-- Refiner Bar -->
                    <div
                        class="flex flex-col md:flex-row items-center justify-between gap-3 bg-surface rounded-lg p-3 border border-outline-variant">
                        <form action="<%=request.getContextPath()%>/search" method="GET" class="relative w-full md:w-1/3">
                            <span
                                class="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-on-surface-variant text-[18px]">search</span>
                            <input name="q"
                                class="w-full pl-10 pr-3 py-2 bg-surface-container-lowest border border-outline-variant rounded font-body-md text-sm text-on-surface focus:border-primary focus:ring-1 focus:ring-primary outline-none transition-all"
                                placeholder="Search journeys..." type="text" value="<%= request.getAttribute("query") != null ? request.getAttribute("query") : "" %>" />
                        </form>
                        <div class="flex w-full md:w-auto space-x-3">
                            <div class="relative w-full md:w-40">
                                <select
                                    class="w-full appearance-none bg-surface-container-lowest border border-outline-variant rounded pl-3 pr-8 py-2 font-body-md text-sm text-on-surface focus:border-primary focus:ring-1 focus:ring-primary outline-none cursor-pointer">
                                    <option>Most Relevant</option>
                                    <option>Newest First</option>
                                    <option>Most Read</option>
                                </select>
                                <span
                                    class="material-symbols-outlined absolute right-3 top-1/2 -translate-y-1/2 text-on-surface-variant text-[18px] pointer-events-none">expand_more</span>
                            </div>
                            <div class="relative w-full md:w-40">
                                <select
                                    class="w-full appearance-none bg-surface-container-lowest border border-outline-variant rounded pl-3 pr-8 py-2 font-body-md text-sm text-on-surface focus:border-primary focus:ring-1 focus:ring-primary outline-none cursor-pointer">
                                    <option>All Authors</option>
                                    <option>Sarah Jenkins</option>
                                    <option>David Chen</option>
                                    <option>Elena Rodriguez</option>
                                </select>
                                <span
                                    class="material-symbols-outlined absolute right-3 top-1/2 -translate-y-1/2 text-on-surface-variant text-[18px] pointer-events-none">filter_list</span>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
            <!-- Results Grid -->
            <section class="max-w-container-max mx-auto px-margin-mobile md:px-margin-desktop py-10">
                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                    <!-- Card 1 -->
                    <article
                        class="group flex flex-col bg-surface-container-lowest border border-surface-variant rounded overflow-hidden hover:shadow-[0px_4px_20px_rgba(36,46,84,0.05)] transition-shadow duration-300">
                        <div class="w-full aspect-video bg-surface-container relative overflow-hidden">
                            <img alt="Kathmandu cityscape"
                                class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500"
                                data-alt="A sweeping, slightly desaturated view of the Kathmandu valley at dawn. Intricate, ancient temple rooftops rise above the morning mist, framed by distant, towering Himalayan peaks. The scene is illuminated by soft, cool morning light, perfectly aligning with a modern, high-contrast, premium editorial photography aesthetic used in luxury travel magazines."
                                src="https://lh3.googleusercontent.com/aida-public/AB6AXuCVCdiSqEKC_l4pD9kjBBqEUvxjuBn66w4DtQXsqmXxwKzQjtmPsv-n56hDRzN6taylqcFeed8J93MacG3G_fsABCJh5TllzWubz_jsb9T_pcdmn9bPZ8sqcoVlRGnSSZmRLTrXHwrjXAZzA8cK30pulYlq0ZfL3wSUpgC_lvj2kXWvq0-g-xsIv0VZKGiS_Z0-94EXNnH3dRj2UPnSdm8p2gb0HiH0J6noSimzQBBIbVz7SDrjRatKNqVPJHuJ2EBNjrH5UVU_uqw" />
                            <div
                                class="absolute top-3 left-3 bg-surface-container-lowest/90 backdrop-blur-sm px-2 py-1 rounded text-on-surface font-label-caps text-[10px] shadow-sm">
                                #SlowTravel
                            </div>
                        </div>
                        <div class="p-5 flex flex-col flex-grow">
                            <h2
                                class="font-headline-md text-[18px] leading-snug text-on-surface mb-2 line-clamp-2 group-hover:text-primary transition-colors">
                                Finding Stillness in the Chaos of <span class="font-bold">Kathmandu</span></h2>
                            <p
                                class="font-body-md text-[13px] leading-relaxed text-on-surface-variant mb-5 line-clamp-2 flex-grow">
                                Navigating the labyrinthine streets of Thamel reveals hidden courtyards and ancient
                                stupas that demand a slower pace of exploration.</p>
                            <div class="flex items-center mt-auto pt-3 border-t border-surface-variant">
                                <img alt="Author" class="w-6 h-6 rounded-full object-cover mr-2"
                                    data-alt="A high-quality, professional headshot of a female travel writer. She has a natural, confident expression, shot against a clean, out-of-focus urban background. The lighting is soft and flattering, matching the sophisticated, slightly desaturated editorial style of the overall design system."
                                    src="https://lh3.googleusercontent.com/aida-public/AB6AXuCs3XWoOclZ2Qa_7R0q0A6MhC9OdHbRmKTI0rxKtB8h_mzFiOhaEG4mY90RzT5EYsvniU4HtHAP04vPs3zNJTwLLvwVqKsgUXMEyZ-N0q5SVuElVSSgEwJaSToJacsHjqEu6bQ1aB1MjcK7hCc91mWapVuhq9I-itVlmEtyyi6VCJOQT7BGenMjc4qqAaOxQDR5Y_AiJP7aTu9EgbcbW7r9B_BAPUNx-9k2qEsdelB_c_iIXMc0DqH6BG1rxEZ2dw_5gCuMw3xZWhg" />
                                <span class="font-label-caps text-[10px] text-on-surface-variant">Sarah Jenkins • Oct
                                    12, 2023</span>
                            </div>
                        </div>
                    </article>
                    <!-- Card 2 -->
                    <article
                        class="group flex flex-col bg-surface-container-lowest border border-surface-variant rounded overflow-hidden hover:shadow-[0px_4px_20px_rgba(36,46,84,0.05)] transition-shadow duration-300">
                        <div class="w-full aspect-video bg-surface-container relative overflow-hidden">
                            <img alt="Swayambhunath Stupa"
                                class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500"
                                data-alt="A close-up, highly detailed photograph of the iconic golden spire and painted eyes of the Swayambhunath Stupa in Nepal. Prayer flags flutter across the composition in sharp focus against a clear blue sky. The image features high contrast and slightly muted tones, characteristic of high-end, contemporary travel journalism."
                                src="https://lh3.googleusercontent.com/aida-public/AB6AXuA0sdQI7FlSqJ2Ezdvy8DlCxmdNW404PLjWgGj3Rw_lbMpOP2XyfQDZMTzo1JampbRGvt4d-elrvgkFc8GaH92GRMb8OXNMA5SRLhdCIAjpJxuc6nCZ9Jg_Rpa-1U7ncv-sI8QivrZw0ZyyOVDj3J57GRjFW12Xxg5izwjPwzeDVYCB7uCppKEt5QWzKP6TK52jYxaapynBYLpMfUkkxP8VMlcnxlEN4OjTiFKYahVsQxbQXTekbtUvsNBZNpT7KX_wMlK5GuMDyBw" />
                            <div
                                class="absolute top-3 left-3 bg-surface-container-lowest/90 backdrop-blur-sm px-2 py-1 rounded text-on-surface font-label-caps text-[10px] shadow-sm">
                                #Heritage
                            </div>
                        </div>
                        <div class="p-5 flex flex-col flex-grow">
                            <h2
                                class="font-headline-md text-[18px] leading-snug text-on-surface mb-2 line-clamp-2 group-hover:text-primary transition-colors">
                                The Monkey Temple: A <span class="font-bold">Kathmandu</span> Sunrise</h2>
                            <p
                                class="font-body-md text-[13px] leading-relaxed text-on-surface-variant mb-5 line-clamp-2 flex-grow">
                                Ascending the 365 steps before dawn offers a rare moment of clarity amidst the spinning
                                prayer wheels and chanting monks.</p>
                            <div class="flex items-center mt-auto pt-3 border-t border-surface-variant">
                                <img alt="Author" class="w-6 h-6 rounded-full object-cover mr-2"
                                    data-alt="A portrait of a male photographer in a neutral, modern setting. He wears a simple dark shirt. The image is sharply focused with a shallow depth of field, utilizing a refined, professional color grade suitable for an authoritative editorial platform."
                                    src="https://lh3.googleusercontent.com/aida-public/AB6AXuCo6sQYvtjbebiRcn94XX96ddkzklMfFIW9NdgYRQafLMpGJA9o5lKf8rL0UPOAtuRFgb-tdf-qbv90dI4qRbKvho67_6i3cUKmzAM69ZqFFIx2TiyBKV93yrjF-4EG1DSHue33tWwYIQI9byYs8nbbGDp0TPyRiWgKntlj0HoncIxmkWjQSFQBGJPCy0U6n6OMkwp6JP5vddDRswEr9CMJ8yQlWfi-VQX9-vl-t3syVHSXJejFu1iomE0SM4jsAaUlBFQDu8qgJI8" />
                                <span class="font-label-caps text-[10px] text-on-surface-variant">David Chen • Sep 28,
                                    2023</span>
                            </div>
                        </div>
                    </article>
                    <!-- Card 3 -->
                    <article
                        class="group flex flex-col bg-surface-container-lowest border border-surface-variant rounded overflow-hidden hover:shadow-[0px_4px_20px_rgba(36,46,84,0.05)] transition-shadow duration-300">
                        <div class="w-full aspect-video bg-surface-container relative overflow-hidden">
                            <img alt="Digital Nomad Cafe"
                                class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500"
                                data-alt="An interior shot of a sophisticated, modern cafe in an ancient city setting. A laptop sits on a rough-hewn wooden table beside a steaming cup of artisan coffee. The lighting is moody and natural, highlighting textures and deep shadows, emphasizing a premium, focused digital nomad lifestyle aesthetic."
                                src="https://lh3.googleusercontent.com/aida-public/AB6AXuDi2caFkp4nmbuM5Dr_iM9GCyVfz1k78KrhERk9_MZRlQHHyr_X9-Z48-tNZLuKNkdvQSPbF5lVcJWKFFEK5bR7JygYhtYzNOSBwS5Ps9-s6T8Av9XsNXDk7pygM8B-1GZZi5q4mT2XaGqHBaGaljR0vi1WZdCn2_pWmY4DsS8d981EqnjREGu5-wKstreiYQronkCE-KZ1ytY_piFolgxfHvSGwbTs9X3KnrjJS7lxLtJgluiVxITnwXwNOudX0f_c7wShA7w3b3M" />
                            <div
                                class="absolute top-3 left-3 bg-surface-container-lowest/90 backdrop-blur-sm px-2 py-1 rounded text-on-surface font-label-caps text-[10px] shadow-sm">
                                #RemoteWork
                            </div>
                        </div>
                        <div class="p-5 flex flex-col flex-grow">
                            <h2
                                class="font-headline-md text-[18px] leading-snug text-on-surface mb-2 line-clamp-2 group-hover:text-primary transition-colors">
                                Working Remotely from <span class="font-bold">Kathmandu</span>: A Guide</h2>
                            <p
                                class="font-body-md text-[13px] leading-relaxed text-on-surface-variant mb-5 line-clamp-2 flex-grow">
                                Overcoming infrastructure challenges to find the perfect blend of productivity and
                                profound cultural immersion in the valley.</p>
                            <div class="flex items-center mt-auto pt-3 border-t border-surface-variant">
                                <img alt="Author" class="w-6 h-6 rounded-full object-cover mr-2"
                                    data-alt="A clean, minimalist headshot of a female author with an understated, elegant look. The lighting is even and cool, set against a stark white background. The visual tone aligns with a disciplined, high-end editorial brand focused on clarity and professionalism."
                                    src="https://lh3.googleusercontent.com/aida-public/AB6AXuAK5iixv9wSOKvt3LdUF-cXNTW8he9O5Z7LFUTAKTHB0VLAMRpXVVhaa0VTN-ZoxC7rhLABs2Xkb0UPpKMZeVSxvRs598II7saNDTxXUgUfpn1-7pytXqOspU-BnRGsu9U8woHSp05NskDUVPohadWQWlpvjhOchA2w323cSVKB9NmwjK5iYmerIzkv2O2yTpKeG-XC3QSE-ClqZKTW3zJutWrgQLDQhKt5Dxu-ZQPzANNzVN6AiKyiZ13Lf31tH5m3I4iBhuZCvks" />
                                <span class="font-label-caps text-[10px] text-on-surface-variant">Elena Rodriguez • Aug
                                    15, 2023</span>
                            </div>
                        </div>
                    </article>
                </div>
                <!-- Pagination -->
                <div class="mt-12 flex justify-center items-center space-x-2">
                    <button
                        class="px-3 py-1.5 border border-outline-variant rounded font-label-caps text-[11px] text-on-surface-variant hover:text-primary hover:border-primary transition-colors disabled:opacity-50 disabled:cursor-not-allowed">Previous</button>
                    <div class="hidden sm:flex space-x-1">
                        <button
                            class="w-8 h-8 flex items-center justify-center rounded bg-primary text-on-primary font-label-caps text-[11px]">1</button>
                        <button
                            class="w-8 h-8 flex items-center justify-center rounded border border-transparent hover:border-outline-variant text-on-surface font-label-caps text-[11px] transition-all">2</button>
                        <button
                            class="w-8 h-8 flex items-center justify-center rounded border border-transparent hover:border-outline-variant text-on-surface font-label-caps text-[11px] transition-all">3</button>
                        <span
                            class="w-8 h-8 flex items-center justify-center text-on-surface-variant text-[11px]">...</span>
                        <button
                            class="w-8 h-8 flex items-center justify-center rounded border border-transparent hover:border-outline-variant text-on-surface font-label-caps text-[11px] transition-all">10</button>
                    </div>
                    <button
                        class="px-3 py-1.5 border border-outline-variant rounded font-label-caps text-[11px] text-on-surface-variant hover:text-primary hover:border-primary transition-colors">Next</button>
                </div>
            </section>
        </main>
        <!-- Footer -->
        <jsp:include page="/WEB-INF/views/includes/footer.jsp" />
    </body>

    </html>