INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES 
        (1 'Agumon', '2020-02-03', 0, TRUE, 10.23),
        (2 'Gabumon', '2018-11-15', 2, TRUE, 8.00),
        (3 'Pikachu', '2021-01-07', 1, FALSE, 15.04),
        (4 'Devimon', '2017-05-12', 5, TRUE, 11.00);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg, species)
VALUES
    (5 'Charmander', '2020-02-08', 0, FALSE, -11, 'Unknown'),
    (6 'Plantmon', '2021-11-15', 2, TRUE, -5.7, 'Unknown'),
    (7 'Squirtle', '1993-04-02', 3, FALSE, -12.13, 'Unknown'),
    (8 'Angemon', '2005-06-12', 1, TRUE, -45, 'Unknown'),
    (9 'Boarmon', '2005-06-07', 7, TRUE, 20.4, 'Unknown'),
    (10 'Blossom', '1998-10-13', 3, TRUE, 17, 'Unknown'),
    (11 'Ditto', '2022-05-14', 4, TRUE, 22, 'Unknown');

    -- Insert data into the "owners" table
INSERT INTO owners (full_name, age) VALUES
    ('Sam Smith', 34),
    ('Jennifer Orwell', 19),
    ('Bob', 45),
    ('Melody Pond', 77),
    ('Dean Winchester', 14),
    ('Jodie Whittaker', 38);

-- Insert data into the "species" table
INSERT INTO species (name) VALUES
    ('Pokemon'),
    ('Digimon');

    -- Update animals to set species_id based on name
UPDATE animals SET species_id = CASE WHEN name like '%mon' THEN 1 ELSE 2 END;

-- Update animals to set owner_id based on name
UPDATE animals SET owner_id = CASE WHEN name = 'Agumon' THEN 1 WHEN name IN ('Gabumon', 'Pikachu') 
THEN 2 WHEN name IN ('Devimon', 'Plantmon') THEN 3 WHEN name IN ('Charmander', 'Squirtle', 'Blossom') 
THEN 4 WHEN name IN ('Angemon', 'Boarmon') THEN 5
END;

INSERT INTO vets(name, age, date_of_graduation) VALUES
('Vet William Tatcher', 45, '2000-04-23'),
('Vet Maisy Smith', 26, '2019-01-17'),
('Vet Stephanie Mendez', 64, '1981-05-04'),
('Vet Jack Harkness', 38, '2008-06-08');

INSERT INTO specializations(species_id, vet_id) VALUES
(1, 1), (1,3), (2,3), (2,4);

INSERT INTO visits(animal_id,vet_id ,date_of_visits) VALUES
(1,1,'2020-05-24'), (1,3,'2020-07-22'), (2,4,'2021-02-02'),
(3,2,'2020-01-05'), (3,2,'2020-03-08'), (3,2,'2020-05-14'),
(4,3,'2021-05-04'), (5,4,'2021-02-24'), (6,2,'2019-12-21'),
(6,1,'2020-08-10'), (6,2,'2021-04-07'), (7,3,'2019-09-29'),
(8,4,'2020-10-03'), (8,4,'2020-11-04'), (9,2,'2019-01-24'),
(9,2,'2019-05-15'), (9,2,'2020-02-27'), (9,2,'2020-08-03'),
(10,3,'2020-05-24'), (10,1,'2021-01-11');
