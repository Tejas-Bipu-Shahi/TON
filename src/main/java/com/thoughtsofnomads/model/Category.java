package com.thoughtsofnomads.model;

public class Category {

    private int id;
    private String name;
    private String slug;
    private String description;
    private Integer parentId;    // null = top-level
    private String  parentName; // populated by JOIN for display
    private int     articleCount;

    public Category() {}

    public Category(String name, String slug, String description, Integer parentId) {
        this.name = name;
        this.slug = slug;
        this.description = description;
        this.parentId = parentId;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getSlug() { return slug; }
    public void setSlug(String slug) { this.slug = slug; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public Integer getParentId() { return parentId; }
    public void setParentId(Integer parentId) { this.parentId = parentId; }

    public String getParentName() { return parentName; }
    public void setParentName(String parentName) { this.parentName = parentName; }

    public int  getArticleCount()          { return articleCount; }
    public void setArticleCount(int count) { this.articleCount = count; }

    public boolean isSubcategory() { return parentId != null && parentId > 0; }
}
