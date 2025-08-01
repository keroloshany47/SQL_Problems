DROP DATABASE IF EXISTS social_media;
GO

CREATE DATABASE social_media;
GO

USE social_media;
GO
CREATE TABLE users (
    user_id INT IDENTITY(1,1) PRIMARY KEY,
    username VARCHAR(255) UNIQUE NOT NULL,
    email VARCHAR(30) NOT NULL,
    profile_photo_url VARCHAR(255) DEFAULT 'https://picsum.photos/100',
    bio VARCHAR(255),
    created_at DATETIME DEFAULT GETDATE()
);
GO
CREATE TABLE photos (
    photo_id INT IDENTITY(1,1) PRIMARY KEY,
    photo_url VARCHAR(255) NOT NULL UNIQUE,
    post_id INT NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    size FLOAT
);
GO

ALTER TABLE photos ADD CONSTRAINT chk_photo_size CHECK (size < 5);
GO
CREATE TABLE videos (
    video_id INT IDENTITY(1,1) PRIMARY KEY,
    video_url VARCHAR(255) NOT NULL UNIQUE,
    post_id INT NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    size FLOAT
);
GO

ALTER TABLE videos ADD CONSTRAINT chk_video_size CHECK (size < 10);
GO
CREATE TABLE posts (
    post_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    photo_id INT NULL,
    video_id INT NULL,
    caption VARCHAR(200), 
    location VARCHAR(50),
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (photo_id) REFERENCES photos(photo_id),
    FOREIGN KEY (video_id) REFERENCES videos(video_id)
);
GO
CREATE TABLE comments (
    comment_id INT IDENTITY(1,1) PRIMARY KEY,
    comment_text VARCHAR(255) NOT NULL,
    post_id INT NOT NULL,
    user_id INT NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (post_id) REFERENCES posts(post_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);
GO
CREATE TABLE post_likes (
    user_id INT NOT NULL,
    post_id INT NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    PRIMARY KEY (user_id, post_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (post_id) REFERENCES posts(post_id)
);
GO
CREATE TABLE comment_likes (
    user_id INT NOT NULL,
    comment_id INT NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    PRIMARY KEY (user_id, comment_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (comment_id) REFERENCES comments(comment_id)
);
GO
CREATE TABLE follows (
    follower_id INT NOT NULL,
    followee_id INT NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    PRIMARY KEY (follower_id, followee_id),
    FOREIGN KEY (follower_id) REFERENCES users(user_id),
    FOREIGN KEY (followee_id) REFERENCES users(user_id)
);
GO
CREATE TABLE hashtags (
    hashtag_id INT IDENTITY(1,1) PRIMARY KEY,
    hashtag_name VARCHAR(255) UNIQUE,
    created_at DATETIME DEFAULT GETDATE()
);
GO
CREATE TABLE hashtag_follow (
    user_id INT NOT NULL,
    hashtag_id INT NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    PRIMARY KEY (user_id, hashtag_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (hashtag_id) REFERENCES hashtags(hashtag_id)
);
GO
CREATE TABLE post_tags (
    post_id INT NOT NULL,
    hashtag_id INT NOT NULL,
    PRIMARY KEY (post_id, hashtag_id),
    FOREIGN KEY (post_id) REFERENCES posts(post_id),
    FOREIGN KEY (hashtag_id) REFERENCES hashtags(hashtag_id)
);
GO
CREATE TABLE bookmarks (
    post_id INT NOT NULL,
    user_id INT NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    PRIMARY KEY (user_id, post_id),
    FOREIGN KEY (post_id) REFERENCES posts(post_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);
GO
CREATE TABLE login (
    login_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    ip VARCHAR(50) NOT NULL,
    login_time DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);
GO
