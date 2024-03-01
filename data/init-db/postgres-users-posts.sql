--
-- Data to be seeded, when creating a container
-- Uncomment string - ./data/init-db:/docker-entrypoint-initdb.d
-- in the compose.override.yaml
--

CREATE TABLE users
(
    id       SERIAL PRIMARY KEY,
    email    VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    username VARCHAR(100)
);

CREATE TABLE posts
(
    id          SERIAL PRIMARY KEY,
    user_id     INT          NOT NULL,
    title       VARCHAR(255) NOT NULL,
    slug        VARCHAR(255) NOT NULL,
    description TEXT         NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users (id)
);

INSERT INTO users (email, password, username)
VALUES ('user1@example.com', 'password1', 'user1'),
       ('user2@example.com', 'password2', 'user2'),
       ('user3@example.com', 'password3', 'user3');

INSERT INTO posts (user_id, title, slug, description)
VALUES (1, 'Title 1', 'title-1', 'Description 1'),
       (1, 'Title 2', 'title-2', 'Description 2'),
       (1, 'Title 3', 'title-3', 'Description 3'),
       (2, 'Title 4', 'title-4', 'Description 4'),
       (2, 'Title 5', 'title-5', 'Description 5'),
       (3, 'Title 6', 'title-6', 'Description 6');
