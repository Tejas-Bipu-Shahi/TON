<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>

    <html class="light" lang="en">

    <head>
        <meta charset="utf-8" />
        <meta content="width=device-width, initial-scale=1.0" name="viewport" />
        <title>Register - Thoughts of Nomads</title>
        <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
        <link href="https://fonts.googleapis.com" rel="preconnect" />
        <link crossorigin="" href="https://fonts.gstatic.com" rel="preconnect" />
        <link
            href="https://fonts.googleapis.com/css2?family=Epilogue:wght@400;600;700&amp;family=Work+Sans:wght@400;600&amp;display=swap"
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

            input:-webkit-autofill,
            input:-webkit-autofill:hover,
            input:-webkit-autofill:focus,
            input:-webkit-autofill:active {
                -webkit-box-shadow: 0 0 0 30px white inset !important;
            }
        </style>
    </head>

    <body class="bg-background text-on-background h-screen overflow-hidden flex font-body-md text-body-md relative">
        <!-- Left Image Column -->
        <div class="hidden lg:block lg:w-1/2 relative h-full">
            <a class="absolute top-8 left-8 flex items-center gap-2 text-white hover:text-gray-200 transition-colors font-body-md z-10 drop-shadow-md"
                href="<%=request.getContextPath()%>/">
                <span class="material-symbols-outlined">arrow_back</span>
                Back
            </a>
            <img alt="Nomadic landscape" class="absolute inset-0 w-full h-full object-cover"
                src="https://lh3.googleusercontent.com/aida-public/AB6AXuBH-1LiDteL6-NcIQOHohfU76m9_18Mbjekid-LzV-VLhd17CNLueULD_no1A7CDvXTwt-AEDboV9TW4CjLfrFS8hxAnK8gF7s7u2IDO2ik4AoC4UJYhS4A0f1FKWaSHrGKM_5SCxa5CDGlt_RMl0NsnlNp3AnLh7S0rgcnVTRIW_XJA8xz7MX-IVlF26p4DeQeHJrBQ-RArZq4uTNd98OHfmRKzZNvetJvANgAk55fu2mHYkMFQciBUZHWZiniPKUHZfxUS6xV5I8" />
            <div class="absolute inset-0 bg-black/20 pointer-events-none"></div>
        </div>
        <!-- Main Content Canvas -->
        <main
            class="w-full lg:w-1/2 h-full flex items-center justify-center px-margin-mobile md:px-margin-desktop overflow-y-auto relative py-8">
            <a class="lg:hidden absolute top-6 left-6 flex items-center gap-2 text-on-surface hover:text-primary transition-colors font-body-md z-10"
                href="<%=request.getContextPath()%>/">
                <span class="material-symbols-outlined">arrow_back</span>
                Back
            </a>
            <div
                class="w-full max-w-[600px] bg-surface-container-lowest rounded-DEFAULT border border-outline-variant p-8 md:p-12 my-auto">
                <div class="mb-8 text-center">
                    <h1 class="font-headline-lg text-headline-lg text-primary mb-2">Join Our Community</h1>
                    <p class="font-body-md text-body-md text-on-surface-variant">Become a contributor and share your
                        nomadic journeys.</p>
                </div>
                <% if (request.getAttribute("error") !=null) { %>
                    <!-- Validation Message Area -->
                    <div
                        class="bg-error-container text-on-error-container p-4 rounded-DEFAULT border border-error mb-8 flex items-start gap-3">
                        <span class="material-symbols-outlined text-error mt-0.5" data-icon="error">error</span>
                        <div>
                            <h3 class="font-label-caps text-label-caps text-error mb-1">Registration Failed</h3>
                            <p class="font-body-md text-body-md text-on-secondary-fixed">
                                <%= request.getAttribute("error") %>
                            </p>
                        </div>
                    </div>
                    <% } %>
                        <form action="<%=request.getContextPath()%>/auth/register" method="POST" class="space-y-6">
                            <!-- Full Name -->
                            <div>
                                <label class="block font-label-caps text-label-caps text-on-surface mb-2"
                                    for="fullName">Full Name</label>
                                <input
                                    class="w-full bg-surface border-outline-variant text-on-surface rounded-DEFAULT px-4 py-3 focus:outline-none focus:border-primary-container focus:ring-1 focus:ring-primary-container font-body-md text-body-md transition-colors"
                                    id="fullName" name="fullName" type="text" placeholder="John Doe" value="<%= request.getParameter("fullName") != null ? request.getParameter("fullName") : "" %>" />
                            </div>
                            <!-- Email -->
                            <div>
                                <label class="block font-label-caps text-label-caps text-on-surface mb-2"
                                    for="email">Email Address</label>
                                <input
                                    class="w-full bg-surface border-outline-variant text-on-surface rounded-DEFAULT px-4 py-3 focus:outline-none focus:border-primary-container focus:ring-1 focus:ring-primary-container font-body-md text-body-md transition-colors"
                                    id="email" name="email" placeholder="alex@example.com" type="email" value="<%= request.getParameter("email") != null ? request.getParameter("email") : "" %>" />
                            </div>
                            <!-- Contact Number -->
                            <div>
                                <label class="block font-label-caps text-label-caps text-on-surface mb-2"
                                    for="phone">Contact Number</label>
                                <input
                                    class="w-full bg-surface border-outline-variant text-on-surface rounded-DEFAULT px-4 py-3 focus:outline-none focus:border-primary-container focus:ring-1 focus:ring-primary-container font-body-md text-body-md transition-colors"
                                    id="phone" name="phone" placeholder="+1 (555) 000-0000" type="tel" value="<%= request.getParameter("phone") != null ? request.getParameter("phone") : "" %>" />
                            </div>
                            <!-- Password -->
                            <div>
                                <label class="block font-label-caps text-label-caps text-on-surface mb-2"
                                    for="password">Password</label>
                                <div class="relative">
                                    <input
                                        class="w-full bg-surface border-outline-variant text-on-surface rounded-DEFAULT px-4 py-3 focus:outline-none focus:border-primary-container focus:ring-1 focus:ring-primary-container font-body-md text-body-md transition-colors pr-12"
                                        id="password" name="password" placeholder="••••••••" type="password" />
                                    <button
                                        class="absolute right-4 top-1/2 -translate-y-1/2 text-outline hover:text-on-surface transition-colors"
                                        type="button"
                                        onclick="const p=document.getElementById('password'); const i=this.querySelector('span'); if(p.type==='password'){p.type='text';i.innerText='visibility_off';}else{p.type='password';i.innerText='visibility';}">
                                        <span class="material-symbols-outlined text-[20px]"
                                            data-icon="visibility">visibility</span>
                                    </button>
                                </div>
                            </div>
                            <!-- Confirm Password -->
                            <div>
                                <label class="block font-label-caps text-label-caps text-on-surface mb-2"
                                    for="confirmPassword">Confirm Password</label>
                                <div class="relative">
                                    <input
                                        class="w-full bg-surface border-outline-variant text-on-surface rounded-DEFAULT px-4 py-3 focus:outline-none focus:border-primary-container focus:ring-1 focus:ring-primary-container font-body-md text-body-md transition-colors pr-12"
                                        id="confirmPassword" name="confirmPassword" placeholder="••••••••"
                                        type="password" />
                                    <button
                                        class="absolute right-4 top-1/2 -translate-y-1/2 text-outline hover:text-on-surface transition-colors"
                                        type="button"
                                        onclick="const p=document.getElementById('confirmPassword'); const i=this.querySelector('span'); if(p.type==='password'){p.type='text';i.innerText='visibility_off';}else{p.type='password';i.innerText='visibility';}">
                                        <span class="material-symbols-outlined text-[20px]"
                                            data-icon="visibility">visibility</span>
                                    </button>
                                </div>
                            </div>
                            <!-- CTA -->
                            <div class="pt-4">
                                <button
                                    class="w-full bg-primary-container text-on-primary rounded-DEFAULT py-4 font-label-caps text-label-caps uppercase hover:bg-primary transition-colors duration-200"
                                    type="submit">
                                    Join as a Contributor
                                </button>
                            </div>
                        </form>
                        <div class="mt-8 text-center">
                            <p class="font-body-md text-body-md text-on-surface-variant">
                                Already a member? <a class="text-primary-container hover:underline font-semibold"
                                    href="<%=request.getContextPath()%>/auth/login">Sign in here.</a>
                            </p>
                        </div>
            </div>
        </main>
    </body>

    </html>