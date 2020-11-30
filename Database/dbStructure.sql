CREATE DATABASE dijkstra;

CREATE USER 'dijkstra'@'%' IDENTIFIED BY 'G3n3r1cP@ssw0rd!';
GRANT ALL PRIVILEGES ON dijkstra.* TO 'dijkstra'@'%';

USE dijkstra;

CREATE TABLE nodes(
    node_id char primary key
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


CREATE TABLE edges(
    source char,
    destination char,
    weight int,
    foreign key (source) references nodes(node_id),
    foreign key (destination) references nodes(node_id)
);