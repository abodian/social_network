TRUNCATE TABLE users, posts RESTART IDENTITY; -- replace with your own table name.

INSERT INTO users (username, user_email) VALUES ('David', 'david@gmail.com');
INSERT INTO users (username, user_email) VALUES ('Anna', 'anna@gmail.com');

TRUNCATE TABLE posts RESTART IDENTITY; -- replace with your own table name.

INSERT INTO posts (title, content, views, user_id) VALUES ('Post 1', 'Test content for post 1', '20', '1');
INSERT INTO posts (title, content, views, user_id) VALUES ('Post 2', 'Test content for post 2', '10', '2');