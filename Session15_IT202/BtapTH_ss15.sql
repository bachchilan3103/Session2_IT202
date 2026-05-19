CREATE DATABASE mini_social_network;
USE mini_social_network;

CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE posts (
    post_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    content TEXT NOT NULL,
    like_count INT DEFAULT 0,
    comment_count INT DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
) ENGINE=InnoDB;

CREATE TABLE comments (
    comment_id INT AUTO_INCREMENT PRIMARY KEY,
    post_id INT NOT NULL,
    user_id INT NOT NULL,
    content TEXT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (post_id) REFERENCES posts(post_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
) ENGINE=InnoDB;

CREATE TABLE friends (
    friendship_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    friend_id INT NOT NULL,
    status VARCHAR(20) CHECK (status IN ('pending', 'accepted')),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (friend_id) REFERENCES users(user_id),
    CONSTRAINT chk_not_self_friend CHECK (user_id != friend_id),
    least_id INT GENERATED ALWAYS AS (LEAST(user_id, friend_id)) STORED,
    greatest_id INT GENERATED ALWAYS AS (GREATEST(user_id, friend_id)) STORED,
    UNIQUE KEY unique_friendship (least_id, greatest_id)
) ENGINE=InnoDB;

CREATE TABLE likes (
    like_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    post_id INT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (post_id) REFERENCES posts(post_id),
    UNIQUE (user_id, post_id)
) ENGINE=InnoDB;

CREATE TABLE post_logs (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    post_id INT,
    post_content TEXT,
    deleted_at DATETIME
) ENGINE=InnoDB;

CREATE FULLTEXT INDEX idx_posts_content ON posts(content);

CREATE VIEW view_user_info AS
SELECT user_id, username, email, created_at
FROM users;

DELIMITER //
CREATE PROCEDURE sp_add_user(IN p_username VARCHAR(50), IN p_password VARCHAR(255), IN p_email VARCHAR(100))
BEGIN
    IF EXISTS (SELECT 1 FROM users WHERE username = p_username OR email = p_email) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Email hoặc Username đã tồn tại';
    ELSE
        INSERT INTO users(username, password, email, created_at)
        VALUES (p_username, p_password, p_email, NOW());
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER tg_after_like_insert
AFTER INSERT ON likes
FOR EACH ROW
BEGIN
    UPDATE posts SET like_count = like_count + 1 WHERE post_id = NEW.post_id;
END //

CREATE TRIGGER tg_after_like_delete
AFTER DELETE ON likes
FOR EACH ROW
BEGIN
    UPDATE posts SET like_count = GREATEST(like_count - 1, 0) WHERE post_id = OLD.post_id;
END //

CREATE TRIGGER tg_after_comment_insert
AFTER INSERT ON comments
FOR EACH ROW
BEGIN
    UPDATE posts SET comment_count = comment_count + 1 WHERE post_id = NEW.post_id;
END //

CREATE TRIGGER tg_after_comment_delete
AFTER DELETE ON comments
FOR EACH ROW
BEGIN
    UPDATE posts SET comment_count = GREATEST(comment_count - 1, 0) WHERE post_id = OLD.post_id;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER tg_before_friend_insert
BEFORE INSERT ON friends
FOR EACH ROW
BEGIN
    IF NEW.user_id = NEW.friend_id THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Không thể kết bạn với chính mình';
    ELSEIF EXISTS (SELECT 1 FROM friends WHERE user_id = NEW.user_id AND friend_id = NEW.friend_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cặp bạn bè đã tồn tại';
    ELSEIF EXISTS (SELECT 1 FROM friends WHERE user_id = NEW.friend_id AND friend_id = NEW.user_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Lời mời đảo chiều đã tồn tại';
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER tg_after_post_delete
AFTER DELETE ON posts
FOR EACH ROW
BEGIN
    INSERT INTO post_logs(post_id, post_content, deleted_at)
    VALUES (OLD.post_id, OLD.content, NOW());
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_user_activity_report()
BEGIN
    SELECT u.user_id, u.username,
           COUNT(DISTINCT p.post_id) AS post_count,
           COUNT(DISTINCT l.like_id) AS like_count,
           COUNT(DISTINCT c.comment_id) AS comment_count
    FROM users u
    LEFT JOIN posts p ON u.user_id = p.user_id
    LEFT JOIN likes l ON u.user_id = l.user_id
    LEFT JOIN comments c ON u.user_id = c.user_id
    GROUP BY u.user_id, u.username;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_delete_user(IN p_user_id INT)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Xóa tài khoản thất bại, dữ liệu đã được phục hồi';
    END;

    START TRANSACTION;
        DELETE FROM likes WHERE user_id = p_user_id;
        DELETE FROM comments WHERE user_id = p_user_id;
        DELETE FROM friends WHERE user_id = p_user_id OR friend_id = p_user_id;
        DELETE FROM posts WHERE user_id = p_user_id;
        DELETE FROM users WHERE user_id = p_user_id;
    COMMIT;
END //
DELIMITER ;

INSERT INTO users(username, password, email) 
VALUES ('alice', '123456', 'alice@mail.com'),
       ('bob', '123456', 'bob@mail.com'),
       ('charlie', '123456', 'charlie@mail.com');

INSERT INTO posts(user_id, content) 
VALUES (1, 'Hello world!'),
       (2, 'My first post'),
       (3, 'Enjoying the sunshine!');

INSERT INTO likes(user_id, post_id) 
VALUES (1, 2), 
       (2, 1), 
       (3, 1);

INSERT INTO comments(user_id, post_id, content) 
VALUES (1, 2, 'Nice post!'),
       (2, 1, 'Welcome!'),
       (3, 3, 'Great day!');

INSERT INTO friends(user_id, friend_id, status) 
VALUES (1, 2, 'accepted'),
	   (2, 3, 'pending');






