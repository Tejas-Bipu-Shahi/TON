package com.thoughtsofnomads.model;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class Article {
    private int       articleId;
    private int       authorId;
    private int       categoryId;
    private String    title;
    private String    content;
    private String    status;       // DRAFT → PENDING (submitted) → PUBLISHED or REJECTED
    private String    coverImage;
    private String    reviewNote;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    private Timestamp publishedAt;
    private Timestamp reviewedAt;

    // these come from JOINs — not actual columns in the articles table
    private String categoryName;
    private String authorName;
    private String authorBio;
    private String authorProfilePicture;
    private List<Tag> tags = new ArrayList<>();

    public Article() {}

    // ── Getters / Setters ─────────────────────────────────────────────────────

    public int       getArticleId()    { return articleId; }
    public void      setArticleId(int articleId) { this.articleId = articleId; }

    public int       getAuthorId()     { return authorId; }
    public void      setAuthorId(int authorId) { this.authorId = authorId; }

    public int       getCategoryId()   { return categoryId; }
    public void      setCategoryId(int categoryId) { this.categoryId = categoryId; }

    public String    getTitle()        { return title; }
    public void      setTitle(String title) { this.title = title; }

    public String    getContent()      { return content; }
    public void      setContent(String content) { this.content = content; }

    public String    getStatus()       { return status; }
    public void      setStatus(String status) { this.status = status; }

    public String    getCoverImage()   { return coverImage; }
    public void      setCoverImage(String coverImage) { this.coverImage = coverImage; }

    public String    getReviewNote()   { return reviewNote; }
    public void      setReviewNote(String reviewNote) { this.reviewNote = reviewNote; }

    public Timestamp getCreatedAt()    { return createdAt; }
    public void      setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public Timestamp getUpdatedAt()    { return updatedAt; }
    public void      setUpdatedAt(Timestamp updatedAt) { this.updatedAt = updatedAt; }

    public Timestamp getPublishedAt()  { return publishedAt; }
    public void      setPublishedAt(Timestamp publishedAt) { this.publishedAt = publishedAt; }

    public Timestamp getReviewedAt()   { return reviewedAt; }
    public void      setReviewedAt(Timestamp reviewedAt) { this.reviewedAt = reviewedAt; }

    public String    getCategoryName() { return categoryName; }
    public void      setCategoryName(String categoryName) { this.categoryName = categoryName; }

    public String    getAuthorName()   { return authorName; }
    public void      setAuthorName(String authorName) { this.authorName = authorName; }

    public String    getAuthorBio()    { return authorBio; }
    public void      setAuthorBio(String authorBio) { this.authorBio = authorBio; }

    public String    getAuthorProfilePicture() { return authorProfilePicture; }
    public void      setAuthorProfilePicture(String authorProfilePicture) { this.authorProfilePicture = authorProfilePicture; }

    public List<Tag> getTags()         { return tags; }
    public void      setTags(List<Tag> tags) { this.tags = tags; }

    // ── Convenience ───────────────────────────────────────────────────────────

    public boolean isDraft()     { return "DRAFT".equals(status); }
    public boolean isPending()   { return "PENDING".equals(status); }
    public boolean isPublished() { return "PUBLISHED".equals(status); }
    public boolean isRejected()  { return "REJECTED".equals(status); }

    public String getStatusLabel() {
        if (status == null) return "Unknown";
        return status.charAt(0) + status.substring(1).toLowerCase();
    }

    // strips HTML tags before counting words — articles are stored as HTML from the editor
    public int getReadTimeMinutes() {
        if (content == null || content.isBlank()) return 1;
        String text = content.replaceAll("<[^>]+>", " ").trim();
        int words = text.isEmpty() ? 0 : text.split("\\s+").length;
        return Math.max(1, (int) Math.ceil(words / 200.0)); // average reading speed ~200 wpm
    }
}
