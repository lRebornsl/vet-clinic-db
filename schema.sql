/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id Int GENERATED ALWAYS AS IDENTITY,
    name varchar(50),
    date_of_birth Date,
    escape_attemps Int,
    neutered boolean,
    weight_kg decimal(4,2)
);
