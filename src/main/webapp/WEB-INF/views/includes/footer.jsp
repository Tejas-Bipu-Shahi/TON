<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
                <!-- Footer -->
                <section class="w-full bg-surface-container-low py-section-gap">
                        <div class="max-w-container-max mx-auto px-margin-mobile md:px-margin-desktop text-center">
                                <h2 class="font-headline-lg text-headline-lg text-on-surface mb-4">Join the Nomad
                                        Community</h2>
                                <p class="font-body-lg text-body-lg text-on-surface-variant mb-8 max-w-xl mx-auto">
                                        Subscribe to our newsletter for the latest stories and travel insights.</p>
                                <form class="flex flex-col sm:flex-row gap-4 justify-center max-w-lg mx-auto"
                                        onsubmit="return false;">
                                        <input class="flex-grow px-4 py-3 rounded border border-outline-variant bg-surface text-on-surface focus:ring-2 focus:ring-primary focus:border-transparent outline-none transition-all"
                                                placeholder="Your email address" required="" type="email" />
                                        <button class="bg-primary text-on-primary font-label-caps text-label-caps px-8 py-3 rounded uppercase tracking-widest hover:opacity-90 transition-opacity whitespace-nowrap"
                                                type="submit">
                                                Subscribe
                                        </button>
                                </form>
                        </div>
                </section>
                <footer class="bg-[#F8F9FA] dark:bg-slate-950 text-[#242E54] dark:text-slate-200 font-['Epilogue'] text-sm leading-relaxed w-full py-16 border-t border-[#E9ECEF] dark:border-slate-800 flat no shadows opacity-100">
                        <div class="grid grid-cols-1 md:grid-cols-12 gap-8 max-w-7xl mx-auto px-8">
                                <div class="md:col-span-4">
                                        <span class="text-lg font-bold text-[#242E54] dark:text-white mb-4 block">Thoughts
                                                of Nomads</span>
                                        <p class="text-slate-500 dark:text-slate-400 mb-6">© 2024 Thoughts of Nomads.
                                                Editorial Excellence for the Modern Explorer.</p>
                                        <div class="flex gap-4"><a aria-label="Instagram"
                                                        class="text-slate-500 dark:text-slate-400 hover:text-[#242E54] dark:hover:text-white transition-colors"
                                                        href="#">
                                                        <span class="material-symbols-outlined">photo_camera</span>
                                                </a>
                                                <a aria-label="Twitter"
                                                        class="text-slate-500 dark:text-slate-400 hover:text-[#242E54] dark:hover:text-white transition-colors"
                                                        href="#">
                                                        <span class="material-symbols-outlined">share</span>
                                                </a>
                                                <a aria-label="Facebook"
                                                        class="text-slate-500 dark:text-slate-400 hover:text-[#242E54] dark:hover:text-white transition-colors"
                                                        href="#">
                                                        <span class="material-symbols-outlined">public</span>
                                                </a>
                                        </div>
                                </div>
                                <div class="md:col-span-4">
                                        <div class="flex flex-col gap-3">
                                                <a class="text-slate-500 dark:text-slate-400 hover:text-[#242E54] dark:hover:text-white underline underline-offset-4"
                                                        href="<%=request.getContextPath()%>/">Home</a>
                                                <a class="text-slate-500 dark:text-slate-400 hover:text-[#242E54] dark:hover:text-white underline underline-offset-4"
                                                        href="<%=request.getContextPath()%>/category">Categories</a>
                                                <a class="text-slate-500 dark:text-slate-400 hover:text-[#242E54] dark:hover:text-white underline underline-offset-4"
                                                        href="<%=request.getContextPath()%>/latest">Latest</a>
                                        </div>
                                </div>
                                <div class="md:col-span-4">
                                        <div class="flex flex-col gap-3">
                                                <a class="text-slate-500 dark:text-slate-400 hover:text-[#242E54] dark:hover:text-white underline underline-offset-4"
                                                        href="<%=request.getContextPath()%>/about">About Us</a>
                                                <a class="text-slate-500 dark:text-slate-400 hover:text-[#242E54] dark:hover:text-white underline underline-offset-4"
                                                        href="<%=request.getContextPath()%>/contact">Contact Us</a>
                                                <a class="text-slate-500 dark:text-slate-400 hover:text-[#242E54] dark:hover:text-white underline underline-offset-4"
                                                        href="#">Privacy Policy</a>
                                                <a class="text-slate-500 dark:text-slate-400 hover:text-[#242E54] dark:hover:text-white underline underline-offset-4"
                                                        href="#">Terms</a>
                                        </div>
                                </div>
                        </div>
                </footer>
