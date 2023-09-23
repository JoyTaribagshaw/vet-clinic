
CREATE TABLE animals (
  id serial PRIMARY KEY,
  name varchar(200),
  date_of_birth date,
  escape_attempts integer,
  neutered boolean,
  weight_kg decimal,
);

ALTER TABLE animals ADD COLUMN species VARCHAR(200);

-- Create the "owners" table
CREATE TABLE owners (
  id serial PRIMARY KEY,
  full_name varchar(255),
  age integer
);

-- Insert data into the "owners" table
INSERT INTO owners (full_name, age)
VALUES
  ('Sam Smith', 34),
  ('Jennifer Orwell', 19),
  ('Bob', 45),
  ('Melody Pond', 77),
  ('Dean Winchester', 14),
  ('Jodie Whittaker', 38);

  -- Create the "species" table
CREATE TABLE species (
  id serial PRIMARY KEY,
  name varchar(255)
);

-- Insert data into the "species" table
INSERT INTO species (name)
VALUES
  ('Pokemon'),
  ('Digimon');

  -- Modify the "animals" table
-- Set id as autoincremented PRIMARY KEY
ALTER TABLE animals DROP COLUMN id;

ALTER TABLE animals ADD COLUMN id serial PRIMARY KEY;

-- Remove the "species" column
ALTER TABLE animals DROP COLUMN species;

-- Add column "species_id" as a foreign key referencing the "species" table
ALTER TABLE animals ADD COLUMN species_id integer REFERENCES species(id);

-- Add column "owner_id" as a foreign key referencing the "owners" table
ALTER TABLE animals ADD COLUMN owner_id integer REFERENCES owners(id);
