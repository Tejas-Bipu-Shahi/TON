package com.thoughtsofnomads.dao;

import com.thoughtsofnomads.config.DBConnection;
import com.thoughtsofnomads.model.Category;

import java.io.FileOutputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class CategoryDAO {

    private static final String LOG_PATH = "/home/shiro/eclipse-workspace/TON/sql_error.log";

    // ── Read ──────────────────────────────────────────────────────────────────

    /**
     * Returns all categories ordered so each parent appears immediately before
     * its children: ORDER BY COALESCE(parent_id, id), parent_id IS NOT NULL, name
     */
    public List<Category> getAllCategories() {
        String sql = "SELECT c.id, c.name, c.slug, c.description, c.parent_id, " +
                     "       p.name AS parent_name " +
                     "FROM categories c " +
                     "LEFT JOIN categories p ON c.parent_id = p.id " +
                     "ORDER BY COALESCE(c.parent_id, c.id), c.parent_id IS NOT NULL, c.name";

        List<Category> list = new ArrayList<>();
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

    public Category getCategoryById(int id) {
        String sql = "SELECT c.id, c.name, c.slug, c.description, c.parent_id, " +
                     "       p.name AS parent_name " +
                     "FROM categories c " +
                     "LEFT JOIN categories p ON c.parent_id = p.id " +
                     "WHERE c.id = ?";

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

    public List<Category> getAllWithArticleCounts() {
        List<Category> all = getAllCategories();
        Map<Integer, Integer>       directCounts = getDirectArticleCounts();
        Map<Integer, List<Integer>> childrenMap  = buildChildrenMap(all);
        for (Category cat : all) {
            cat.setArticleCount(sumRecursive(cat.getId(), childrenMap, directCounts));
        }
        return all;
    }

    public List<Category> getSubcategories(int parentId) {
        List<Category> all = getAllCategories();
        Map<Integer, Integer>       directCounts = getDirectArticleCounts();
        Map<Integer, List<Integer>> childrenMap  = buildChildrenMap(all);

        List<Category> subs = new ArrayList<>();
        for (Category cat : all) {
            if (cat.getParentId() != null && cat.getParentId() == parentId) {
                cat.setArticleCount(sumRecursive(cat.getId(), childrenMap, directCounts));
                subs.add(cat);
            }
        }
        subs.sort(Comparator.comparing(Category::getName));
        return subs;
    }

    // ── Recursive counting helpers ─────────────────────────────────────────────

    private Map<Integer, Integer> getDirectArticleCounts() {
        String sql = "SELECT category_id, COUNT(*) AS cnt FROM articles " +
                     "WHERE status = 'PUBLISHED' GROUP BY category_id";
        Map<Integer, Integer> counts = new HashMap<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                counts.put(rs.getInt("category_id"), rs.getInt("cnt"));
            }
        } catch (SQLException e) {
            logError(e);
        }
        return counts;
    }

    private Map<Integer, List<Integer>> buildChildrenMap(List<Category> all) {
        Map<Integer, List<Integer>> map = new HashMap<>();
        for (Category cat : all) {
            if (cat.getParentId() != null) {
                map.computeIfAbsent(cat.getParentId(), k -> new ArrayList<>()).add(cat.getId());
            }
        }
        return map;
    }

    private int sumRecursive(int catId,
                             Map<Integer, List<Integer>> childrenMap,
                             Map<Integer, Integer> directCounts) {
        int count = directCounts.getOrDefault(catId, 0);
        for (int childId : childrenMap.getOrDefault(catId, Collections.emptyList())) {
            count += sumRecursive(childId, childrenMap, directCounts);
        }
        return count;
    }

    // ── Write ─────────────────────────────────────────────────────────────────

    public boolean addCategory(Category cat) {
        String sql = "INSERT INTO categories (name, slug, description, parent_id) VALUES (?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, cat.getName());
            stmt.setString(2, cat.getSlug());
            stmt.setString(3, cat.getDescription());

            if (cat.getParentId() != null && cat.getParentId() > 0) {
                stmt.setInt(4, cat.getParentId());
            } else {
                stmt.setNull(4, java.sql.Types.INTEGER);
            }

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            logError(e);
            return false;
        }
    }

    public boolean updateCategory(Category cat) {
        String sql = "UPDATE categories SET name = ?, slug = ?, description = ?, parent_id = ? WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, cat.getName());
            stmt.setString(2, cat.getSlug());
            stmt.setString(3, cat.getDescription());

            if (cat.getParentId() != null && cat.getParentId() > 0) {
                stmt.setInt(4, cat.getParentId());
            } else {
                stmt.setNull(4, java.sql.Types.INTEGER);
            }

            stmt.setInt(5, cat.getId());
            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            logError(e);
            return false;
        }
    }

    public boolean deleteCategory(int id) {
        String sql = "DELETE FROM categories WHERE id = ?";

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

    private Category mapRow(ResultSet rs) throws SQLException {
        Category cat = new Category();
        cat.setId(rs.getInt("id"));
        cat.setName(rs.getString("name"));
        cat.setSlug(rs.getString("slug"));
        cat.setDescription(rs.getString("description"));

        int parentId = rs.getInt("parent_id");
        cat.setParentId(rs.wasNull() ? null : parentId);
        cat.setParentName(rs.getString("parent_name"));
        return cat;
    }

    private void logError(SQLException e) {
        try {
            e.printStackTrace(new java.io.PrintStream(new FileOutputStream(LOG_PATH, true)));
        } catch (Exception ignored) {}
        e.printStackTrace();
    }
}
