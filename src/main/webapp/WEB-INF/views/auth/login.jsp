<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>

    <html lang="en">

    <head>
        <meta charset="utf-8" />
        <meta content="width=device-width, initial-scale=1.0" name="viewport" />
        <title>Secure Login - Thoughts of Nomads</title>
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
                            "outline-variant": "#c6c5cf",
                            "on-tertiary": "#ffffff",
                            "surface": "#f8f9fa",
                            "on-error": "#ffffff",
                            "surface-bright": "#f8f9fa",
                            "tertiary-container": "#462b00",
                            "background": "#f8f9fa",
                            "on-secondary-fixed-variant": "#82261b",
                            "surface-dim": "#d9dadb",
                            "secondary-fixed-dim": "#ffb4a8",
                            "error-container": "#ffdad6",
                            "on-tertiary-fixed-variant": "#643f00",
                            "on-primary-container": "#8c96c2",
                            "on-secondary-fixed": "#410000",
                            "secondary-container": "#fd8270",
                            "primary-container": "#242e54",
                            "primary": "#0e193e",
                            "on-surface": "#191c1d",
                            "error": "#ba1a1a",
                            "surface-container": "#edeeef",
                            "secondary": "#a23d30",
                            "on-primary-fixed": "#0e193e",
                            "on-primary": "#ffffff",
                            "on-secondary-container": "#731a11",
                            "inverse-primary": "#bbc4f3",
                            "on-tertiary-container": "#d18900",
                            "surface-container-high": "#e7e8e9",
                            "surface-container-low": "#f3f4f5",
                            "on-surface-variant": "#45464e",
                            "primary-fixed-dim": "#bbc4f3",
                            "surface-container-highest": "#e1e3e4",
                            "on-tertiary-fixed": "#2a1800",
                            "on-error-container": "#93000a",
                            "tertiary-fixed": "#ffddb5",
                            "tertiary": "#2a1800",
                            "tertiary-fixed-dim": "#ffb957",
                            "surface-tint": "#535c85",
                            "inverse-surface": "#2e3132",
                            "surface-container-lowest": "#ffffff",
                            "primary-fixed": "#dce1ff",
                            "on-background": "#191c1d",
                            "inverse-on-surface": "#f0f1f2",
                            "surface-variant": "#e1e3e4",
                            "on-primary-fixed-variant": "#3b456c",
                            "outline": "#76767f",
                            "secondary-fixed": "#ffdad4",
                            "on-secondary": "#ffffff"
                        },
                        "borderRadius": {
                            "DEFAULT": "0.125rem",
                            "lg": "0.25rem",
                            "xl": "0.5rem",
                            "full": "0.75rem"
                        },
                        "spacing": {
                            "margin-mobile": "16px",
                            "gutter": "24px",
                            "section-gap": "80px",
                            "base": "8px",
                            "margin-desktop": "48px",
                            "container-max": "1280px"
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
        <style>
            .material-symbols-outlined {
                font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
            }
        </style>
    </head>

    <body class="bg-background text-on-background h-screen overflow-hidden flex flex-col font-body-md antialiased">
        <!-- Main Content -->
        <main class="flex-grow flex flex-col md:flex-row relative h-full">
            <!-- Back Button -->
            <a class="absolute top-4 left-4 md:top-8 md:left-8 z-50 flex items-center gap-2 px-4 py-2 bg-surface text-on-surface border border-outline-variant rounded-full font-label-caps text-label-caps uppercase hover:bg-surface-variant transition-colors shadow-sm"
                href="<%=request.getContextPath()%>/">
                <span class="material-symbols-outlined text-[18px]" data-icon="arrow_back">arrow_back</span>
                Back
            </a>
            <!-- Left Side: Editorial Imagery -->
            <div class="hidden md:block md:w-[45%] lg:w-[55%] relative overflow-hidden bg-surface-container">
                <img alt="Editorial travel photography"
                    class="absolute inset-0 w-full h-full object-cover object-center grayscale-[15%] contrast-[1.1]"
                    data-alt="A sweeping, cinematic landscape photograph of a rugged coastline at dawn, shot from a high vantage point to emphasize scale and adventure. The scene features deep, desaturated blue waters crashing against sharp, dark obsidian rocks, establishing a premium, serious editorial mood. A subtle mist hangs in the air, backlit by a cold, diffused morning light that highlights the textures of the stone. The composition utilizes vast negative space in the overcast sky to convey a sense of disciplined isolation and professional nomadism, perfectly aligning with a modern, high-contrast travel aesthetic."
                    data-location="Coastal Edge"
                    src="https://lh3.googleusercontent.com/aida-public/AB6AXuBN6Upeshm-JuQm69iCqDKAwes0pAorHC3lE72d054emQoOl8kvQfRVe914colmlHEv0l0OMdR4YqTkCJLlJQH2Qiur4gxm51qCtIMEya5xF2s9yGW8nhfDsa3Q7sC5-EYCdKa6UFp0-efLYDjrb91iTPpnue0LSLdrG6NVqOw6_78_QQG6cKxLB4GMGs3R5fbJXH8E8unvCUmNj7CYq4rFwZv3tZsHA7z99UWE4YsWiVMmTeBnTOPprm4XzpIX6qC76ZO_1ac3bxo" />
                <div class="absolute inset-0 bg-gradient-to-r from-primary/20 to-transparent"></div>
            </div>
            <!-- Right Side: Login Canvas -->
            <div
                class="w-full md:w-[55%] lg:w-[45%] flex items-center justify-center p-margin-mobile md:p-gutter lg:p-margin-desktop bg-surface-container-lowest h-full overflow-y-auto">
                <div class="w-full max-w-sm my-auto">
                    <!-- Security Feedback Area -->
                    <% if (request.getAttribute("error") !=null) { %>
                        <!-- Security Feedback Area -->
                        <div
                            class="mb-8 p-4 bg-error-container border border-error/20 rounded-DEFAULT flex items-start gap-3">
                            <span class="material-symbols-outlined text-error" data-icon="lock_clock">lock_clock</span>
                            <div>
                                <h3 class="font-label-caps text-label-caps text-error mb-1 uppercase">Alert</h3>
                                <p class="font-body-md text-[14px] text-on-surface-variant leading-tight">
                                    <%= request.getAttribute("error") %>
                                </p>
                            </div>
                        </div>
                        <% } %>
                            <!-- Header -->
                            <div class="mb-10">
                                <h1 class="font-display-lg text-display-lg text-primary-container mb-3">Sign In</h1>
                                <p class="font-body-lg text-body-lg text-on-surface-variant">Continue your journey with
                                    curated insights.</p>
                            </div>
                            <!-- Form -->
                            <form action="<%=request.getContextPath()%>/auth/login" method="POST" class="space-y-6">
                                <!-- Email Field -->
                                <div class="space-y-2">
                                    <label class="block font-label-caps text-label-caps text-on-surface uppercase"
                                        for="email">Email Address</label>
                                    <input
                                        class="w-full px-4 py-3 bg-surface border border-outline-variant rounded-DEFAULT font-body-md text-body-md text-on-surface focus:outline-none focus:border-primary-container focus:ring-1 focus:ring-primary-container transition-colors"
                                        id="email" name="email" placeholder="nomad@example.com" required=""
                                        type="email" />
                                </div>
                                <!-- Password Field -->
                                <div class="space-y-2">
                                    <div class="flex justify-between items-center">
                                        <label class="block font-label-caps text-label-caps text-on-surface uppercase"
                                            for="password">Password</label>
                                        <a class="font-label-caps text-label-caps text-primary-container hover:underline underline-offset-4 uppercase transition-all"
                                            href="<%=request.getContextPath()%>/auth/forgot-password">Forgot
                                            Password?</a>
                                    </div>
                                    <div class="relative">
                                        <input
                                            class="w-full px-4 py-3 bg-surface border border-outline-variant rounded-DEFAULT font-body-md text-body-md text-on-surface focus:outline-none focus:border-primary-container focus:ring-1 focus:ring-primary-container transition-colors pr-12"
                                            id="password" name="password" placeholder="••••••••" required=""
                                            type="password" />
                                        <button
                                            class="absolute right-4 top-1/2 -translate-y-1/2 text-outline hover:text-on-surface transition-colors"
                                            type="button"
                                            onclick="const p=document.getElementById('password'); const i=this.querySelector('span'); if(p.type==='password'){p.type='text';i.innerText='visibility_off';}else{p.type='password';i.innerText='visibility';}">
                                            <span class="material-symbols-outlined text-[20px]"
                                                data-icon="visibility">visibility</span>
                                        </button>
                                    </div>
                                </div>
                                <!-- Submit Button -->
                                <button
                                    class="w-full mt-8 bg-primary-container text-white py-4 px-6 rounded-DEFAULT font-label-caps text-label-caps uppercase tracking-widest hover:bg-primary transition-colors hover:shadow-[0px_4px_20px_rgba(36,46,84,0.15)] flex justify-center items-center gap-2"
                                    type="submit">
                                    Sign In
                                    <span class="material-symbols-outlined text-[18px]"
                                        data-icon="arrow_forward">arrow_forward</span>
                                </button>
                            </form>
                            <!-- Registration Link -->
                            <div class="mt-10 pt-8 border-t border-outline-variant/30 text-center">
                                <p class="font-body-md text-body-md text-on-surface-variant">
                                    Not a member?
                                    <a class="text-primary-container font-semibold hover:underline underline-offset-4 ml-1"
                                        href="<%=request.getContextPath()%>/auth/register">Register now.</a>
                                </p>
                            </div>
                </div>
            </div>
        </main>
    </body>

    </html>