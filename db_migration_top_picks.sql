-- Run this once against your database to add the home_top_picks table
CREATE TABLE IF NOT EXISTS home_top_picks (
    id            INT AUTO_INCREMENT PRIMARY KEY,
    article_id    INT NOT NULL UNIQUE,
    display_order INT NOT NULL DEFAULT 0,
    added_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_tp_article FOREIGN KEY (article_id)
        REFERENCES articles(article_id) ON DELETE CASCADE
);
