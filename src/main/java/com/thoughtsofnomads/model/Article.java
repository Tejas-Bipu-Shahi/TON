package com.thoughtsofnomads.model;

import java.sql.Timestamp;

public class Article {
    private int       articleId;
    private int       authorId;
    private int       categoryId;
    private String    title;
    private String    content;
    private String    status;       // DRAFT | PENDING | PUBLISHED | REJECTED
    private String    coverImage;
    private String    reviewNote;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    private Timestamp publishedAt;
    private Timestamp reviewedAt;

    // Joined fields
    private String categoryName;
    private String authorName;

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

    // ── Convenience ───────────────────────────────────────────────────────────

    public boolean isDraft()     { return "DRAFT".equals(status); }
    public boolean isPending()   { return "PENDING".equals(status); }
    public boolean isPublished() { return "PUBLISHED".equals(status); }
    public boolean isRejected()  { return "REJECTED".equals(status); }

    public String getStatusLabel() {
        if (status == null) return "Unknown";
        return status.charAt(0) + status.substring(1).toLowerCase();
    }
}
