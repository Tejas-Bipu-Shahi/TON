package com.thoughtsofnomads.dao;

import com.thoughtsofnomads.model.AccountStatus;
import com.thoughtsofnomads.model.Role;
import com.thoughtsofnomads.model.User;
import com.thoughtsofnomads.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

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
}
