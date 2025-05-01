/* ---------- TYPES ---------- */
CREATE TYPE TExploitation;
/
CREATE TYPE TParcelle;
/
CREATE TYPE TCulture;
/
CREATE TYPE TCampagne;
/
CREATE TYPE TSemis;
/
CREATE TYPE TMaladie;
/
CREATE TYPE TDetection_Maladie;
/
CREATE TYPE TDrone;
/
CREATE TYPE TMission_Drone;
/
CREATE TYPE tset_ref_Parcelle AS TABLE OF ref TParcelle
/
CREATE TYPE tset_ref_Semis AS TABLE OF ref TSemis
/
CREATE TYPE tset_ref_Mission_Drone TABLE OF ref TMission_Drone
/
CREATE TYPE tset_ref_Detection_Maladie AS TABLE OF ref TDetection_Maladie
/
CREATE OR Replace TYPE AS OBJECT(
    id_exploitation                                    CHAR(6)
    nom_exploitation                                   VARCHAR2(50)
    superficie_exploitation                            NUMBER(38)
    region                                             VARCHAR2(50)
    nbr_parcelles                                      NUMBER(38)
    Exploitation_Parcelle                              tset_ref_Parcelle
)
CREATE OR Replace TYPE TParcelle AS OBJECT (
    id_parcelle             CHAR(4),
    nom_parcelle            VARCHAR(50),
    superficie_parcelle     INT,
    type_sol                VARCHAR(50),
    Parcelle_Exploitation   ref TExploitation,
    Parcelle_Semis          tset_ref_Semis,
    Parcelle_Maladie        tset_ref_Detection_Maladie,
    Parcelle_Mission        tset_ref_Mission_Drone
);
/
CREATE OR Replace TYPE TCulture AS OBJECT (
    id_culture              CHAR(6),
    nom_culture             VARCHAR(50),
    variete_culture         VARCHAR(50)
);
/
CREATE OR Replace TYPE TCampagne AS OBJECT (
    id_campagne             CHAR(6),
    annee                   INT,
    date_debut              DATE,
    date_fin                DATE,
    Campagne_Semis          tset_ref_Semis,
    Campagne_Maladie        tset_ref_Detection_Maladie,
    Campagne_Mission        tset_ref_Mission_Drone
);
/
CREATE OR Replace TYPE TSemis AS OBJECT (
    id_semis                CHAR(4),
    date_semis              DATE,
    quantite_semis          INT,
    semis_parcelle          ref TParcelle,
    semis_culture           ref TCulture,
    semis_campagne          ref TCampagne
);
/
CREATE OR Replace TYPE TMaladie AS OBJECT (
    id_maladie              CHAR(6),
    nom_maladie             VARCHAR(50),
    type_maladie            VARCHAR(50)
);
/
CREATE OR Replace TYPE TDetection_Maladie AS OBJECT (
    id_detection            CHAR(4),
    date_detection          DATE,
    gravite                 VARCHAR(10),
    maladie_parcelle        ref TParcelle,
    maladie_campagne        ref TCampagne,
    maladie_maladie         ref TMaladie
);
/
CREATE OR Replace TYPE TDrone AS OBJECT (
    id_drone                CHAR(6),
    modele                  VARCHAR(50),
    type_drone              VARCHAR(50),
    capacite_batterie       INT,
    statut_drone            VARCHAR(20),
    Drone_Mission           tset_ref_Mission_Drone
);
/
CREATE OR Replace TYPE TMission_Drone AS OBJECT (
    id_mission              CHAR(6),
    date_mission            DATE,
    type_mission            VARCHAR(50),
    resultats               VARCHAR(255),
    mission_drone           ref TDrone,
    mission_parcelle        ref TParcelle,
    mission_campagne        ref TCampagne,
    mission_maladie         ref TMaladie
);
/