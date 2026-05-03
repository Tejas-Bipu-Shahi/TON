<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
        <!DOCTYPE html>

        <html class="light" lang="en">

        <head>
                <meta charset="utf-8" />
                <meta content="width=device-width, initial-scale=1.0" name="viewport" />
                <title>Verify Your Identity - Thoughts of Nomads</title>
                <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
                <link href="https://fonts.googleapis.com/css2?family=Epilogue:wght@400;600;700&amp;family=Work+Sans:wght@400;600&amp;display=swap"
                        rel="stylesheet" />
                <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap"
                        rel="stylesheet" />
                <script id="tailwind-config">
                        tailwind.config = {
                                darkMode: "class",
                                theme: {
                                        extend: {
                                                "colors": {
                                                        "tertiary-fixed-dim": "#ffb957",
                                                        "outline-variant": "#c6c5cf",
                                                        "on-tertiary-container": "#d18900",
                                                        "on-secondary-fixed": "#410000",
                                                        "surface-container": "#edeeef",
                                                        "on-secondary": "#ffffff",
                                                        "tertiary-fixed": "#ffddb5",
                                                        "secondary": "#a23d30",
                                                        "on-tertiary": "#ffffff",
                                                        "on-error-container": "#93000a",
                                                        "on-primary-fixed-variant": "#3b456c",
                                                        "on-background": "#191c1d",
                                                        "secondary-fixed-dim": "#ffb4a8",
                                                        "on-secondary-fixed-variant": "#82261b",
                                                        "error-container": "#ffdad6",
                                                        "inverse-on-surface": "#f0f1f2",
                                                        "secondary-fixed": "#ffdad4",
                                                        "on-surface": "#191c1d",
                                                        "surface-container-lowest": "#ffffff",
                                                        "on-primary-fixed": "#0e193e",
                                                        "primary-fixed": "#dce1ff",
                                                        "on-tertiary-fixed": "#2a1800",
                                                        "on-tertiary-fixed-variant": "#643f00",
                                                        "on-surface-variant": "#45464e",
                                                        "on-secondary-container": "#731a11",
                                                        "primary": "#0e193e",
                                                        "surface-variant": "#e1e3e4",
                                                        "surface-container-low": "#f3f4f5",
                                                        "on-error": "#ffffff",
                                                        "surface-container-high": "#e7e8e9",
                                                        "surface-bright": "#f8f9fa",
                                                        "surface-tint": "#535c85",
                                                        "surface-container-highest": "#e1e3e4",
                                                        "inverse-primary": "#bbc4f3",
                                                        "on-primary": "#ffffff",
                                                        "secondary-container": "#fd8270",
                                                        "outline": "#76767f",
                                                        "inverse-surface": "#2e3132",
                                                        "on-primary-container": "#8c96c2",
                                                        "tertiary-container": "#462b00",
                                                        "background": "#f8f9fa",
                                                        "primary-container": "#242e54",
                                                        "surface": "#f8f9fa",
                                                        "surface-dim": "#d9dadb",
                                                        "primary-fixed-dim": "#bbc4f3",
                                                        "tertiary": "#2a1800",
                                                        "error": "#ba1a1a"
                                                },
                                                "borderRadius": {
                                                        "DEFAULT": "0.125rem",
                                                        "lg": "0.25rem",
                                                        "xl": "0.5rem",
                                                        "full": "0.75rem"
                                                },
                                                "spacing": {
                                                        "gutter": "24px",
                                                        "base": "8px",
                                                        "margin-mobile": "16px",
                                                        "margin-desktop": "48px",
                                                        "container-max": "1280px",
                                                        "section-gap": "80px"
                                                },
                                                "fontFamily": {
                                                        "body-md": [
                                                                "Work Sans"
                                                        ],
                                                        "headline-lg": [
                                                                "Epilogue"
                                                        ],
                                                        "display-lg": [
                                                                "Epilogue"
                                                        ],
                                                        "body-lg": [
                                                                "Work Sans"
                                                        ],
                                                        "headline-md": [
                                                                "Epilogue"
                                                        ],
                                                        "label-caps": [
                                                                "Work Sans"
                                                        ]
                                                },
                                                "fontSize": {
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
                                                        "display-lg": [
                                                                "48px",
                                                                {
                                                                        "lineHeight": "1.1",
                                                                        "letterSpacing": "-0.02em",
                                                                        "fontWeight": "700"
                                                                }
                                                        ],
                                                        "body-lg": [
                                                                "18px",
                                                                {
                                                                        "lineHeight": "1.6",
                                                                        "fontWeight": "400"
                                                                }
                                                        ],
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
                                                        ]
                                                }
                                        }
                                }
                        }
                </script>
                <style>
                        .material-symbols-outlined {
                                font-variation-settings:
                                        'FILL' 0,
                                        'wght' 400,
                                        'GRAD' 0,
                                        'opsz' 24
                        }

                        /* Removing arrows from number inputs for clean look */
                        input::-webkit-outer-spin-button,
                        input::-webkit-inner-spin-button {
                                -webkit-appearance: none;
                                margin: 0;
                        }

                        input[type=number] {
                                -moz-appearance: textfield;
                        }
                </style>
        </head>

        <body
                class="bg-surface-container-lowest h-screen w-screen overflow-hidden text-on-surface antialiased relative">
                <!-- Top Action -->
                <button
                        class="absolute top-6 left-6 md:top-8 md:left-8 flex items-center gap-2 text-on-surface-variant hover:text-on-surface transition-colors duration-200 focus:outline-none group z-10">
                        <span
                                class="material-symbols-outlined text-[20px] group-hover:-translate-x-1 transition-transform">arrow_back</span>
                        <span class="font-label-caps text-label-caps uppercase">Back</span>
                </button>
                <div class="flex h-full w-full items-center justify-center p-margin-mobile md:p-margin-desktop">
                        <!-- Main Content Area -->
                        <div class="flex flex-col justify-center max-w-md w-full">
                                <div class="mb-10 text-center w-full">
                                        <h1 class="font-display-lg text-display-lg text-on-surface mb-4">Verify Your
                                                Identity</h1>
                                        <p class="font-body-lg text-body-lg text-on-surface-variant leading-relaxed">
                                                We’ve sent a 6-digit code to <strong
                                                        class="text-on-surface font-semibold">
                                                        <%= session.getAttribute("verificationEmail") !=null ?
                                                                session.getAttribute("verificationEmail") : "your email"
                                                                %>
                                                </strong>. Please enter it below to continue.
                                        </p>
                                </div>
                                <!-- OTP Input Group -->
                                <% if (request.getAttribute("error") !=null) { %>
                                        <div
                                                class="mb-6 p-4 bg-error-container border border-error/20 rounded-DEFAULT text-center">
                                                <p class="font-body-md text-[14px] text-error leading-tight">
                                                        <%= request.getAttribute("error") %>
                                                </p>
                                        </div>
                                        <% } %>
                                                <form action="<%=request.getContextPath()%>/auth/verify" method="POST"
                                                        class="flex flex-col gap-8 w-full" onsubmit="combineOtp()">
                                                        <input type="hidden" name="otp" id="otp_hidden" value="">
                                                        <script>
                                                                function combineOtp() {
                                                                        const inputs = document.querySelectorAll('input[maxlength="1"]');
                                                                        let otpStr = "";
                                                                        inputs.forEach(i => otpStr += i.value);
                                                                        document.getElementById('otp_hidden').value = otpStr;
                                                                }
                                                        </script>
                                                        <div
                                                                class="flex justify-center items-center gap-3 md:gap-4 w-full">
                                                                <input class="w-12 h-16 md:w-14 md:h-16 text-center font-headline-md text-headline-md text-on-surface bg-surface-container-lowest border border-outline-variant rounded-DEFAULT focus:outline-none focus:border-primary focus:ring-1 focus:ring-primary shadow-sm transition-all"
                                                                        maxlength="1" placeholder="•" type="number" />
                                                                <input class="w-12 h-16 md:w-14 md:h-16 text-center font-headline-md text-headline-md text-on-surface bg-surface-container-lowest border border-outline-variant rounded-DEFAULT focus:outline-none focus:border-primary focus:ring-1 focus:ring-primary shadow-sm transition-all"
                                                                        maxlength="1" placeholder="•" type="number" />
                                                                <input class="w-12 h-16 md:w-14 md:h-16 text-center font-headline-md text-headline-md text-on-surface bg-surface-container-lowest border border-outline-variant rounded-DEFAULT focus:outline-none focus:border-primary focus:ring-1 focus:ring-primary shadow-sm transition-all"
                                                                        maxlength="1" placeholder="•" type="number" />
                                                                <input class="w-12 h-16 md:w-14 md:h-16 text-center font-headline-md text-headline-md text-on-surface bg-surface-container-lowest border border-outline-variant rounded-DEFAULT focus:outline-none focus:border-primary focus:ring-1 focus:ring-primary shadow-sm transition-all"
                                                                        maxlength="1" placeholder="•" type="number" />
                                                                <input class="w-12 h-16 md:w-14 md:h-16 text-center font-headline-md text-headline-md text-on-surface bg-surface-container-lowest border border-outline-variant rounded-DEFAULT focus:outline-none focus:border-primary focus:ring-1 focus:ring-primary shadow-sm transition-all"
                                                                        maxlength="1" placeholder="•" type="number" />
                                                                <input class="w-12 h-16 md:w-14 md:h-16 text-center font-headline-md text-headline-md text-on-surface bg-surface-container-lowest border border-outline-variant rounded-DEFAULT focus:outline-none focus:border-primary focus:ring-1 focus:ring-primary shadow-sm transition-all"
                                                                        maxlength="1" placeholder="•" type="number" />
                                                        </div>
                                                        <!-- Primary Action -->
                                                        <button class="w-full bg-primary text-on-primary font-label-caps text-label-caps uppercase tracking-widest py-5 rounded-DEFAULT hover:bg-primary-container transition-colors duration-300 flex justify-center items-center gap-2 mt-2"
                                                                type="submit">
                                                                Verify Code
                                                        </button>
                                                </form>
                                                <!-- Footer Link -->
                                                <div
                                                        class="mt-8 text-center font-body-md text-body-md text-on-surface-variant">
                                                        Didn't receive a code?
                                                        <button
                                                                class="text-primary font-bold hover:text-primary-container transition-colors focus:outline-none underline underline-offset-4 ml-1">
                                                                Resend Code
                                                        </button>
                                                </div>
                        </div>
                </div>
        </body>

        </html>