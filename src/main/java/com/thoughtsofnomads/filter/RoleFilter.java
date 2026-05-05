package com.thoughtsofnomads.filter;

import com.thoughtsofnomads.model.Role;
import com.thoughtsofnomads.model.User;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter(urlPatterns = {"/admin/*", "/member/*"})
public class RoleFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/auth/login");
            return;
        }

        String uri = httpRequest.getRequestURI();
        String contextPath = httpRequest.getContextPath();

        boolean isAdminPath = uri.startsWith(contextPath + "/admin/");
        boolean isMemberPath = uri.startsWith(contextPath + "/member/");

        if (isAdminPath && user.getRole() != Role.ADMIN) {
            httpResponse.sendRedirect(contextPath + "/member/dashboard");
            return;
        }

        if (isMemberPath && user.getRole() != Role.CONTRIBUTOR) {
            httpResponse.sendRedirect(contextPath + "/admin/dashboard");
            return;
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {}
}
