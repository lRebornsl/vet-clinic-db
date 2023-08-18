/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' and '2019-12-31';
SELECT name FROM animals WHERE neutered = true AND escape_attemps < 3;
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT name, escape_attemps FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg >= '10.4' AND weight_kg <= '17.3';

BEGIN;
UPDATE animals
SET species = 'unspecified';
ROLLBACK;

BEGIN;
UPDATE animals
SET species = 'digimon'
WHERE species LIKE '%mon';
UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL;
COMMIT;

BEGIN;
DELETE FROM animals;
ROLLBACK;

BEGIN;
DELETE FROM animals
WHERE date_of_birth > '2022-01-01';
SAVEPOINT first;
UPDATE animals
SET weight_kg = weight_kg * -1;
ROLLBACK TO first;
UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;
COMMIT;

SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attemps = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT neutered, COUNT(*) FROM animals GROUP BY neutered;
SELECT MIN(weight_kg), MAX(weight_kg) FROM animals WHERE species = 'digimon';
SELECT MIN(weight_kg), MAX(weight_kg) FROM animals WHERE species = 'pokemon';
SELECT AVG(escape_attemps) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' AND species = 'digimon';
SELECT AVG(escape_attemps) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' AND species = 'pokemon';

SELECT * FROM animals a INNER JOIN owners o ON a.owner_id = o.id WHERE o.full_name = 'Melody Pond';
SELECT * FROM animals a INNER JOIN species s ON a.species_id = s.id WHERE s.name = 'Pokemon';
SELECT * FROM owners o LEFT JOIN animals a ON o.id = a.owner_id;
SELECT COUNT(*) FROM animals a INNER JOIN species s ON a.species_id = s.id WHERE s.name = 'Pokemon';
SELECT COUNT(*) FROM animals a INNER JOIN species s ON a.species_id = s.id WHERE s.name = 'Digimon';
SELECT * FROM animals a INNER JOIN owners o ON a.owner_id = o.id WHERE a.species_id = 2 AND o.full_name = 'Jennifer Orwell';
SELECT * FROM animals a INNER JOIN owners o ON a.owner_id = o.id WHERE a.escape_attemps = 0 AND o.full_name = 'Dean Winchester';
SELECT o.full_name, COUNT(*) AS animals_owned FROM owners o INNER JOIN animals a ON o.id = a.owner_id GROUP BY o.full_name ORDER BY animals_owned DESC LIMIT 1;

SELECT * FROM animals a INNER JOIN visits v ON a.id = v.animal_id WHERE v.vets_id = 1 ORDER BY v.visit_date DESC LIMIT 1;
SELECT * FROM animals a INNER JOIN visits v ON a.id = v.animal_id WHERE v.vets_id = '3';
SELECT v.name, sp.name FROM vets v LEFT JOIN specializations s ON v.id = s.vets_id LEFT JOIN species sp ON sp.id = s.species_id;
SELECT ve.name, a.name, v.visit_date FROM animals a INNER JOIN visits v ON a.id = v.animal_id INNER JOIN vets ve ON ve.id = v.vets_id WHERE ve.name = 'Stephanie Mendez' AND v.visit_date BETWEEN '2020-04-01' AND '2020-08-30';
SELECT a.name, COUNT(*) AS vets_visited FROM animals a INNER JOIN visits v ON a.id = v.animal_id GROUP BY a.name ORDER BY vets_visited DESC LIMIT 1;
SELECT a.name, v.visit_date FROM animals a INNER JOIN visits v ON a.id = v.animal_id INNER JOIN vets ve ON ve.id = v.vets_id WHERE ve.name = 'Maisy Smith' ORDER BY v.visit_date LIMIT 1;
SELECT a.*, ve.*, v.visit_date FROM animals a INNER JOIN visits v ON a.id = v.animal_id INNER JOIN vets ve ON ve.id = v.vets_id ORDER BY v.visit_date DESC LIMIT 1;
SELECT COUNT(*) FROM visits v INNER JOIN animals a ON a.id = v.animal_id WHERE v.vets_id NOT IN (SELECT s.vets_id FROM specializations s WHERE s.species_id = a.species_id);
SELECT s.name, COUNT(*) AS species_treated FROM visits v INNER JOIN vets ve ON ve.id = v.vets_id INNER JOIN animals a ON a.id = v.animal_id INNER JOIN species s ON s.id = a.species_id WHERE ve.name = 'Maisy Smith' GROUP BY s.name ORDER BY species_treated DESC;
