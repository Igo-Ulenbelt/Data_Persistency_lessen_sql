-- ------------------------------------------------------------------------
-- Data & Persistency
-- Opdracht S6: Views
--
-- (c) 2020 Hogeschool Utrecht
-- Tijmen Muller (tijmen.muller@hu.nl)
-- André Donk (andre.donk@hu.nl)
-- ------------------------------------------------------------------------


-- S6.1.
--
-- 1. Maak een view met de naam "deelnemers" waarmee je de volgende gegevens uit de tabellen inschrijvingen en uitvoering combineert:
--    inschrijvingen.cursist, inschrijvingen.cursus, inschrijvingen.begindatum, uitvoeringen.docent, uitvoeringen.locatie
CREATE OR REPLACE VIEW deelnemers AS
SELECT i.cursist, i.cursus, i.begindatum, u.docent, u.locatie FROM inschrijvingen i INNER JOIN uitvoeringen u ON i.cursus = u.cursus AND i.begindatum = u.begindatum;
-- 2. Gebruik de view in een query waarbij je de "deelnemers" view combineert met de "personeels" view (behandeld in de les):
CREATE OR REPLACE VIEW personeel AS
SELECT mnr, voorl, naam AS medewerker, afd, functie FROM medewerkers;

SELECT d.cursist, p.medewerker, d.cursus, d.begindatum, d.docent FROM deelnemers d INNER JOIN personeel p ON d.cursist = p.mnr;
-- 3. Is de view "deelnemers" updatable ? Waarom ?
-- De view is niet updatable omdat de view een join bevat tussen de tabellen inschrijvingen en uitvoeringen.

-- S6.2.
--
-- 1. Maak een view met de naam "dagcursussen". Deze view dient de gegevens op te halen: 
--      code, omschrijving en type uit de tabel curssussen met als voorwaarde dat de lengte = 1. Toon aan dat de view werkt.
CREATE OR REPLACE VIEW dagcursussen AS
SELECT code, omschrijving, type FROM cursussen WHERE lengte = 1;
-- 2. Maak een tweede view met de naam "daguitvoeringen". 
--    Deze view dient de uitvoeringsgegevens op te halen voor de "dagcurssussen" (gebruik ook de view "dagcursussen"). Toon aan dat de view werkt
CREATE OR REPLACE VIEW daguitvoeringen AS
SELECT u.cursus, u.begindatum, u.docent, u.locatie FROM uitvoeringen u INNER JOIN dagcursussen dc ON u.cursus = dc.code;
-- 3. Verwijder de views en laat zien wat de verschillen zijn bij DROP view <viewnaam> CASCADE en bij DROP view <viewnaam> RESTRICT
DROP VIEW daguitvoeringen CASCADE;
DROP VIEW dagcursussen RESTRICT;
-- Bij CASCADE worden alle views die afhankelijk zijn van de te verwijderen view ook verwijderd.
-- Bij RESTRICT wordt de view niet verwijderd als er nog views zijn die afhankelijk zijn van de te verwijderen view.
