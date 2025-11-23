-- =========================================
-- Script d'initialisation du schéma
-- Base de données : codaSchool
-- Schéma : beerProject
-- =========================================

-- Drop complet du schéma beer_project
DROP SCHEMA IF EXISTS beerProject CASCADE;

-- Recréation du schéma
CREATE SCHEMA beerProject;

-- Utilisation du schéma
SET search_path TO beerProject;

-- -- =========================================
-- -- Table Quartier
-- -- =========================================
CREATE TABLE beerProject.quartier (
    id_quartier SERIAL PRIMARY KEY,
    nom VARCHAR(255) NOT NULL UNIQUE
);

-- -- =========================================
-- -- Table Bar
-- -- =========================================
CREATE TABLE beerProject.bar (
    id_bar SERIAL PRIMARY KEY,
    nom VARCHAR(255) NOT NULL,
    adresse TEXT NOT NULL UNIQUE,
    id_quartier INT NOT NULL,
    FOREIGN KEY (id_quartier) REFERENCES beerProject.quartier(id_quartier)
);

-- -- =========================================
-- -- Table Bière
-- -- =========================================
CREATE TABLE beerProject.biere (
    id_biere SERIAL PRIMARY KEY,
    nom      VARCHAR(100) NOT NULL UNIQUE,
    degre    NUMERIC(3, 1) CHECK (degre >= 0),
    type     VARCHAR(100)
);

-- -- =========================================
-- -- Table Prix
-- -- =========================================
CREATE TABLE beerProject.prix (
    id_prix SERIAL PRIMARY KEY,
    id_biere INT NOT NULL,
    id_bar INT NOT NULL,
    valeur NUMERIC(4,2) NOT NULL CHECK (valeur > 0),
    FOREIGN KEY (id_biere) REFERENCES beerProject.biere(id_biere),
    FOREIGN KEY (id_bar) REFERENCES beerProject.bar(id_bar),

    UNIQUE (id_biere, id_bar)
);