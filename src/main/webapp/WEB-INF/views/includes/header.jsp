<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
                <!-- TopNavBar -->
                <nav class="bg-white/95 dark:bg-slate-900/95 backdrop-blur-sm sticky top-0 w-full z-50 border-b border-[#E9ECEF] dark:border-slate-800 flat no shadows text-[#242E54] dark:text-slate-100 font-['Epilogue'] tracking-tight">
                        <div class="flex justify-between items-center max-w-7xl mx-auto px-6 h-20">
                                <div class="text-xl font-bold text-[#242E54] dark:text-white uppercase tracking-widest">
                                        Thoughts of Nomads
                                </div>
                                <div class="hidden md:flex gap-8">
                                        <% 
                                            String currentUri = request.getRequestURI();
                                            String contextPath = request.getContextPath();
                                            
                                            // Handle cases where the request might have been forwarded (e.g. from a Controller)
                                            String forwardUri = (String) request.getAttribute("jakarta.servlet.forward.request_uri");
                                            String checkPath = (forwardUri != null) ? forwardUri : currentUri;
                                            
                                            // Normalize checkPath by removing contextPath
                                            if (checkPath.startsWith(contextPath)) {
                                                checkPath = checkPath.substring(contextPath.length());
                                            }
                                            
                                            String activeClass = "text-[#242E54] dark:text-white border-b-2 border-[#242E54] dark:border-white pb-1 font-semibold";
                                            String inactiveClass = "text-slate-500 dark:text-slate-400 font-medium";
                                            String commonClass = "hover:text-[#242E54] dark:hover:text-white transition-colors duration-200 scale-95 active:scale-90 transition-transform";
                                            
                                            // Check current page with normalized path
                                            boolean isHome = checkPath.equals("/") || checkPath.equals("") || checkPath.equals("/index.jsp");
                                            boolean isCategory = checkPath.startsWith("/category");
                                            boolean isLatest = checkPath.startsWith("/latest");
                                            boolean isAbout = checkPath.startsWith("/about");
                                        %>
                                        <a class="<%= isHome ? activeClass : inactiveClass %> <%= commonClass %>"
                                                href="<%=contextPath%>/">Home</a>
                                        <a class="<%= isCategory ? activeClass : inactiveClass %> <%= commonClass %>"
                                                href="<%=contextPath%>/category">Categories</a>
                                        <a class="<%= isLatest ? activeClass : inactiveClass %> <%= commonClass %>"
                                                href="<%=contextPath%>/latest">Latest</a>
                                        <a class="<%= isAbout ? activeClass : inactiveClass %> <%= commonClass %>"
                                                href="<%=contextPath%>/about">About Us</a>
                                </div>
                                <div class="hidden md:flex gap-4 items-center">
                                        <% if (session.getAttribute("user") !=null) { %>
                                                <a href="<%=request.getContextPath()%>/dashboard"
                                                        class="font-label-caps text-label-caps text-primary border border-primary px-4 py-2 rounded uppercase tracking-widest hover:bg-surface-container-low transition-colors">Dashboard</a>
                                                <a href="<%=request.getContextPath()%>/auth/logout"
                                                        class="font-label-caps text-label-caps bg-primary text-on-primary px-4 py-2 rounded uppercase tracking-widest hover:opacity-90 transition-opacity">Logout</a>
                                                <% } else { %>
                                                        <a href="<%=request.getContextPath()%>/auth/login"
                                                                class="font-label-caps text-label-caps text-primary border border-primary px-4 py-2 rounded uppercase tracking-widest hover:bg-surface-container-low transition-colors">Sign
                                                                In</a>
                                                        <a href="<%=request.getContextPath()%>/auth/register"
                                                                class="font-label-caps text-label-caps bg-primary text-on-primary px-4 py-2 rounded uppercase tracking-widest hover:opacity-90 transition-opacity">Register</a>
                                                        <% } %>
                                </div>
                        </div>
                </nav>
