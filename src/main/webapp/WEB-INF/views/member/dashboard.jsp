<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.thoughtsofnomads.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/auth/login");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Thoughts of Nomads</title>
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <link href="https://fonts.googleapis.com/css2?family=Epilogue:wght@400;600;700&family=Work+Sans:wght@400;600&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet">
    <script>
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    colors: {
                        "primary": "#0e193e",
                        "primary-container": "#242e54",
                        "on-primary": "#ffffff",
                        "surface": "#f8f9fa",
                        "surface-container": "#edeeef",
                        "outline": "#76767f"
                    },
                    fontFamily: {
                        "display": ["Epilogue", "sans-serif"],
                        "body": ["Work Sans", "sans-serif"]
                    }
                }
            }
        }
    </script>
</head>
<body class="bg-surface text-gray-800 font-body antialiased">
    <!-- Navbar -->
    <nav class="bg-white border-b border-gray-200 px-6 py-4 flex justify-between items-center">
        <div class="text-xl font-display font-bold text-primary tracking-widest uppercase">
            Thoughts of Nomads
        </div>
        <div class="flex items-center gap-4">
            <span class="text-sm font-semibold"><%= user.getEmail() %></span>
            <a href="<%=request.getContextPath()%>/auth/logout" class="bg-primary text-on-primary px-4 py-2 rounded text-sm uppercase tracking-wider hover:opacity-90 transition-opacity">Logout</a>
        </div>
    </nav>

    <!-- Main Content -->
    <main class="max-w-5xl mx-auto mt-12 px-6">
        <header class="mb-10">
            <h1 class="text-4xl font-display font-bold text-primary mb-2">Welcome back, <%= user.getRole().name() %>!</h1>
            <p class="text-gray-600">This is your personal dashboard. From here, you can manage your contributions and profile.</p>
        </header>

        <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
            <!-- Card 1 -->
            <div class="bg-white p-8 rounded shadow-sm border border-gray-100 hover:shadow-md transition-shadow">
                <span class="material-symbols-outlined text-4xl text-primary-container mb-4">edit_document</span>
                <h2 class="text-2xl font-display font-semibold mb-2">Draft a Story</h2>
                <p class="text-gray-500 mb-6">Start writing your next adventure. Share your journey with the world.</p>
                <button class="bg-primary-container text-white px-6 py-2 rounded uppercase text-sm tracking-wider hover:bg-primary transition-colors">Create Post</button>
            </div>

            <!-- Card 2 -->
            <div class="bg-white p-8 rounded shadow-sm border border-gray-100 hover:shadow-md transition-shadow">
                <span class="material-symbols-outlined text-4xl text-primary-container mb-4">manage_accounts</span>
                <h2 class="text-2xl font-display font-semibold mb-2">Profile Settings</h2>
                <p class="text-gray-500 mb-6">Update your bio, profile picture, and contact information.</p>
                <button class="border border-outline text-gray-700 px-6 py-2 rounded uppercase text-sm tracking-wider hover:bg-gray-50 transition-colors">Edit Profile</button>
            </div>
        </div>
    </main>
</body>
</html>
