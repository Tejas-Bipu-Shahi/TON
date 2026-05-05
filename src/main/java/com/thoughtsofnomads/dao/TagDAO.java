package com.thoughtsofnomads.dao;

import com.thoughtsofnomads.config.DBConnection;
import com.thoughtsofnomads.model.Tag;

import java.io.FileOutputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class TagDAO {

    private static final String LOG_PATH = "/home/shiro/eclipse-workspace/TON/sql_error.log";

    // ── Read ──────────────────────────────────────────────────────────────────

    /**
     * Returns all tags with their article count, ordered by name.
     */
    public List<Tag> getAllTags() {
        String sql = "SELECT t.id, t.name, t.slug, COUNT(at.article_id) AS article_count " +
                     "FROM tags t " +
                     "LEFT JOIN article_tags at ON t.id = at.tag_id " +
                     "GROUP BY t.id, t.name, t.slug " +
                     "ORDER BY t.name";

        List<Tag> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (SQLException e) {
            logError(e);
        }
        return list;
    }

    public Tag getTagById(int id) {
        String sql = "SELECT t.id, t.name, t.slug, COUNT(at.article_id) AS article_count " +
                     "FROM tags t " +
                     "LEFT JOIN article_tags at ON t.id = at.tag_id " +
                     "WHERE t.id = ? " +
                     "GROUP BY t.id, t.name, t.slug";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        } catch (SQLException e) {
            logError(e);
        }
        return null;
    }

    // ── Write ─────────────────────────────────────────────────────────────────

    public boolean addTag(Tag tag) {
        String sql = "INSERT INTO tags (name, slug) VALUES (?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, tag.getName());
            stmt.setString(2, tag.getSlug());
            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            logError(e);
            return false;
        }
    }

    public boolean updateTag(Tag tag) {
        String sql = "UPDATE tags SET name = ?, slug = ? WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, tag.getName());
            stmt.setString(2, tag.getSlug());
            stmt.setInt(3, tag.getId());
            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            logError(e);
            return false;
        }
    }

    public boolean deleteTag(int id) {
        String sql = "DELETE FROM tags WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            logError(e);
            return false;
        }
    }

    // ── Helpers ───────────────────────────────────────────────────────────────

    private Tag mapRow(ResultSet rs) throws SQLException {
        Tag tag = new Tag();
        tag.setId(rs.getInt("id"));
        tag.setName(rs.getString("name"));
        tag.setSlug(rs.getString("slug"));
        tag.setArticleCount(rs.getInt("article_count"));
        return tag;
    }

    private void logError(SQLException e) {
        try {
            e.printStackTrace(new java.io.PrintStream(new FileOutputStream(LOG_PATH, true)));
        } catch (Exception ignored) {}
        e.printStackTrace();
    }
}
