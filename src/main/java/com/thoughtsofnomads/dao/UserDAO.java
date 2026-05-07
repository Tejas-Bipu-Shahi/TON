package com.thoughtsofnomads.dao;

import com.thoughtsofnomads.config.DBConnection;
import com.thoughtsofnomads.model.AccountStatus;
import com.thoughtsofnomads.model.Role;
import com.thoughtsofnomads.model.User;
import com.thoughtsofnomads.model.UserProfile;

import java.io.FileOutputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    public boolean registerUser(User user, String fullName, String contactNumber) {
        String insertUserQuery = "INSERT INTO users (email, password_hash, role, account_status) VALUES (?, ?, ?, ?)";
        String insertProfileQuery = "INSERT INTO user_profiles (user_id, full_name, contact_number) VALUES (?, ?, ?)";
        
        Connection conn = null;
        PreparedStatement stmtUser = null;
        PreparedStatement stmtProfile = null;
        ResultSet rs = null;
        
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false); // Start transaction
            
            stmtUser = conn.prepareStatement(insertUserQuery, java.sql.Statement.RETURN_GENERATED_KEYS);
            stmtUser.setString(1, user.getEmail());
            stmtUser.setString(2, user.getPasswordHash());
            stmtUser.setString(3, user.getRole().name());
            stmtUser.setString(4, user.getAccountStatus().name());
            
            int rowsAffected = stmtUser.executeUpdate();
            if (rowsAffected > 0) {
                rs = stmtUser.getGeneratedKeys();
                if (rs.next()) {
                    int userId = rs.getInt(1);
                    
                    stmtProfile = conn.prepareStatement(insertProfileQuery);
                    stmtProfile.setInt(1, userId);
                    stmtProfile.setString(2, fullName);
                    stmtProfile.setString(3, contactNumber);
                    stmtProfile.executeUpdate();
                    
                    conn.commit();
                    return true;
                }
            }
            conn.rollback();
            return false;
            
        } catch (SQLException e) {
            if (conn != null) {
                try { conn.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            }
            try {
                e.printStackTrace(new java.io.PrintStream(new java.io.FileOutputStream("/home/shiro/eclipse-workspace/TON/sql_error.log", true)));
            } catch (Exception logE) {}
            e.printStackTrace();
            return false;
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (stmtProfile != null) stmtProfile.close(); } catch (Exception e) {}
            try { if (stmtUser != null) stmtUser.close(); } catch (Exception e) {}
            try { if (conn != null) { conn.setAutoCommit(true); conn.close(); } } catch (Exception e) {}
        }
    }

    public boolean overrideUnverifiedUser(User user, String fullName, String contactNumber) {
        String updateUserQuery = "UPDATE users SET password_hash = ? WHERE email = ?";
        String updateProfileQuery = "UPDATE user_profiles SET full_name = ?, contact_number = ? WHERE user_id = (SELECT user_id FROM users WHERE email = ?)";
        
        Connection conn = null;
        PreparedStatement stmtUser = null;
        PreparedStatement stmtProfile = null;
        
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);
            
            stmtUser = conn.prepareStatement(updateUserQuery);
            stmtUser.setString(1, user.getPasswordHash());
            stmtUser.setString(2, user.getEmail());
            
            int rowsAffected = stmtUser.executeUpdate();
            if (rowsAffected > 0) {
                stmtProfile = conn.prepareStatement(updateProfileQuery);
                stmtProfile.setString(1, fullName);
                stmtProfile.setString(2, contactNumber);
                stmtProfile.setString(3, user.getEmail());
                stmtProfile.executeUpdate();
                
                conn.commit();
                return true;
            }
            conn.rollback();
            return false;
            
        } catch (SQLException e) {
            if (conn != null) {
                try { conn.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            }
            try {
                e.printStackTrace(new java.io.PrintStream(new java.io.FileOutputStream("/home/shiro/eclipse-workspace/TON/sql_error.log", true)));
            } catch (Exception logE) {}
            e.printStackTrace();
            return false;
        } finally {
            try { if (stmtProfile != null) stmtProfile.close(); } catch (Exception e) {}
            try { if (stmtUser != null) stmtUser.close(); } catch (Exception e) {}
            try { if (conn != null) { conn.setAutoCommit(true); conn.close(); } } catch (Exception e) {}
        }
    }

    public User getUserByEmail(String email) {
        String query = "SELECT * FROM users WHERE email = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setEmail(rs.getString("email"));
                user.setPasswordHash(rs.getString("password_hash"));
                user.setRole(Role.valueOf(rs.getString("role")));
                user.setFailedAttempts(rs.getInt("failed_attempts"));
                user.setAccountStatus(AccountStatus.valueOf(rs.getString("account_status")));
                user.setCreatedAt(rs.getTimestamp("created_at"));
                user.setDisabledAt(rs.getTimestamp("disabled_at"));
                user.setDeletedAt(rs.getTimestamp("deleted_at"));
                return user;
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }



    public boolean activateUser(String email) {
        String query = "UPDATE users SET account_status = 'ACTIVE' WHERE email = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setString(1, email);
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean updatePassword(String email, String newPasswordHash) {
        String query = "UPDATE users SET password_hash = ? WHERE email = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, newPasswordHash);
            stmt.setString(2, email);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // ── Member: Self-service profile ─────────────────────────────────────────────

    public boolean updateProfile(int userId, String fullName, String contactNumber, String bio) {
        String sql = "UPDATE user_profiles SET full_name = ?, contact_number = ?, bio = ? WHERE user_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, fullName);
            stmt.setString(2, blank(contactNumber) ? null : contactNumber);
            stmt.setString(3, blank(bio) ? null : bio);
            stmt.setInt(4, userId);
            stmt.executeUpdate(); // return value is 0 when values are unchanged — still a success
            return true;
        } catch (SQLException e) {
            logError(e);
            return false;
        }
    }

    public boolean updateProfilePicture(int userId, String pictureUrl) {
        String sql = "UPDATE user_profiles SET profile_picture = ? WHERE user_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, blank(pictureUrl) ? null : pictureUrl);
            stmt.setInt(2, userId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            logError(e);
            return false;
        }
    }

    // ── Admin: Read ───────────────────────────────────────────────────────────────

    public List<User> getAllUsers() {
        String sql = "SELECT u.user_id, u.email, u.role, u.account_status, u.failed_attempts, " +
                     "       u.created_at, u.disabled_at, " +
                     "       p.profile_id, p.full_name, p.contact_number, p.bio, p.profile_picture " +
                     "FROM users u " +
                     "LEFT JOIN user_profiles p ON u.user_id = p.user_id " +
                     "ORDER BY u.created_at DESC";
        List<User> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) list.add(mapUserWithProfile(rs));
        } catch (SQLException e) {
            logError(e);
        }
        return list;
    }

    public User getUserById(int id) {
        String sql = "SELECT u.user_id, u.email, u.role, u.account_status, u.failed_attempts, " +
                     "       u.created_at, u.disabled_at, " +
                     "       p.profile_id, p.full_name, p.contact_number, p.bio, p.profile_picture " +
                     "FROM users u " +
                     "LEFT JOIN user_profiles p ON u.user_id = p.user_id " +
                     "WHERE u.user_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) return mapUserWithProfile(rs);
            }
        } catch (SQLException e) {
            logError(e);
        }
        return null;
    }

    // ── Admin: Write ──────────────────────────────────────────────────────────────

    public boolean adminCreateUser(String email, String passwordHash, Role role, AccountStatus status,
                                   String fullName, String contactNumber, String bio) {
        String sqlU = "INSERT INTO users (email, password_hash, role, account_status) VALUES (?, ?, ?, ?)";
        String sqlP = "INSERT INTO user_profiles (user_id, full_name, contact_number, bio) VALUES (?, ?, ?, ?)";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);
            try (PreparedStatement su = conn.prepareStatement(sqlU, java.sql.Statement.RETURN_GENERATED_KEYS)) {
                su.setString(1, email);
                su.setString(2, passwordHash);
                su.setString(3, role.name());
                su.setString(4, status.name());
                su.executeUpdate();
                try (ResultSet keys = su.getGeneratedKeys()) {
                    if (keys.next()) {
                        int uid = keys.getInt(1);
                        try (PreparedStatement sp = conn.prepareStatement(sqlP)) {
                            sp.setInt(1, uid);
                            sp.setString(2, fullName);
                            sp.setString(3, blank(contactNumber) ? null : contactNumber);
                            sp.setString(4, blank(bio) ? null : bio);
                            sp.executeUpdate();
                        }
                        conn.commit();
                        return true;
                    }
                }
            }
            conn.rollback();
            return false;
        } catch (SQLException e) {
            if (conn != null) try { conn.rollback(); } catch (SQLException ignored) {}
            logError(e);
            return false;
        } finally {
            if (conn != null) try { conn.setAutoCommit(true); conn.close(); } catch (SQLException ignored) {}
        }
    }

    public boolean adminUpdateUser(int userId, String email, Role role, AccountStatus status,
                                   String fullName, String contactNumber, String bio) {
        String sqlU = "UPDATE users SET email = ?, role = ?, account_status = ? WHERE user_id = ?";
        String sqlP = "UPDATE user_profiles SET full_name = ?, contact_number = ?, bio = ? WHERE user_id = ?";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);
            try (PreparedStatement su = conn.prepareStatement(sqlU)) {
                su.setString(1, email);
                su.setString(2, role.name());
                su.setString(3, status.name());
                su.setInt(4, userId);
                su.executeUpdate();
            }
            try (PreparedStatement sp = conn.prepareStatement(sqlP)) {
                sp.setString(1, fullName);
                sp.setString(2, blank(contactNumber) ? null : contactNumber);
                sp.setString(3, blank(bio) ? null : bio);
                sp.setInt(4, userId);
                sp.executeUpdate();
            }
            conn.commit();
            return true;
        } catch (SQLException e) {
            if (conn != null) try { conn.rollback(); } catch (SQLException ignored) {}
            logError(e);
            return false;
        } finally {
            if (conn != null) try { conn.setAutoCommit(true); conn.close(); } catch (SQLException ignored) {}
        }
    }

    public boolean adminResetPassword(int userId, String newPasswordHash) {
        String sql = "UPDATE users SET password_hash = ? WHERE user_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, newPasswordHash);
            stmt.setInt(2, userId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            logError(e);
            return false;
        }
    }

    public boolean updateAccountStatus(int userId, AccountStatus newStatus) {
        String sql = "UPDATE users SET account_status = ?, " +
                     "failed_attempts = CASE WHEN ? = 'ACTIVE' THEN 0 ELSE failed_attempts END, " +
                     "disabled_at = CASE WHEN ? = 'ACTIVE' THEN NULL " +
                     "              WHEN disabled_at IS NULL THEN NOW() ELSE disabled_at END " +
                     "WHERE user_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            String s = newStatus.name();
            stmt.setString(1, s);
            stmt.setString(2, s);
            stmt.setString(3, s);
            stmt.setInt(4, userId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            logError(e);
            return false;
        }
    }

    public boolean deleteUser(int userId) {
        String sql = "DELETE FROM users WHERE user_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            logError(e);
            return false;
        }
    }

    // ── Helpers ───────────────────────────────────────────────────────────────────

    private User mapUserWithProfile(ResultSet rs) throws SQLException {
        User user = new User();
        user.setUserId(rs.getInt("user_id"));
        user.setEmail(rs.getString("email"));
        user.setRole(Role.valueOf(rs.getString("role")));
        user.setAccountStatus(AccountStatus.valueOf(rs.getString("account_status")));
        user.setFailedAttempts(rs.getInt("failed_attempts"));
        user.setCreatedAt(rs.getTimestamp("created_at"));
        user.setDisabledAt(rs.getTimestamp("disabled_at"));

        UserProfile profile = new UserProfile();
        profile.setUserId(rs.getInt("user_id"));
        int pid = rs.getInt("profile_id");
        if (!rs.wasNull()) profile.setProfileId(pid);
        profile.setFullName(rs.getString("full_name"));
        profile.setContactNumber(rs.getString("contact_number"));
        profile.setBio(rs.getString("bio"));
        profile.setProfilePicture(rs.getString("profile_picture"));
        user.setProfile(profile);
        return user;
    }

    private boolean blank(String s) { return s == null || s.isBlank(); }

    private void logError(SQLException e) {
        try {
            e.printStackTrace(new java.io.PrintStream(
                new FileOutputStream("/home/shiro/eclipse-workspace/TON/sql_error.log", true)));
        } catch (Exception ignored) {}
        e.printStackTrace();
    }
}
