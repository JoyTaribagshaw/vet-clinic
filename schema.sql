
CREATE TABLE animals (
  id serial PRIMARY KEY,
  name varchar(200),
  date_of_birth date,
  escape_attempts integer,
  neutered boolean,
  weight_kg decimal,
);

ALTER TABLE animals ADD COLUMN species VARCHAR(200);
