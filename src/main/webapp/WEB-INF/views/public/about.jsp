<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <title>About Us - Thoughts of Nomads</title>
    
    <!-- Google Fonts & Icons -->
    <link href="https://fonts.googleapis.com/css2?family=Epilogue:wght@400;600;700&family=Work+Sans:wght@400;600&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet" />

    <style>
        /* ============================================================
           DESIGN TOKENS & RESETS
           ============================================================ */
        :root {
            --primary: #0e193e;
            --primary-container: #242e54;
            --on-primary: #ffffff;
            --surface: #ffffff;
            --surface-container-low: #f3f4f5;
            --surface-container-lowest: #ffffff;
            --surface-variant: #e1e3e4;
            --on-surface: #191c1d;
            --on-surface-variant: #45464e;
            --background: #f8f9fa;
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

        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
            vertical-align: middle;
        }

        /* ============================================================
           ABOUT PAGE COMPONENTS
           ============================================================ */
        .about-layout {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        .about-main { flex-grow: 1; }

        /* Hero Section */
        .about-hero {
            position: relative;
            height: 400px;
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: #000;
            overflow: hidden;
        }
        .about-hero-img {
            position: absolute;
            inset: 0;
            width: 100%;
            height: 100%;
            object-fit: cover;
            opacity: 0.5;
        }
        .about-hero-content {
            position: relative;
            z-index: 10;
            text-align: center;
            padding: 0 24px;
        }
        .about-hero-title {
            font-family: 'Epilogue', sans-serif;
            font-size: 48px;
            font-weight: 700;
            color: #ffffff;
        }

        /* Content Sections */
        .about-section {
            max-width: var(--container-max);
            margin: 0 auto;
            padding: 80px var(--margin-mobile);
        }
        @media (min-width: 768px) {
            .about-section { padding: 80px var(--margin-desktop); }
        }

        .about-grid {
            display: grid;
            grid-template-columns: 1fr;
            gap: 32px;
        }
        @media (min-width: 768px) {
            .about-grid { grid-template-columns: 1.5fr 1fr; }
        }

        /* Mission Card */
        .about-mission-card {
            background-color: var(--surface-container-lowest);
            padding: 48px;
            border-radius: var(--radius);
            border: 1px solid var(--outline-variant);
        }

        .about-label {
            font-size: 10px;
            font-weight: 700;
            color: var(--on-surface-variant);
            background-color: var(--surface-container-low);
            padding: 4px 12px;
            border-radius: var(--radius);
            display: inline-block;
            margin-bottom: 24px;
            text-transform: uppercase;
            letter-spacing: 0.1em;
        }

        .about-section-title {
            font-family: 'Epilogue', sans-serif;
            font-size: 32px;
            font-weight: 700;
            color: var(--primary);
            margin-bottom: 24px;
            line-height: 1.2;
        }

        .about-body-text {
            font-size: 16px;
            color: var(--on-surface-variant);
            margin-bottom: 24px;
            line-height: 1.6;
        }

        /* Audience Cards */
        .about-audience-wrapper {
            display: flex;
            flex-direction: column;
            gap: 24px;
        }
        .about-audience-card {
            background-color: var(--surface-container-lowest);
            padding: 32px;
            border-radius: var(--radius);
            border: 1px solid var(--outline-variant);
        }
        .about-subtitle {
            font-family: 'Epilogue', sans-serif;
            font-size: 20px;
            font-weight: 700;
            color: var(--primary);
            margin-bottom: 16px;
        }

        /* Objectives Section */
        .about-section-alt {
            background-color: var(--surface-container-low);
            padding: 80px 0;
        }
        .about-objectives-header {
            text-align: center;
            margin-bottom: 64px;
        }
        .about-objectives-grid {
            display: grid;
            grid-template-columns: 1fr;
            gap: 24px;
        }
        @media (min-width: 768px) {
            .about-objectives-grid { grid-template-columns: repeat(3, 1fr); }
        }

        .about-objective-card {
            background-color: var(--surface-container-lowest);
            padding: 32px;
            border-radius: var(--radius);
            border: 1px solid var(--outline-variant);
            transition: box-shadow 0.3s ease;
        }
        .about-objective-card:hover {
            box-shadow: 0px 10px 30px rgba(0,0,0,0.05);
        }
        .about-objective-icon-wrapper {
            width: 40px;
            height: 40px;
            background-color: rgba(14, 25, 62, 0.05);
            border-radius: var(--radius);
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 24px;
            color: var(--primary);
        }

        /* Institutional Footer Card */
        .about-institutional-card {
            background-color: var(--surface-container-lowest);
            padding: 24px;
            border-radius: var(--radius);
            border: 1px solid var(--outline-variant);
            display: flex;
            align-items: center;
            gap: 16px;
            margin-top: 48px;
        }
        .about-institutional-card p { font-size: 14px; color: var(--on-surface-variant); }
    </style>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css" />
</head>

<body class="about-layout">
    <!-- TopNavBar -->
    <jsp:include page="/WEB-INF/views/includes/header.jsp" />
    
    <main class="about-main">
        <!-- Hero Header -->
        <section class="about-hero">
            <img alt="Mountain trail" class="about-hero-img" src="https://lh3.googleusercontent.com/aida-public/AB6AXuD4Da5yv4LUfzXH2s7gsqwSs4j153zWezX2IEPTyQBA_10VnUss4JI7Zkh4A80yF3QEN-9hn9Dc2fcuClS_sgACY4RFV8wZEhF8JPwN_ikPKU3qd4YFAXgyN2TdRm7v8hJ5zm_8-8kP_1emcUa8Yl97LOd8wroxNrvwA-sINy9TJ5braovr7Pmr2AAyu6b8m-wQk87dbZX6MaQ0A5KkxtaqCLNafkgiJ9yjCAR2sPwvbvUCMQFetHYUOR7RmIrJBoZGwbjG9RuZ5wc" />
            <div class="about-hero-content">
                <h1 class="about-hero-title">The Story Behind the Journey</h1>
            </div>
        </section>

        <!-- The Mission & Our Audience -->
        <section class="about-section">
            <div class="about-grid">
                <div class="about-mission-card">
                    <span class="about-label">Our Mission</span>
                    <h2 class="about-section-title">Bridging the Gap Between Explorers and Audiences</h2>
                    <p class="about-body-text">
                        Thoughts of Nomads was born from a desire to elevate the narratives of high-altitude explorers and remote wanderers. We recognized a disconnect between the profound experiences happening in places like Solukhumbu and the stories reaching a global audience.
                    </p>
                    <p class="about-body-text">
                        Our platform serves as a vital bridge, connecting seasoned guides and authentic travelers with readers who crave substance over spectacle.
                    </p>
                </div>

                <div class="about-audience-wrapper">
                    <div class="about-audience-card">
                        <span class="about-label">The Audience</span>
                        <h3 class="about-subtitle">For the Curious</h3>
                        <p class="about-body-text" style="font-size: 14px; margin-bottom: 0;">
                            We write for aspiring travelers and digital nomads who seek more than just a destination; they seek context, history, and genuine connection.
                        </p>
                    </div>
                    <div class="about-audience-card">
                        <span class="about-label">The Contributors</span>
                        <h3 class="about-subtitle">For the Storytellers</h3>
                        <p class="about-body-text" style="font-size: 14px; margin-bottom: 0;">
                            We provide a professional editorial outlet for writers and photographers who demand a rigorous, respectful environment to showcase their journeys.
                        </p>
                    </div>
                </div>
            </div>
        </section>

        <!-- Aims and Objectives -->
        <section class="about-section-alt">
            <div class="about-section" style="padding-top: 0; padding-bottom: 0;">
                <div class="about-objectives-header">
                    <h2 class="about-section-title">Core Objectives</h2>
                    <p class="about-body-text">Building a sustainable ecosystem for premium travel journalism.</p>
                </div>
                
                <div class="about-objectives-grid">
                    <div class="about-objective-card">
                        <div class="about-objective-icon-wrapper">
                            <span class="material-symbols-outlined">security</span>
                        </div>
                        <h4 class="about-subtitle">Secure Platform</h4>
                        <p class="about-body-text" style="font-size: 14px;">Provide a secure, role-based platform for content management, ensuring data integrity.</p>
                    </div>

                    <div class="about-objective-card">
                        <div class="about-objective-icon-wrapper">
                            <span class="material-symbols-outlined">forum</span>
                        </div>
                        <h4 class="about-subtitle">Seamless Communication</h4>
                        <p class="about-body-text" style="font-size: 14px;">Enable seamless communication between authors and editors through a structured feedback loop.</p>
                    </div>

                    <div class="about-objective-card">
                        <div class="about-objective-icon-wrapper">
                            <span class="material-symbols-outlined">library_books</span>
                        </div>
                        <h4 class="about-subtitle">Ethical Archive</h4>
                        <p class="about-body-text" style="font-size: 14px;">Maintain an ethical and high-quality archive that respects the cultures documented.</p>
                    </div>
                </div>

                <div class="about-institutional-card">
                    <span class="material-symbols-outlined">school</span>
                    <p>This project was developed as part of the BSc (Hons) program, demonstrating a commitment to robust system design.</p>
                </div>
            </div>
        </section>
    </main>
    
    <!-- Footer -->
    <jsp:include page="/WEB-INF/views/includes/footer.jsp" />
</body>
</html>