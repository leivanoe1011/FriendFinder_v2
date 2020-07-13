
DROP DATABASE IF EXISTS FriendFinder_DB;

CREATE DATABASE FriendFinder_DB;

USE FriendFinder_DB;

DROP TABLE IF EXISTS friendFinder;

CREATE TABLE friendFinder
(
    id INT AUTO_INCREMENT NOT NULL,
        PRIMARY KEY(id),
    person_name VARCHAR(255) NOT NULL,
    image_link VARCHAR(4000) NOT NULL,
    question1 INT NOT NULL, -- Your mind is always buzzing with unexplored ideas and plans.
    question2 INT NOT NULL, -- Generally speaking, you rely more on your experience than your imagination.
    question3 INT NOT NULL, -- You find it easy to stay relaxed and focused even when there is some pressure.
    question4 INT NOT NULL, 
    question5 INT NOT NULL, 
    question6 INT NOT NULL, 
    question7 INT NOT NULL, 
    question8 INT NOT NULL, 
    question9 INT NOT NULL, 
    question10 INT NOT NULL
);

-- SELECT * FROM friendFinder
--  SELECT LAST_INSERT_ID() LAST_ID;
