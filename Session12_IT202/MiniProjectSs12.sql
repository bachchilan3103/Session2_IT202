CREATE DATABASE social_network;
USE social_network;

CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE posts (
    post_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    content TEXT NOT NULL,
    is_deleted BOOLEAN DEFAULT FALSE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
    ON DELETE CASCADE
);

CREATE INDEX idx_posts_created_at
ON posts(created_at);

CREATE TABLE likes (
    user_id INT,
    post_id INT,
    PRIMARY KEY (user_id, post_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
    ON DELETE CASCADE,
    FOREIGN KEY (post_id) REFERENCES posts(post_id)
    ON DELETE CASCADE
);

CREATE TABLE friends (
    user_id INT,
    friend_id INT,
    status VARCHAR(20),
    PRIMARY KEY (user_id, friend_id),
    CHECK (status IN ('pending', 'accepted')),
    CHECK (user_id != friend_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
    ON DELETE CASCADE,
    FOREIGN KEY (friend_id) REFERENCES users(user_id)
    ON DELETE CASCADE
);

INSERT INTO users(username, password, email)
VALUES ('an', '123456', 'an@gmail.com'),
       ('binh', '123456', 'binh@gmail.com'),
	   ('cuong', '123456', 'cuong@gmail.com');

INSERT INTO posts(user_id, content)
VALUES (1, 'Hello everyone'),
       (2, 'My first post'),
       (3, 'Learning MySQL');

INSERT INTO likes(user_id, post_id)
VALUES (2, 1),
       (3, 1),
	   (1, 2);

INSERT INTO friends(user_id, friend_id, status)
VALUES (1, 2, 'accepted'),
       (1, 3, 'pending'),
       (2, 3, 'accepted');

CREATE VIEW view_user_info AS
SELECT user_id, username, email, created_at
FROM users;

CREATE VIEW view_post_statistics AS
SELECT p.post_id, p.content, u.username,
COUNT(DISTINCT l.user_id) AS total_likes
FROM posts AS p
JOIN users AS u
ON p.user_id = u.user_id

LEFT JOIN likes l
ON p.post_id = l.post_id
WHERE p.is_deleted = FALSE

GROUP BY p.post_id, p.content, u.username;

DELIMITER //
CREATE PROCEDURE sp_add_user(IN p_username VARCHAR(50), IN p_password VARCHAR(255), IN p_email VARCHAR(100))
BEGIN
    DECLARE email_count INT;
    SELECT COUNT(*)
    INTO email_count
    FROM users
    WHERE email = p_email;
    IF email_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Email da duoc su dung';
    ELSE

        INSERT INTO users(username, password, email)
        VALUES(p_username, p_password, p_email);
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_create_post(IN p_user_id INT, IN p_content TEXT, OUT p_new_post_id INT)
BEGIN
    INSERT INTO posts(user_id, content)
    VALUES(p_user_id, p_content);
    SET p_new_post_id = LAST_INSERT_ID();
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_get_friends(IN p_user_id INT, IN p_limit INT, IN p_offset INT)
BEGIN
    SELECT u.user_id, u.username, u.email
    FROM friends AS f
    JOIN users AS u
    ON f.friend_id = u.user_id
    WHERE f.user_id = p_user_id
	AND f.status = 'accepted'
    LIMIT p_limit OFFSET p_offset;
END //
DELIMITER ;