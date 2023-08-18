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
