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
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
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

-- What animals belong to Melody Pond?
SELECT a.name AS animal_name FROM animals a JOIN owners o ON a.owner_id = o.id WHERE o.full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).
SELECT a.name AS animal_name, s.name AS species_name FROM animals a JOIN species s ON a.species_id = s.id WHERE s.name = 'Pokemon';

-- List all owners and their animals, including those that don't own any animal.
SELECT o.full_name AS owner_name, COALESCE(a.name, 'No animal') AS animal_name FROM owners o LEFT JOIN animals a ON o.id = a.owner_id ORDER BY o.full_name;

-- How many animals are there per species?
SELECT s.name AS species_name, COUNT(a.id) AS animal_count FROM species s LEFT JOIN animals a ON s.id = a.species_id GROUP BY s.name ORDER BY species_name;

-- List all Digimon owned by Jennifer Orwell.
SELECT a.name AS digimon_name FROM animals a JOIN owners o ON a.owner_id = o.id JOIN species s ON a.species_id = s.id WHERE o.full_name = 'Jennifer Orwell' AND s.name = 'Digimon';

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT a.name AS animal_name FROM animals a JOIN owners o ON a.owner_id = o.id WHERE o.full_name = 'Dean Winchester' AND a.escape_attempts = 0;

-- Who owns the most animals?
SELECT o.full_name AS owner_name, COUNT(a.id) AS animal_count FROM owners o LEFT JOIN animals a ON o.id = a.owner_id GROUP BY o.full_name ORDER BY animal_count DESC LIMIT 1;

SELECT a.name, vi.date_of_visits 
FROM animals a 
JOIN visits vi ON a.id = vi.animal_id 
JOIN vets ve ON ve.id = vi.vet_id 
WHERE ve.name ='Vet William Tatcher' 
ORDER BY(vi.date_of_visits) DESC LIMIT 1;

SELECT COUNT(DISTINCT(a.name)) AS total_seen
FROM animals a 
JOIN visits vi ON a.id = vi.animal_id 
JOIN vets ve ON vi.vet_id = ve.id 
WHERE ve.name = 'Vet Stephanie Mendez'; 

SELECT ve.name, s.name AS specialties FROM vets ve 
LEFT JOIN specializations sp ON ve.id = sp.vet_id 
LEFT JOIN species s ON s.id = sp.species_id;


SELECT a.name, vi.date_of_visits 
FROM animals a JOIN visits vi ON a.id = vi.animal_id 
JOIN vets v ON vi.vet_id = v.id 
WHERE v.name = 'Vet Stephanie Mendez'
AND vi.date_of_visits BETWEEN '2020-04-01' and '2020-08-30';

SELECT a.name AS most_visited, COUNT(vi.animal_id) 
FROM animals a JOIN visits vi ON a.id = vi.animal_id 
JOIN vets v ON v.id = vi.vet_id 
GROUP BY(vi.animal_id, a.name) 
ORDER BY COUNT(vi.animal_id) DESC LIMIT 1;

SELECT a.name, vi.date_of_visits AS most_visited 
FROM animals a 
JOIN visits vi ON a.id = vi.animal_id 
JOIN vets v ON v.id = vi.vet_id 
WHERE v.name = 'Vet Maisy Smith' 
ORDER BY(vi.date_of_visits) LIMIT 1;

SELECT a.name,v.name AS vet_name, vi.date_of_visits 
FROM animals a JOIN visits vi ON a.id = vi.animal_id 
JOIN vets v ON v.id = vi.vet_id 
ORDER BY(vi.date_of_visits) DESC LIMIT 1;

SELECT COUNT(*) FROM visits 
JOIN animals ON animals.id = visits.animal_id 
JOIN species ON species.id = animals.species_id 
JOIN vets ON vets.id = visits.vet_id 
LEFT JOIN specializations sp ON sp.vet_id = vets.id 
WHERE sp.species_id != animals.species_id OR sp.species_id IS NULL;

SELECT species.name, COUNT(species.id) 
FROM species JOIN animals ON species.id = animals.species_id 
JOIN visits ON visits.animal_id = animals.id 
JOIN vets ON vets.id = visits.vet_id 
WHERE vets.name = 'Vet Maisy Smith' 
GROUP BY(species.id) 
ORDER BY(species.id) DESC LIMIT 1;