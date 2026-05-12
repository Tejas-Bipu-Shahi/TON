package com.thoughtsofnomads.controller;

import com.thoughtsofnomads.dao.UserDAO;
import com.thoughtsofnomads.model.AccountStatus;
import com.thoughtsofnomads.model.Role;
import com.thoughtsofnomads.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.mindrot.jbcrypt.BCrypt;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/users")
public class AdminUsersServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<User> users = userDAO.getAllUsers();
        request.setAttribute("users", users);

        String editIdParam = request.getParameter("editId");
        if (editIdParam != null && !editIdParam.isBlank()) {
            try {
                int editId = Integer.parseInt(editIdParam);
                User toEdit = userDAO.getUserById(editId);
                if (toEdit != null) request.setAttribute("editUser", toEdit);
            } catch (NumberFormatException ignored) {}
        }

        HttpSession session = request.getSession(false);
        if (session != null) {
            request.setAttribute("flashSuccess", session.getAttribute("flashSuccess"));
            request.setAttribute("flashError",   session.getAttribute("flashError"));
            session.removeAttribute("flashSuccess");
            session.removeAttribute("flashError");
        }

        request.setAttribute("adminPageTitle", "Users");
        request.getRequestDispatcher("/WEB-INF/views/admin/users.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String cp = request.getContextPath();

        if ("delete".equals(action))       handleDelete(request, response, cp);
        else if ("edit".equals(action))    handleEdit(request, response, cp);
        else if ("status".equals(action))  handleStatusChange(request, response, cp);
        else                               handleAdd(request, response, cp);
    }

    // ── Handlers ──────────────────────────────────────────────────────────────────

    private void handleAdd(HttpServletRequest req, HttpServletResponse resp, String cp) throws IOException {
        String fullName = trim(req.getParameter("fullName"));
        String email    = trim(req.getParameter("email"));
        String password = trim(req.getParameter("password"));
        String contact  = trim(req.getParameter("contactNumber"));
        String bio      = trim(req.getParameter("bio"));
        Role role       = parseRole(req.getParameter("role"));
        AccountStatus status = parseStatus(req.getParameter("status"));

        if (fullName.isEmpty() || email.isEmpty() || password.isEmpty()) {
            setFlash(req, null, "Full name, email, and password are required.");
            resp.sendRedirect(cp + "/admin/users");
            return;
        }
        if (password.length() < 8) {
            setFlash(req, null, "Password must be at least 8 characters.");
            resp.sendRedirect(cp + "/admin/users");
            return;
        }

        String hash = BCrypt.hashpw(password, BCrypt.gensalt());
        boolean ok = userDAO.adminCreateUser(email, hash, role, status, fullName,
                blank(contact) ? null : contact, blank(bio) ? null : bio);

        if (ok) setFlash(req, "User \"" + fullName + "\" created successfully.", null);
        else    setFlash(req, null, "Failed to create user. Email may already be in use.");
        resp.sendRedirect(cp + "/admin/users");
    }

    private void handleEdit(HttpServletRequest req, HttpServletResponse resp, String cp) throws IOException {
        String idParam  = req.getParameter("id");
        String fullName = trim(req.getParameter("fullName"));
        String email    = trim(req.getParameter("email"));
        String password = trim(req.getParameter("password"));
        String contact  = trim(req.getParameter("contactNumber"));
        String bio      = trim(req.getParameter("bio"));
        Role role       = parseRole(req.getParameter("role"));
        AccountStatus status = parseStatus(req.getParameter("status"));

        if (idParam == null || fullName.isEmpty() || email.isEmpty()) {
            setFlash(req, null, "Invalid edit request.");
            resp.sendRedirect(cp + "/admin/users");
            return;
        }

        try {
            int userId = Integer.parseInt(idParam);
            User self = sessionUser(req);

            // prevent admins from accidentally locking or demoting themselves
            if (self != null && self.getUserId() == userId) {
                if (role != Role.ADMIN) {
                    setFlash(req, null, "You cannot change your own role.");
                    resp.sendRedirect(cp + "/admin/users");
                    return;
                }
                if (status != AccountStatus.ACTIVE) {
                    setFlash(req, null, "You cannot change your own account status.");
                    resp.sendRedirect(cp + "/admin/users");
                    return;
                }
            }

            boolean ok = userDAO.adminUpdateUser(userId, email, role, status, fullName,
                    blank(contact) ? null : contact, blank(bio) ? null : bio);

            if (ok && !password.isEmpty()) {
                if (password.length() < 8) {
                    setFlash(req, "Profile updated, but password not changed — must be 8+ characters.", null);
                    resp.sendRedirect(cp + "/admin/users");
                    return;
                }
                userDAO.adminResetPassword(userId, BCrypt.hashpw(password, BCrypt.gensalt()));
            }

            if (ok) setFlash(req, "User \"" + fullName + "\" updated successfully.", null);
            else    setFlash(req, null, "Failed to update user. Email may already be in use.");

        } catch (NumberFormatException e) {
            setFlash(req, null, "Invalid user ID.");
        }
        resp.sendRedirect(cp + "/admin/users");
    }

    // quick status toggle from the users table — used by admin to manually unlock accounts
    private void handleStatusChange(HttpServletRequest req, HttpServletResponse resp, String cp) throws IOException {
        String idParam     = req.getParameter("userId");
        String statusParam = req.getParameter("newStatus");

        if (idParam == null || statusParam == null) {
            setFlash(req, null, "Invalid status request.");
            resp.sendRedirect(cp + "/admin/users");
            return;
        }

        try {
            int userId = Integer.parseInt(idParam);
            User self = sessionUser(req);
            if (self != null && self.getUserId() == userId) {
                setFlash(req, null, "You cannot change your own account status.");
                resp.sendRedirect(cp + "/admin/users");
                return;
            }

            AccountStatus newStatus = AccountStatus.valueOf(statusParam);
            if (userDAO.updateAccountStatus(userId, newStatus))
                setFlash(req, "Account status updated to " + newStatus.name() + ".", null);
            else
                setFlash(req, null, "Failed to update account status.");

        } catch (IllegalArgumentException e) {
            setFlash(req, null, "Invalid status value.");
        }
        resp.sendRedirect(cp + "/admin/users");
    }

    private void handleDelete(HttpServletRequest req, HttpServletResponse resp, String cp) throws IOException {
        String idParam = req.getParameter("id");
        if (idParam == null) {
            setFlash(req, null, "Invalid delete request.");
            resp.sendRedirect(cp + "/admin/users");
            return;
        }

        try {
            int userId = Integer.parseInt(idParam);
            User self = sessionUser(req);
            if (self != null && self.getUserId() == userId) {
                setFlash(req, null, "You cannot delete your own account.");
                resp.sendRedirect(cp + "/admin/users");
                return;
            }

            if (userDAO.deleteUser(userId)) setFlash(req, "User deleted permanently.", null);
            else                            setFlash(req, null, "User not found or could not be deleted.");

        } catch (NumberFormatException e) {
            setFlash(req, null, "Invalid user ID.");
        }
        resp.sendRedirect(cp + "/admin/users");
    }

    // ── Utilities ─────────────────────────────────────────────────────────────────

    private void setFlash(HttpServletRequest req, String success, String error) {
        HttpSession s = req.getSession();
        if (success != null) s.setAttribute("flashSuccess", success);
        if (error   != null) s.setAttribute("flashError",   error);
    }

    private String trim(String s)       { return s == null ? "" : s.trim(); }
    private boolean blank(String s)     { return s == null || s.isBlank(); }
    private Role parseRole(String s)    { try { return Role.valueOf(s); }          catch (Exception e) { return Role.CONTRIBUTOR; } }
    private AccountStatus parseStatus(String s) { try { return AccountStatus.valueOf(s); } catch (Exception e) { return AccountStatus.ACTIVE; } }
    private User sessionUser(HttpServletRequest req) {
        HttpSession s = req.getSession(false);
        return s != null ? (User) s.getAttribute("user") : null;
    }
}
