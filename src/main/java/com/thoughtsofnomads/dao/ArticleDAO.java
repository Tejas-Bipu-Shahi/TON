package com.thoughtsofnomads.dao;

import com.thoughtsofnomads.config.DBConnection;
import com.thoughtsofnomads.model.Article;

import java.io.FileOutputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ArticleDAO {

    private static final String LOG_PATH = "/home/shiro/eclipse-workspace/TON/sql_error.log";

    // ── Member dashboard: per-author stats ───────────────────────────────────

    public int[] getStatsByAuthor(int authorId) {
        // returns [total, published, pending, draft, rejected]
        String sql = "SELECT " +
                     "  COUNT(*) AS total, " +
                     "  SUM(CASE WHEN status='PUBLISHED' THEN 1 ELSE 0 END) AS published, " +
                     "  SUM(CASE WHEN status='PENDING'   THEN 1 ELSE 0 END) AS pending, " +
                     "  SUM(CASE WHEN status='DRAFT'     THEN 1 ELSE 0 END) AS draft, " +
                     "  SUM(CASE WHEN status='REJECTED'  THEN 1 ELSE 0 END) AS rejected " +
                     "FROM articles WHERE author_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, authorId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new int[]{
                        rs.getInt("total"),
                        rs.getInt("published"),
                        rs.getInt("pending"),
                        rs.getInt("draft"),
                        rs.getInt("rejected")
                    };
                }
            }
        } catch (SQLException e) {
            logError(e);
        }
        return new int[]{0, 0, 0, 0, 0};
    }

    public List<Article> getRecentByAuthor(int authorId, int limit) {
        String sql = "SELECT a.article_id, a.title, a.status, a.created_at, a.updated_at, " +
                     "       c.name AS category_name " +
                     "FROM articles a " +
                     "LEFT JOIN categories c ON a.category_id = c.id " +
                     "WHERE a.author_id = ? " +
                     "ORDER BY a.updated_at DESC " +
                     "LIMIT ?";

        List<Article> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, authorId);
            stmt.setInt(2, limit);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Article a = new Article();
                    a.setArticleId(rs.getInt("article_id"));
                    a.setTitle(rs.getString("title"));
                    a.setStatus(rs.getString("status"));
                    a.setCreatedAt(rs.getTimestamp("created_at"));
                    a.setUpdatedAt(rs.getTimestamp("updated_at"));
                    a.setCategoryName(rs.getString("category_name"));
                    list.add(a);
                }
            }
        } catch (SQLException e) {
            logError(e);
        }
        return list;
    }

    // ── Write ─────────────────────────────────────────────────────────────────

    public int createArticle(Article article, List<Integer> tagIds) {
        String sqlA = "INSERT INTO articles (author_id, category_id, title, content, status, cover_image) " +
                      "VALUES (?, ?, ?, ?, ?, ?)";
        String sqlT = "INSERT INTO article_tags (article_id, tag_id) VALUES (?, ?)";

        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);

            int newId;
            try (PreparedStatement sa = conn.prepareStatement(sqlA, java.sql.Statement.RETURN_GENERATED_KEYS)) {
                sa.setInt(1, article.getAuthorId());
                sa.setInt(2, article.getCategoryId());
                sa.setString(3, article.getTitle());
                sa.setString(4, article.getContent());
                sa.setString(5, article.getStatus());
                sa.setString(6, article.getCoverImage());
                sa.executeUpdate();
                try (ResultSet keys = sa.getGeneratedKeys()) {
                    if (!keys.next()) { conn.rollback(); return 0; }
                    newId = keys.getInt(1);
                }
            }

            if (!tagIds.isEmpty()) {
                try (PreparedStatement st = conn.prepareStatement(sqlT)) {
                    for (int tagId : tagIds) {
                        st.setInt(1, newId);
                        st.setInt(2, tagId);
                        st.addBatch();
                    }
                    st.executeBatch();
                }
            }

            conn.commit();
            return newId;
        } catch (SQLException e) {
            if (conn != null) try { conn.rollback(); } catch (SQLException ignored) {}
            logError(e);
            return 0;
        } finally {
            if (conn != null) try { conn.setAutoCommit(true); conn.close(); } catch (SQLException ignored) {}
        }
    }

    public List<Article> getArticlesByAuthor(int authorId) {
        String sql = "SELECT a.article_id, a.author_id, a.title, a.status, a.cover_image, " +
                     "       a.created_at, a.updated_at, a.review_note, a.reviewed_at, " +
                     "       c.name AS category_name " +
                     "FROM articles a " +
                     "LEFT JOIN categories c ON a.category_id = c.id " +
                     "WHERE a.author_id = ? " +
                     "ORDER BY a.updated_at DESC";

        List<Article> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, authorId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Article a = mapRow(rs);
                    list.add(a);
                }
            }
        } catch (SQLException e) {
            logError(e);
        }
        return list;
    }

    // ── Admin: list all articles with optional status filter ─────────────────

    public List<Article> getAllForAdmin(String statusFilter) {
        StringBuilder sql = new StringBuilder(
            "SELECT a.article_id, a.author_id, a.title, a.status, a.cover_image, " +
            "       a.created_at, a.updated_at, a.review_note, a.reviewed_at, " +
            "       c.name AS category_name, " +
            "       COALESCE(p.full_name, u.email) AS author_name " +
            "FROM articles a " +
            "LEFT JOIN categories c ON a.category_id = c.id " +
            "LEFT JOIN users u ON a.author_id = u.user_id " +
            "LEFT JOIN user_profiles p ON a.author_id = p.user_id "
        );
        boolean filtered = statusFilter != null && !statusFilter.isBlank() && !"ALL".equalsIgnoreCase(statusFilter);
        if (filtered) sql.append("WHERE a.status = ? ");
        sql.append("ORDER BY a.updated_at DESC");

        List<Article> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql.toString())) {
            if (filtered) stmt.setString(1, statusFilter.toUpperCase());
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Article a = mapRow(rs);
                    list.add(a);
                }
            }
        } catch (SQLException e) {
            logError(e);
        }
        return list;
    }

    // ── Single article by ID (full fields) ───────────────────────────────────

    public Article getArticleById(int id) {
        String sql = "SELECT a.article_id, a.author_id, a.category_id, a.title, a.content, " +
                     "       a.status, a.cover_image, a.created_at, a.updated_at, " +
                     "       a.review_note, a.reviewed_at, " +
                     "       c.name AS category_name, " +
                     "       COALESCE(p.full_name, u.email) AS author_name " +
                     "FROM articles a " +
                     "LEFT JOIN categories c ON a.category_id = c.id " +
                     "LEFT JOIN users u ON a.author_id = u.user_id " +
                     "LEFT JOIN user_profiles p ON a.author_id = p.user_id " +
                     "WHERE a.article_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Article a = mapRow(rs);
                    a.setContent(rs.getString("content"));
                    a.setCategoryId(rs.getInt("category_id"));
                    return a;
                }
            }
        } catch (SQLException e) {
            logError(e);
        }
        return null;
    }

    public List<Integer> getTagIdsByArticle(int articleId) {
        String sql = "SELECT tag_id FROM article_tags WHERE article_id = ?";
        List<Integer> ids = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, articleId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) ids.add(rs.getInt("tag_id"));
            }
        } catch (SQLException e) {
            logError(e);
        }
        return ids;
    }

    // ── Admin: publish or reject ──────────────────────────────────────────────

    public boolean updateStatus(int articleId, String status, String reviewNote) {
        String sql = "UPDATE articles SET status = ?, review_note = ?, reviewed_at = NOW(), " +
                     "published_at = CASE WHEN ? = 'PUBLISHED' THEN NOW() ELSE published_at END " +
                     "WHERE article_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, status);
            stmt.setString(2, reviewNote);
            stmt.setString(3, status);
            stmt.setInt(4, articleId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            logError(e);
            return false;
        }
    }

    // ── Contributor: edit & resubmit ──────────────────────────────────────────

    public boolean updateArticle(Article article, List<Integer> tagIds) {
        String sqlA = "UPDATE articles SET category_id=?, title=?, content=?, status=?, " +
                      "cover_image = COALESCE(?, cover_image), updated_at=NOW(), " +
                      "review_note=NULL, reviewed_at=NULL " +
                      "WHERE article_id=? AND author_id=?";
        String sqlDel = "DELETE FROM article_tags WHERE article_id=?";
        String sqlIns = "INSERT INTO article_tags (article_id, tag_id) VALUES (?, ?)";

        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);

            try (PreparedStatement sa = conn.prepareStatement(sqlA)) {
                sa.setInt(1, article.getCategoryId());
                sa.setString(2, article.getTitle());
                sa.setString(3, article.getContent());
                sa.setString(4, article.getStatus());
                sa.setString(5, article.getCoverImage());
                sa.setInt(6, article.getArticleId());
                sa.setInt(7, article.getAuthorId());
                if (sa.executeUpdate() == 0) { conn.rollback(); return false; }
            }

            try (PreparedStatement sd = conn.prepareStatement(sqlDel)) {
                sd.setInt(1, article.getArticleId()); sd.executeUpdate();
            }

            if (!tagIds.isEmpty()) {
                try (PreparedStatement si = conn.prepareStatement(sqlIns)) {
                    for (int tagId : tagIds) {
                        si.setInt(1, article.getArticleId()); si.setInt(2, tagId); si.addBatch();
                    }
                    si.executeBatch();
                }
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

    // ── Private row mapper ────────────────────────────────────────────────────

    private Article mapRow(ResultSet rs) throws SQLException {
        Article a = new Article();
        a.setArticleId(rs.getInt("article_id"));
        a.setAuthorId(rs.getInt("author_id"));
        a.setTitle(rs.getString("title"));
        a.setStatus(rs.getString("status"));
        a.setCoverImage(rs.getString("cover_image"));
        a.setCreatedAt(rs.getTimestamp("created_at"));
        a.setUpdatedAt(rs.getTimestamp("updated_at"));
        a.setReviewNote(rs.getString("review_note"));
        a.setReviewedAt(rs.getTimestamp("reviewed_at"));
        a.setCategoryName(rs.getString("category_name"));
        try { a.setAuthorName(rs.getString("author_name")); } catch (SQLException ignored) {}
        return a;
    }

    // ── Helpers ───────────────────────────────────────────────────────────────

    private void logError(SQLException e) {
        try {
            e.printStackTrace(new java.io.PrintStream(new FileOutputStream(LOG_PATH, true)));
        } catch (Exception ignored) {}
        e.printStackTrace();
    }
}
