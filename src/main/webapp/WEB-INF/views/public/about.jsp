<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>

    <html class="light" lang="en">

    <head>
        <meta charset="utf-8" />
        <meta content="width=device-width, initial-scale=1.0" name="viewport" />
        <title>About Us - Thoughts of Nomads</title>
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
                            "surface": "#f8f9fa",
                            "inverse-surface": "#2e3132",
                            "on-primary-container": "#8c96c2",
                            "primary-fixed": "#dce1ff",
                            "tertiary-fixed-dim": "#ffb957",
                            "outline-variant": "#c6c5cf",
                            "tertiary-container": "#462b00",
                            "on-primary": "#ffffff",
                            "surface-tint": "#535c85",
                            "background": "#f8f9fa",
                            "primary-fixed-dim": "#bbc4f3",
                            "on-secondary": "#ffffff",
                            "error-container": "#ffdad6",
                            "on-background": "#191c1d",
                            "on-tertiary-fixed-variant": "#643f00",
                            "surface-container-lowest": "#ffffff",
                            "on-secondary-fixed": "#410000",
                            "error": "#ba1a1a",
                            "secondary-container": "#fd8270",
                            "on-secondary-container": "#731a11",
                            "surface-variant": "#e1e3e4",
                            "on-error-container": "#93000a",
                            "secondary-fixed-dim": "#ffb4a8",
                            "surface-container-low": "#f3f4f5",
                            "surface-container-high": "#e7e8e9",
                            "surface-container": "#edeeef",
                            "outline": "#76767f",
                            "on-error": "#ffffff",
                            "secondary": "#a23d30",
                            "secondary-fixed": "#ffdad4",
                            "surface-bright": "#f8f9fa",
                            "on-primary-fixed-variant": "#3b456c",
                            "on-primary-fixed": "#0e193e",
                            "surface-dim": "#d9dadb",
                            "inverse-primary": "#bbc4f3",
                            "on-tertiary": "#ffffff",
                            "inverse-on-surface": "#f0f1f2",
                            "primary-container": "#242e54",
                            "on-surface": "#191c1d",
                            "tertiary": "#2a1800",
                            "on-secondary-fixed-variant": "#82261b",
                            "primary": "#0e193e",
                            "on-tertiary-fixed": "#2a1800",
                            "tertiary-fixed": "#ffddb5",
                            "on-tertiary-container": "#d18900",
                            "on-surface-variant": "#45464e",
                            "surface-container-highest": "#e1e3e4"
                        },
                        "borderRadius": {
                            "DEFAULT": "0.125rem",
                            "lg": "0.25rem",
                            "xl": "0.5rem",
                            "full": "0.75rem"
                        },
                        "spacing": {
                            "margin-mobile": "16px",
                            "base": "8px",
                            "section-gap": "80px",
                            "margin-desktop": "48px",
                            "gutter": "24px",
                            "container-max": "1280px"
                        },
                        "fontFamily": {
                            "headline-lg": [
                                "Epilogue"
                            ],
                            "body-lg": [
                                "Work Sans"
                            ],
                            "display-lg": [
                                "Epilogue"
                            ],
                            "label-caps": [
                                "Work Sans"
                            ],
                            "body-md": [
                                "Work Sans"
                            ],
                            "headline-md": [
                                "Epilogue"
                            ]
                        },
                        "fontSize": {
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
                            "headline-md": [
                                "24px",
                                {
                                    "lineHeight": "1.3",
                                    "fontWeight": "600"
                                }
                            ]
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
                font-variation-settings: 'FILL' 1, 'wght' 400, 'GRAD' 0, 'opsz' 24;
            }
        </style>
    </head>

    <body class="bg-background text-on-background font-body-md min-h-screen flex flex-col">
        <!-- TopNavBar -->
        <jsp:include page="/WEB-INF/views/includes/header.jsp" />
        <main class="flex-grow">
            <!-- Hero Header -->
            <section
                class="relative h-[409px] min-h-[300px] flex items-center justify-center bg-inverse-surface overflow-hidden">
                <div class="absolute inset-0 z-0">
                    <img alt="A dramatic mountain trail" class="w-full h-full object-cover opacity-60"
                        data-alt="A sweeping, majestic view of a high-altitude mountain trail winding through rugged terrain. The sky is overcast, casting a moody, sophisticated atmosphere over the landscape. The lighting is dramatic, highlighting the textures of the stone and the sheer scale of the environment. The overall visual style is cinematic and premium, utilizing deep, desaturated tones that align perfectly with the modern, exploratory aesthetic of a high-end travel publication. Minimalist, clean, and inspiring."
                        src="https://lh3.googleusercontent.com/aida-public/AB6AXuD4Da5yv4LUfzXH2s7gsqwSs4j153zWezX2IEPTyQBA_10VnUss4JI7Zkh4A80yF3QEN-9hn9Dc2fcuClS_sgACY4RFV8wZEhF8JPwN_ikPKU3qd4YFAXgyN2TdRm7v8hJ5zm_8-8kP_1emcUa8Yl97LOd8wroxNrvwA-sINy9TJ5braovr7Pmr2AAyu6b8m-wQk87dbZX6MaQ0A5KkxtaqCLNafkgiJ9yjCAR2sPwvbvUCMQFetHYUOR7RmIrJBoZGwbjG9RuZ5wc" />
                </div>
                <div class="relative z-10 text-center px-gutter max-w-container-max mx-auto">
                    <h1 class="font-display-lg text-display-lg text-on-primary mb-4">The Story Behind the Journey</h1>
                </div>
            </section>
            <!-- The Mission & Our Audience (Bento Grid Layout) -->
            <section class="max-w-container-max mx-auto px-margin-mobile md:px-margin-desktop py-section-gap">
                <div class="grid grid-cols-1 md:grid-cols-12 gap-gutter">
                    <!-- The Mission -->
                    <div
                        class="md:col-span-7 bg-surface-container-lowest p-8 md:p-12 rounded border border-outline-variant relative overflow-hidden group">
                        <div class="relative z-10">
                            <span
                                class="font-label-caps text-label-caps text-tertiary-container bg-surface-variant px-3 py-1 rounded inline-block mb-6 tracking-widest">Our
                                Mission</span>
                            <h2 class="font-headline-lg text-headline-lg text-primary-container mb-6">Bridging the Gap
                                Between Explores and Audiences</h2>
                            <p class="font-body-lg text-body-lg text-on-surface-variant mb-6">
                                Thoughts of Nomads was born from a desire to elevate the narratives of high-altitude
                                explorers and remote wanderers. We recognized a disconnect between the profound
                                experiences happening in places like Solukhumbu and the stories reaching a global
                                audience.
                            </p>
                            <p class="font-body-lg text-body-lg text-on-surface-variant">
                                Our platform serves as a vital bridge, connecting seasoned guides and authentic
                                travelers with readers who crave substance over spectacle. We are committed to fostering
                                a space where travel journalism is both ethical and deeply compelling, curated through a
                                professional editorial lens.
                            </p>
                        </div>
                    </div>
                    <!-- Our Audience -->
                    <div class="md:col-span-5 flex flex-col gap-gutter">
                        <div class="bg-surface-container-lowest p-8 rounded border border-outline-variant flex-grow">
                            <span
                                class="font-label-caps text-label-caps text-tertiary-container bg-surface-variant px-3 py-1 rounded inline-block mb-6 tracking-widest">The
                                Audience</span>
                            <h3 class="font-headline-md text-headline-md text-primary-container mb-4">For the Curious
                            </h3>
                            <p class="font-body-md text-body-md text-on-surface-variant mb-4">
                                We write for aspiring travelers and digital nomads who seek more than just a
                                destination; they seek context, history, and genuine connection.
                            </p>
                        </div>
                        <div class="bg-surface-container-lowest p-8 rounded border border-outline-variant flex-grow">
                            <span
                                class="font-label-caps text-label-caps text-tertiary-container bg-surface-variant px-3 py-1 rounded inline-block mb-6 tracking-widest">The
                                Contributors</span>
                            <h3 class="font-headline-md text-headline-md text-primary-container mb-4">For the
                                Storytellers</h3>
                            <p class="font-body-md text-body-md text-on-surface-variant">
                                We provide a professional editorial outlet for writers and photographers who demand a
                                rigorous, respectful environment to showcase their journeys.
                            </p>
                        </div>
                    </div>
                </div>
            </section>
            <!-- Aims and Objectives -->
            <section class="bg-surface-container-low py-section-gap">
                <div class="max-w-container-max mx-auto px-margin-mobile md:px-margin-desktop">
                    <div class="text-center mb-16 max-w-3xl mx-auto">
                        <h2 class="font-headline-lg text-headline-lg text-primary-container mb-4">Core Objectives</h2>
                        <p class="font-body-lg text-body-lg text-on-surface-variant">Building a sustainable ecosystem
                            for premium travel journalism.</p>
                    </div>
                    <div class="grid grid-cols-1 md:grid-cols-3 gap-gutter">
                        <!-- Objective 1 -->
                        <div
                            class="bg-surface-container-lowest p-8 rounded border border-outline-variant hover:shadow-[0px_4px_20px_rgba(36,46,84,0.05)] transition-shadow duration-300">
                            <div
                                class="w-12 h-12 bg-primary-container/10 rounded flex items-center justify-center mb-6">
                                <span class="material-symbols-outlined text-primary-container">security</span>
                            </div>
                            <h4 class="font-headline-md text-headline-md text-primary-container mb-4 text-xl">Secure
                                Platform</h4>
                            <p class="font-body-md text-body-md text-on-surface-variant">Provide a secure, role-based
                                platform for travel content management, ensuring data integrity and authorial control.
                            </p>
                        </div>
                        <!-- Objective 2 -->
                        <div
                            class="bg-surface-container-lowest p-8 rounded border border-outline-variant hover:shadow-[0px_4px_20px_rgba(36,46,84,0.05)] transition-shadow duration-300">
                            <div
                                class="w-12 h-12 bg-primary-container/10 rounded flex items-center justify-center mb-6">
                                <span class="material-symbols-outlined text-primary-container">forum</span>
                            </div>
                            <h4 class="font-headline-md text-headline-md text-primary-container mb-4 text-xl">Seamless
                                Communication</h4>
                            <p class="font-body-md text-body-md text-on-surface-variant">Enable seamless communication
                                between authors and editors through a structured, transparent feedback loop.</p>
                        </div>
                        <!-- Objective 3 -->
                        <div
                            class="bg-surface-container-lowest p-8 rounded border border-outline-variant hover:shadow-[0px_4px_20px_rgba(36,46,84,0.05)] transition-shadow duration-300">
                            <div
                                class="w-12 h-12 bg-primary-container/10 rounded flex items-center justify-center mb-6">
                                <span class="material-symbols-outlined text-primary-container">library_books</span>
                            </div>
                            <h4 class="font-headline-md text-headline-md text-primary-container mb-4 text-xl">Ethical
                                Archive</h4>
                            <p class="font-body-md text-body-md text-on-surface-variant">Maintain an ethical and
                                high-quality archive of travel journalism that respects the cultures and environments
                                documented.</p>
                        </div>
                    </div>
                </div>
            </section>
            <!-- Institutional Context -->
            <section class="max-w-container-max mx-auto px-margin-mobile md:px-margin-desktop py-12">
                <div class="bg-surface p-6 rounded border border-outline-variant flex items-center gap-4">
                    <span class="material-symbols-outlined text-outline">school</span>
                    <p class="font-body-md text-body-md text-on-surface-variant text-sm">
                        This project was developed as part of the BSc (Hons) Computer System Engineering program,
                        demonstrating a commitment to robust system design and premium user experience.
                    </p>
                </div>
            </section>
        </main>
        <!-- Footer -->
        <jsp:include page="/WEB-INF/views/includes/footer.jsp" />
    </body>

    </html>