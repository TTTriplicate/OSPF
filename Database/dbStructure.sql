CREATE DATABASE dijkstra;

CREATE USER 'dijkstra'@'%' IDENTIFIED BY 'G3n3r1cP@ssw0rd!';
GRANT ALL PRIVILEGES ON dijkstra.* TO 'dijkstra'@'%';

USE dijkstra;

CREATE TABLE nodes(
    node_id char primary key
);

CREATE TABLE edges(
    source char,
    destination char,
    weight int,
    foreign key (source) references nodes(node_id),
    foreign key (destination) references nodes(node_id)
);

INSERT INTO nodes(node_id) 
VALUES
    ('a'),
    ('b'), 
    ('c'), 
    ('d'), 
    ('e'), 
    ('f'), 
    ('g'), 
    ('h'),
    ('i');

INSERT INTO edges(source, destination, weight) 
VALUES
    ('a', 'h', 2),
    ('a', 'f', 4),
    ('f', 'h', 3),
    ('f', 'b', 5),
    ('h', 'g', 2),
    ('h', 'c', 3),
    ('b', 'h', 1),
    ('g', 'd', 1),
    ('d', 'e', 3),
    ('i', 'd', 1),
    ('c', 'b', 15),
    ('c', 'i', 2),
    ('e', 'b', 1);