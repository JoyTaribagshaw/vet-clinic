CREATE TABLE animals (
id int NOT NULL IDENTITY(1,1),
name varchar(200),
date_of_birth date,
escape_attempts integer,
neutered boolean,
weight_kg decimal
);