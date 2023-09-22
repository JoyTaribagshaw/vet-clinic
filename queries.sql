SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * from animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

-- Transaction 1: Set species to 'unspecified' for animals with names ending in 'mon'
BEGIN;
SELECT * FROM animals WHERE species = 'unspecified';
SELECT * FROM animals;

UPDATE animals
SET species = 'unspecified'
WHERE name LIKE '%mon';


-- Rollback the transaction
ROLLBACK;

-- Verify that changes were rolled back
SELECT * FROM animals;

-- Transaction 2: Set species to 'digimon' for animals with names ending in 'mon', and 'pokemon' for animals with no species
BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';

UPDATE animals SET species = 'pokemon' WHERE species IS NULL OR species = '';

-- Verify the changes
SELECT * FROM animals WHERE species IN ('digimon', 'pokemon');

-- Commit the transaction
COMMIT;

-- Verify that changes persist after commit
SELECT * FROM animals WHERE species IN ('digimon', 'pokemon');

-- Transaction 3: Delete all records and rollback
BEGIN;
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK;

-- Verify if records still exist
SELECT * FROM animals;

-- Transaction 4: Delete records born after Jan 1st, 2022, and update weights
BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT weight_update;
UPDATE animals SET weight_kg = weight_kg * -1;
SELECT * FROM animals;
ROLLBACK TO weight_update;
UPDATE animals SET weight_kg = weight_kg * -1;
SELECT * FROM animals;

-- Commit the transaction
COMMIT;

-- Verify the changes
SELECT * FROM animals;

-- Query 1: How many animals are there?
SELECT COUNT(*) AS total_animals FROM animals;

-- Query 2: How many animals have never tried to escape?
SELECT COUNT(*) AS never_tried_to_escape FROM animals WHERE escape_attempts = 0;

-- Query 3: What is the average weight of animals?
SELECT AVG(weight_kg) AS average_weight FROM animals;

-- Query 4: Who escapes the most, neutered or not neutered animals?
SELECT neutered, MAX(escape_attempts) AS max_escape_attempts FROM animals GROUP BY neutered;

-- Query 5: What is the minimum and maximum weight of each type of animal?
SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight FROM animals GROUP BY species;

-- Query 6: What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) AS avg_escape_attempts FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;

