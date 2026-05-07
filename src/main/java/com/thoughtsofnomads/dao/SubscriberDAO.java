package com.thoughtsofnomads.dao;

import com.thoughtsofnomads.config.DBConnection;
import com.thoughtsofnomads.model.Subscriber;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SubscriberDAO {

    public boolean addSubscriber(String email) {
        String sql = "INSERT IGNORE INTO subscribers (email) VALUES (?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean isSubscribed(String email) {
        String sql = "SELECT 1 FROM subscribers WHERE email = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            try (ResultSet rs = stmt.executeQuery()) { return rs.next(); }
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    public List<Subscriber> getAllSubscribers() {
        String sql = "SELECT subscriber_id, email, subscribed_at FROM subscribers ORDER BY subscribed_at DESC";
        List<Subscriber> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Subscriber s = new Subscriber();
                s.setSubscriberId(rs.getInt("subscriber_id"));
                s.setEmail(rs.getString("email"));
                s.setSubscribedAt(rs.getTimestamp("subscribed_at"));
                list.add(s);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    public int countSubscribers() {
        String sql = "SELECT COUNT(*) FROM subscribers";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return 0;
    }

    public boolean deleteSubscriber(int id) {
        String sql = "DELETE FROM subscribers WHERE subscriber_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }
}
