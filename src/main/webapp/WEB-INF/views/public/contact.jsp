<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>

    <html class="light" lang="en">

    <head>
        <meta charset="utf-8" />
        <meta content="width=device-width, initial-scale=1.0" name="viewport" />
        <title>Contact Us - Thoughts of Nomads</title>
        <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
        <link href="https://fonts.googleapis.com" rel="preconnect" />
        <link crossorigin="" href="https://fonts.gstatic.com" rel="preconnect" />
        <link
            href="https://fonts.googleapis.com/css2?family=Epilogue:wght@400;600;700&amp;family=Work+Sans:wght@400;600&amp;display=swap"
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
                            "primary-fixed": "#dce1ff",
                            "on-tertiary-container": "#d18900",
                            "on-secondary-fixed": "#410000",
                            "surface-container": "#edeeef",
                            "secondary": "#a23d30",
                            "on-background": "#191c1d",
                            "tertiary-fixed": "#ffddb5",
                            "on-secondary-fixed-variant": "#82261b",
                            "tertiary-fixed-dim": "#ffb957",
                            "surface-bright": "#f8f9fa",
                            "tertiary-container": "#462b00",
                            "surface-container-lowest": "#ffffff",
                            "surface-variant": "#e1e3e4",
                            "inverse-on-surface": "#f0f1f2",
                            "on-primary-container": "#8c96c2",
                            "surface-container-highest": "#e1e3e4",
                            "secondary-fixed-dim": "#ffb4a8",
                            "on-primary": "#ffffff",
                            "background": "#f8f9fa",
                            "primary-fixed-dim": "#bbc4f3",
                            "surface-container-low": "#f3f4f5",
                            "on-primary-fixed": "#0e193e",
                            "secondary-fixed": "#ffdad4",
                            "on-primary-fixed-variant": "#3b456c",
                            "inverse-primary": "#bbc4f3",
                            "error-container": "#ffdad6",
                            "surface-dim": "#d9dadb",
                            "secondary-container": "#fd8270",
                            "primary-container": "#242e54",
                            "tertiary": "#2a1800",
                            "primary": "#0e193e",
                            "on-error-container": "#93000a",
                            "error": "#ba1a1a",
                            "on-secondary-container": "#731a11",
                            "surface-container-high": "#e7e8e9",
                            "inverse-surface": "#2e3132",
                            "on-surface-variant": "#45464e",
                            "on-secondary": "#ffffff",
                            "surface": "#f8f9fa",
                            "on-tertiary": "#ffffff",
                            "outline-variant": "#c6c5cf",
                            "outline": "#76767f",
                            "surface-tint": "#535c85",
                            "on-surface": "#191c1d",
                            "on-tertiary-fixed-variant": "#643f00",
                            "on-tertiary-fixed": "#2a1800",
                            "on-error": "#ffffff"
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
                            "base": "8px",
                            "margin-mobile": "16px",
                            "gutter": "24px",
                            "container-max": "1280px"
                        },
                        "fontFamily": {
                            "headline-md": ["Epilogue"],
                            "label-caps": ["Work Sans"],
                            "body-md": ["Work Sans"],
                            "headline-lg": ["Epilogue"],
                            "body-lg": ["Work Sans"],
                            "display-lg": ["Epilogue"]
                        },
                        "fontSize": {
                            "headline-md": ["24px", { "lineHeight": "1.3", "fontWeight": "600" }],
                            "label-caps": ["12px", { "lineHeight": "1.0", "letterSpacing": "0.1em", "fontWeight": "600" }],
                            "body-md": ["16px", { "lineHeight": "1.5", "fontWeight": "400" }],
                            "headline-lg": ["32px", { "lineHeight": "1.2", "fontWeight": "600" }],
                            "body-lg": ["18px", { "lineHeight": "1.6", "fontWeight": "400" }],
                            "display-lg": ["48px", { "lineHeight": "1.1", "letterSpacing": "-0.02em", "fontWeight": "700" }]
                        }
                    }
                }
            }
        </script>
        <style>
            .material-symbols-outlined {
                font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
            }

            [data-weight="fill"] {
                font-variation-settings: 'FILL' 1;
            }
        </style>
    </head>

    <body class="bg-background text-on-background min-h-screen flex flex-col">
        <!-- TopNavBar -->
        <jsp:include page="/WEB-INF/views/includes/header.jsp" />
        <!-- Main Content Canvas -->
        <main class="flex-grow max-w-container-max mx-auto w-full px-gutter md:px-margin-desktop py-section-gap">
            <!-- Page Header -->
            <header class="mb-margin-desktop text-center md:text-left max-w-3xl">
                <h1 class="font-display-lg text-display-lg text-primary-container mb-base">Contact Us</h1>
                <p class="font-body-lg text-body-lg text-on-surface-variant">We're always eager to connect with fellow
                    travelers, potential partners, and readers. Reach out and let's start a conversation.</p>
            </header>
            <!-- Two Column Layout -->
            <div class="grid grid-cols-1 md:grid-cols-12 gap-gutter lg:gap-[64px]">
                <!-- Left Column: Contact Information -->
                <div class="md:col-span-5 lg:col-span-4 flex flex-col gap-margin-desktop">
                    <section>
                        <h2 class="font-headline-md text-headline-md text-primary-container mb-margin-mobile">Get in
                            Touch</h2>
                        <div class="flex flex-col gap-6">
                            <!-- Address -->
                            <div class="flex items-start gap-4">
                                <span class="material-symbols-outlined text-primary-container text-[24px]"
                                    data-icon="location_on">location_on</span>
                                <div>
                                    <h3 class="font-label-caps text-label-caps text-on-surface-variant mb-1">HQ ADDRESS
                                    </h3>
                                    <p class="font-body-md text-body-md text-on-background">Thamel,
                                        Kathmandu<br />Bagmati Province, Nepal<br />44600</p>
                                </div>
                            </div>
                            <!-- Email -->
                            <div class="flex items-start gap-4">
                                <span class="material-symbols-outlined text-primary-container text-[24px]"
                                    data-icon="mail">mail</span>
                                <div>
                                    <h3 class="font-label-caps text-label-caps text-on-surface-variant mb-1">EDITORIAL
                                        &amp; SUPPORT</h3>
                                    <a class="font-body-md text-body-md text-primary-container hover:underline hover:text-secondary transition-colors"
                                        href="mailto:support@thoughtsofnomads.com">support@thoughtsofnomads.com</a>
                                </div>
                            </div>
                            <!-- Phone -->
                            <div class="flex items-start gap-4">
                                <span class="material-symbols-outlined text-primary-container text-[24px]"
                                    data-icon="phone_enabled">phone_enabled</span>
                                <div>
                                    <h3 class="font-label-caps text-label-caps text-on-surface-variant mb-1">GENERAL
                                        INQUIRIES</h3>
                                    <a class="font-body-md text-body-md text-on-background hover:text-secondary transition-colors"
                                        href="tel:+977123456789">+977 (1) 234-5678</a>
                                </div>
                            </div>
                        </div>
                    </section>
                    <!-- Small map visual context (Image representation) -->
                    <div
                        class="w-full aspect-[4/3] bg-surface-container rounded-DEFAULT overflow-hidden border border-outline-variant relative">
                        <img alt="Map of Kathmandu" class="w-full h-full object-cover"
                            data-alt="A highly detailed, professional map view of Kathmandu, Nepal, stylized with a minimalistic color palette featuring muted whites, soft greys, and subtle mystic blue accents. The map highlights key travel routes in a clean, editorial aesthetic, perfectly aligned with a premium digital nomad magazine. The lighting is flat and graphic, emphasizing structured layout and clean typography over realistic geography."
                            data-location="Kathmandu, Nepal"
                            src="https://lh3.googleusercontent.com/aida-public/AB6AXuBBxCTBI6Vl96SCYskCk2zmI07NmfVpsfKJw-vPjCK3cNJ6Ve6CLxsFeoXaCTGnApNTfjg7omrgoxm0mgETW_lSvbbZwi0yWIA3nKtkRjoUJ3WxFpJtE55yaWm_tZ2tMhlf3b4DM0el2vhtwm7-aanQl4VaRzfqK-0kWZv6OCRRzuj0Cz_lTebqD2advS6nAfemUIcQAWPHPoX-RpuVce5Dpy1aObtnSd_wVN54G3ic0zbM51bfD2q3hE1hqqllkgl99J5wS9OJyJM" />
                    </div>
                </div>
                <!-- Right Column: Inquiry Form -->
                <div class="md:col-span-7 lg:col-span-8">
                    <div
                        class="bg-surface-container-lowest p-gutter md:p-[40px] rounded-DEFAULT border border-outline-variant">
                        <% if (request.getAttribute("success") != null) { %>
                            <div class="bg-primary/10 text-primary-container p-4 rounded-DEFAULT font-body-md text-body-md border border-primary/20 mb-6">
                                <%= request.getAttribute("success") %>
                            </div>
                        <% } %>
                        <form action="<%=request.getContextPath()%>/contact" method="POST" class="flex flex-col gap-6" novalidate="">
                            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                <!-- Full Name -->
                                <div class="flex flex-col gap-2">
                                    <label class="font-label-caps text-label-caps text-on-surface" for="fullName">Full
                                        Name *</label>
                                    <input
                                        class="w-full bg-surface-bright border border-outline-variant rounded-DEFAULT px-4 py-3 font-body-md text-body-md text-on-background focus:border-primary-container focus:ring-1 focus:ring-primary-container outline-none transition-colors placeholder:text-outline"
                                        id="fullName" name="fullName" placeholder="Jane Doe" required="" type="text" />
                                </div>
                                <!-- Email Address -->
                                <div class="flex flex-col gap-2">
                                    <label class="font-label-caps text-label-caps text-on-surface"
                                        for="emailAddress">Email Address *</label>
                                    <input
                                        class="w-full bg-surface-bright border border-outline-variant rounded-DEFAULT px-4 py-3 font-body-md text-body-md text-on-background focus:border-primary-container focus:ring-1 focus:ring-primary-container outline-none transition-colors placeholder:text-outline"
                                        id="emailAddress" name="emailAddress" placeholder="jane@example.com" required=""
                                        type="email" />
                                    <span class="font-body-md text-[12px] text-outline">We'll never share your
                                        email.</span>
                                </div>
                            </div>
                            <!-- Subject -->
                            <div class="flex flex-col gap-2">
                                <label class="font-label-caps text-label-caps text-on-surface"
                                    for="subject">Subject</label>
                                <input
                                    class="w-full bg-surface-bright border border-outline-variant rounded-DEFAULT px-4 py-3 font-body-md text-body-md text-on-background focus:border-primary-container focus:ring-1 focus:ring-primary-container outline-none transition-colors placeholder:text-outline"
                                    id="subject" name="subject" placeholder="Partnership Inquiry" type="text" />
                            </div>
                            <!-- Message -->
                            <div class="flex flex-col gap-2">
                                <label class="font-label-caps text-label-caps text-on-surface" for="message">Message
                                    *</label>
                                <textarea
                                    class="w-full bg-surface-bright border border-outline-variant rounded-DEFAULT px-4 py-3 font-body-md text-body-md text-on-background focus:border-primary-container focus:ring-1 focus:ring-primary-container outline-none transition-colors placeholder:text-outline resize-none"
                                    id="message" name="message" placeholder="How can we help you on your journey?"
                                    required="" rows="6"></textarea>
                            </div>
                            <!-- Submit Area -->
                            <div class="flex items-center justify-between mt-4">
                                <span class="font-body-md text-[13px] text-outline">* Indicates required field</span>
                                <button
                                    class="bg-primary-container text-on-primary px-8 py-4 rounded-DEFAULT font-label-caps text-label-caps hover:bg-[#1a213e] hover:shadow-[0px_4px_20px_rgba(36,46,84,0.05)] transition-all flex items-center gap-2"
                                    type="submit">
                                    Send Message
                                    <span class="material-symbols-outlined text-[18px]" data-icon="send">send</span>
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </main>
        <!-- Footer -->
        <jsp:include page="/WEB-INF/views/includes/footer.jsp" />
    </body>

    </html>