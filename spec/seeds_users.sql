TRUNCATE TABLE users RESTART IDENTITY; -- replace with your own table name.

INSERT INTO users (username, user_email) VALUES ('David', 'david@gmail.com');
INSERT INTO users (username, user_email) VALUES ('Anna', 'anna@gmail.com');