CREATE TABLE laboratoire_ext(
    id_labo INT PRIMARY KEY NOT NULL,
    nom VARCHAR(100),
    pays VARCHAR(100)
);

CREATE TABLE auteur(
    id_auteur INT PRIMARY KEY NOT NULL,
    nom VARCHAR(100),
    prenom VARCHAR(100),
    id_labo INT,
    CONSTRAINT FK_id_labo FOREIGN KEY (id_labo) REFERENCES laboratoire_ext(id_labo)
);

CREATE TABLE publication(
       id_publication INT PRIMARY KEY NOT NULL,
       titre VARCHAR(100),
       annee_publication INT,
       nom_conf_journal VARCHAR(100),
       classe_conf VARCHAR(30),
       nb_pages INT
);

CREATE TABLE collabore(
    id_auteur INT,
    CONSTRAINT FK_id_auteur FOREIGN KEY (id_auteur) REFERENCES auteur(id_auteur),
    id_publication INT,
    CONSTRAINT FK_idPubli FOREIGN KEY (id_publication) REFERENCES publication(id_publication),
    PRIMARY KEY (id_auteur, id_publication)
);

CREATE TABLE personnel(
    id_personnel INT PRIMARY KEY NOT NULL,
    nom VARCHAR(30),
    prenom VARCHAR(30),
    date_naissance DATE,
    adresse VARCHAR(100),
    date_recrutement DATE
);

CREATE TABLE publie(
    id_personnel INT,
    CONSTRAINT FK_id_personnel FOREIGN KEY (id_personnel) REFERENCES personnel(id_personnel),
    id_publication INT,
    CONSTRAINT FK_id_publication FOREIGN KEY (id_publication) REFERENCES publication(id_publication),
    PRIMARY KEY(id_personnel, id_publication)
);

CREATE TABLE scientifique(
    id_scientifique INT,
    CONSTRAINT FK_id_scientifique FOREIGN KEY (id_scientifique) REFERENCES personnel(id_personnel),
    grade VARCHAR(30),
    PRIMARY KEY (id_scientifique)
);


CREATE TABLE doctorant(
    id_doctorant INT,
    CONSTRAINT FK_id_doctorant FOREIGN KEY (id_doctorant) REFERENCES personnel(id_personnel),
    date_soutenance DATE,
    PRIMARY KEY (id_doctorant)
);

CREATE TABLE encadre(
    id_scientifique INT,
    CONSTRAINT FK_id_scientifique1 FOREIGN KEY (id_scientifique) REFERENCES scientifique(id_scientifique),
    id_doctorant INT,
    CONSTRAINT FK_id_doctorant1 FOREIGN KEY (id_doctorant) REFERENCES doctorant(id_doctorant),
    PRIMARY KEY (id_scientifique, id_doctorant)
);

CREATE TABLE chercheur(
    id_chercheur INT,
    CONSTRAINT FK_id_chercheur FOREIGN KEY (id_chercheur) REFERENCES scientifique(id_scientifique),
    PRIMARY KEY (id_chercheur)
);

CREATE TABLE etablissement(
    id_etablissement INT PRIMARY KEY NOT NULL,
    nom VARCHAR(100),
    acronyme VARCHAR(30),
    adresse VARCHAR(100)
);

CREATE TABLE chercheur_enseignant(
    id_chercheur_enseignant INT,
    CONSTRAINT FK_id_chercheur_enseignant FOREIGN KEY (id_chercheur_enseignant) REFERENCES scientifique(id_scientifique),
    echelon VARCHAR(30),
    id_etablissement INT,
    CONSTRAINT FK_id_etablissement FOREIGN KEY (id_etablissement) REFERENCES etablissement(id_etablissement),
    PRIMARY KEY (id_chercheur_enseignant)
);

CREATE TABLE jpo(
    id_jpo INT PRIMARY KEY NOT NULL,
    date_debut DATE,
    date_fin DATE
);

CREATE TABLE conference(
    id_conference INT PRIMARY KEY NOT NULL,
    date_debut DATE,
    date_fin DATE,
    nb_inscrits INT,
    id_president INT,
    CONSTRAINT FK_id_president FOREIGN KEY (id_president) REFERENCES scientifique(id_scientifique)
);

CREATE TABLE participe_jpo(
    id_personnel INT,
    CONSTRAINT FK_id_personnel1 FOREIGN KEY (id_personnel) REFERENCES personnel(id_personnel),
    id_jpo INT,
    CONSTRAINT FK_id_jpo FOREIGN KEY (id_jpo) REFERENCES jpo(id_jpo),
    PRIMARY KEY (id_personnel, id_jpo)
);

CREATE TABLE projet(
    id_projet INT PRIMARY KEY NOT NULL,
    titre VARCHAR(100),
    acronyme VARCHAR(30),
    annee_debut INT,
    duree INT,
    cout_global FLOAT,
    budget_laas FLOAT,
    id_porteur INT,
    CONSTRAINT FK_id_porteur FOREIGN KEY (id_porteur) REFERENCES scientifique(id_scientifique)
);

CREATE TABLE participe_projet(
    id_scientifique INT,
    CONSTRAINT FK_id_scientifique2 FOREIGN KEY (id_scientifique) REFERENCES scientifique(id_scientifique),
    id_projet INT,
    CONSTRAINT FK_id_projet FOREIGN KEY (id_projet) REFERENCES projet(id_projet),
    PRIMARY KEY (id_scientifique, id_projet)
);

CREATE TABLE partenaire(
    id_partenaire INT PRIMARY KEY NOT NULL,
    nom VARCHAR(30),
    pays VARCHAR(30)
);

CREATE TABLE partenaire_participe(
    id_partenaire INT,
    CONSTRAINT FK_id_partenaire FOREIGN KEY (id_partenaire) REFERENCES partenaire(id_partenaire),
    id_projet INT,
    CONSTRAINT FK_id_projet1 FOREIGN KEY (id_projet) REFERENCES projet(id_projet),
    PRIMARY KEY (id_partenaire, id_projet)
);


INSERT INTO personnel (id_personnel, nom, prenom, date_naissance, adresse, date_recrutement) VALUES
(1, 'Leduc', 'Jean-Christophe', '1987-02-27', '5, rue du Bonheur', '2017-07-06'),
(2, 'Plateau', 'Yvonne', '1996-10-27', '10, avenue du Paradis', '2015-08-27'),
(3, 'Lajoie', 'Jacques', '1984-04-27', '17, impasse de la Cuite', '2017-09-01'),
(4, 'Broutemouton', 'Charles', '1945-11-09', '5 rue de la Laine', '2017-11-13'),
(5, 'Shiondubois', 'Anthony', '1993-05-15', '36, quai du Brouillard', '2014-08-05'),
(6, 'Carotte', 'Bob', '1992-12-19', '2, rue de la Bible', '2012-10-09'),
(7, 'Le Kaillou', 'Pierre', '1980-12-18', '5, avenue du Pin des Landes', '2010-03-09');

INSERT INTO laboratoire_ext (id_labo, nom, pays) VALUES
(1, 'LLC', 'France'),
(2, 'INRA', 'Suisse');

INSERT INTO auteur (id_auteur, nom, prenom, id_labo) VALUES
(1, 'Broklyn', 'Jeff', 1),
(2, 'Tamisier', 'Bruno', 2),
(3, 'Kouloukoukouloukoukou', 'StochStoch', 1);

INSERT INTO scientifique (id_scientifique, grade) VALUES
(1, 'Maître de conférence'),
(3, 'Grade cool'),
(4, 'Grade suprême'),
(7, 'Grade suprême');

INSERT INTO chercheur (id_chercheur) VALUES
(3);

INSERT INTO etablissement (id_etablissement, nom, acronyme, adresse) VALUES
(1, 'INSA Toulouse', 'INSAT', '112, Avenue de Rangueil'),
(2, 'IUT de Toulouse', 'IUTToulouse', '89, Avenue de Rangueil');

INSERT INTO chercheur_enseignant (id_chercheur_enseignant, echelon, id_etablissement) VALUES
(1, 'Echelon 1', 1),
(4, 'Echelon 1', 2),
(7, 'Echelon 2', 1);

INSERT INTO doctorant (id_doctorant, date_soutenance) VALUES
(2, '2017-07-05'),
(5, '2015-12-27'),
(6, '2016-12-03');

INSERT INTO publication (id_publication, titre, annee_publication, nom_conf_journal, classe_conf, nb_pages) VALUES
(1, 'Comment venir à bout de la domination des manchots en Antarctique ?', 1996, 'Conférence sur le réchauffement climatique', 'Classe 1', 1500),
(2, 'Pourquoi être toujours en quête de bonheur ?', 2005, 'Femme libérée', 'Classe 1', 2),
(3, 'Mon petit flocon de neige', 2016, 'Conf\'rence', 'Classe 1', 2),
(4, 'Manier pSQL à la perfection en 10 leçons', 2016, 'Informatique et logiciels libres', 'Classe 1', 100);

INSERT INTO collabore (id_auteur, id_publication) VALUES
(1, 1),
(2, 1),
(2, 2),
(3, 2),
(2, 3),
(3, 3),
(3, 4);

INSERT INTO conference (id_conference, date_debut, date_fin, nb_inscrits, id_president) VALUES
(1, '2017-11-01', '2017-11-02', 50, 1),
(2, '2017-08-01', '2017-08-03', 125, 1);

INSERT INTO encadre (id_scientifique, id_doctorant) VALUES
(1, 2),
(4, 2),
(4, 5);

INSERT INTO jpo (id_jpo, date_debut, date_fin) VALUES
(1, '2017-11-01', '2017-11-02'),
(2, '2017-04-12', '2017-04-13');

INSERT INTO partenaire (id_partenaire, nom, pays) VALUES
(1, 'Partenaire 1', 'France'),
(2, 'Partenaire 2', 'Zimbabwe');

INSERT INTO projet (id_projet, titre, acronyme, annee_debut, duree, cout_global, budget_laas, id_porteur) VALUES
(1, 'Projet super secret', 'PSS', 2017, 12, 1500.5, 2500, 1),
(2, 'Projet un peu moins secret', 'PPMS', 2015, 3, 35000, 30000, 3);

INSERT INTO partenaire_participe (id_partenaire, id_projet) VALUES
(1, 1),
(1, 2),
(2, 2);

INSERT INTO participe_jpo (id_personnel, id_jpo) VALUES
(1, 1),
(2, 1),
(3, 1),
(2, 2);

INSERT INTO participe_projet (id_scientifique, id_projet) VALUES
(1, 1),
(3, 1),
(3, 2);

INSERT INTO publie (id_personnel, id_publication) VALUES
(1, 1),
(2, 1),
(5, 1),
(3, 2),
(2, 3),
(4, 3),
(5, 3),
(2, 4),
(4, 4);
