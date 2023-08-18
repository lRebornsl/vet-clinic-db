/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id Int GENERATED ALWAYS AS IDENTITY,
    name varchar(50),
    date_of_birth Date,
    escape_attemps Int,
    neutered boolean,
    weight_kg decimal(4,2)
);

ALTER TABLE animals ADD species varchar(20);

CREATE TABLE owners(
id Int GENERATED ALWAYS AS IDENTITY,
full_name varchar(60),
age Int,
PRIMARY KEY (id)
);

CREATE TABLE species(
id Int GENERATED ALWAYS AS IDENTITY,
name varchar(50),
PRIMARY KEY (id)
);

ALTER TABLE animals ADD PRIMARY KEY (id);

ALTER TABLE animals DROP COLUMN species;

ALTER TABLE animals
ADD COLUMN species_id Int,
ADD CONSTRAINT fk_species FOREIGN KEY(species_id) REFERENCES species(id),
ADD COLUMN owner_id Int,
ADD CONSTRAINT fk_owners FOREIGN KEY(owner_id) REFERENCES owners(id);

CREATE TABLE vets(
id Int GENERATED ALWAYS AS IDENTITY,
name varchar(50),
age Int,
date_of_graduation Date,
PRIMARY KEY (id)
);

CREATE TABLE specializations(
id Int GENERATED ALWAYS AS IDENTITY,
species_id Int,
CONSTRAINT fk_species FOREIGN KEY (species_id) REFERENCES species(id),
vets_id Int,
CONSTRAINT fk_vets FOREIGN KEY (vets_id) REFERENCES vets(id)
);

CREATE TABLE visits(
id Int GENERATED ALWAYS AS IDENTITY,
animal_id Int,
CONSTRAINT fk_animals FOREIGN KEY (animal_id) REFERENCES animals(id),
vets_id Int,
CONSTRAINT fk_vets FOREIGN KEY (vets_id) REFERENCES vets(id),
visit_date Date
);
