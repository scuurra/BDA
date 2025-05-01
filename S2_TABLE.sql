CREATE TABLE Exploitation OF TExploitation( CONSTRAINT pk_id_exploitation PRIMARY KEY (id_exploitation))
                                            NESTED TABLE Exploitation_Parcelle STORE AS NESTED_Exploitation_Parcelle
;
CREATE TABLE Parcelle OF TParcelle( CONSTRAINT pk_id_parcelle PRIMARY KEY (id_parcelle),
                                    CONSTRAINT fk_Exploitation FOREIGN KEY(Parcelle_Exploitation) REFERENCES Exploitation,
                                    CONSTRAINT ck_type_sol CHECK (type_sol IN ('argileux', 'sableux', 'limoneux','calcaire','humifère','tourbeux')))
                                    NESTED TABLE Parcelle_Semis   STORE AS NESTED_Parcelle_Semis,
                                    NESTED TABLE Parcelle_Maladie STORE AS NESTED_Parcelle_Maladie,
                                    NESTED TABLE Parcelle_Mission STORE AS NESTED_Parcelle_Mission
;
CREATE TABLE Culture OF TCulture( CONSTRAINT PK_id_culture PRIMARY KEY (id_culture))
;
CREATE TABLE Campagne OF TCampagne( CONSTRAINT pk_id_campagne PRIMARY KEY (id_campagne),
                                    CONSTRAINT ck_date CHECK (date_debut <= date_fin))
                                    NESTED TABLE Campagne_Semis   STORE AS NESTED_Campagne_Semis,
                                    NESTED TABLE Campagne_Maladie STORE AS NESTED_Campagne_Maladie,
                                    NESTED TABLE Campagne_Mission STORE AS NESTED_Campagne_Mission
;
CREATE TABLE Semis OF TSemis( CONSTRAINT pk_id_semis PRIMARY KEY(id_semis),
                              CONSTRAINT fk_parcelle FOREIGN KEY(semis_parcelle) REFERENCES Parcelle,
                              CONSTRAINT fk_culture  FOREIGN KEY(semis_culture) REFERENCES Culture,
                              CONSTRAINT fk_campagne FOREIGN KEY(semis_campagne) REFERENCES Campagne)
;
CREATE TABLE Maladie OF TMaladie(CONSTRAINT pk_id_maladie PRIMARY KEY(id_maladie),
                                 CONSTRAINT ck_type_maladie CHECK(type_maladie IN ('fongique','bactérienne','virale','parasitique','physiologique')))
;
CREATE TABLE DETECTIONMALADIE  OF TDetection_Maladie ( CONSTRAINT pk_id_detection PRIMARY KEY(id_detection),
                                                       CONSTRAINT ck_gravite  CHECK(gravite IN ('faible', 'moyenne', 'forte')),
                                                       CONSTRAINT fk_detection_parcelle FOREIGN KEY(maladie_parcelle) REFERENCES Parcelle,
                                                       CONSTRAINT fk_detection_maladie  FOREIGN KEY(maladie_maladie)  REFERENCES Maladie,
                                                       CONSTRAINT fk_detection_campagne FOREIGN KEY(maladie_campagne) REFERENCES Campagne)
;
CREATE TABLE Drone OF TDrone ( CONSTRAINT pk_id_drone PRIMARY KEY(id_drone),
                               CONSTRAINT ck_type_drone CHECK (type_drone IN ('multirotor','iles fixes','hybride','à voilure tournante','autonome')),
                               CONSTRAINT ck_statut_drone  CHECK(statut_drone IN ('Disponible', 'En Maintenance', 'En Mission')))
                               NESTED TABLE Drone_Mission STORE AS NESTED_Drone_Mission
;                              
CREATE TABLE Mission_Drone OF TMission_Drone ( CONSTRAINT pk_id_mission PRIMARY KEY(id_mission),
                                               CONSTRAINT ck_type_mission CHECK (type_mission IN ('surveillance','traitement','cartographie','analyse thermique')),
                                               CONSTRAINT fk_mission_parcelle FOREIGN KEY(mission_parcelle) REFERENCES Parcelle,
                                               CONSTRAINT fk_mission_maladie  FOREIGN KEY(mission_maladie)    REFERENCES Maladie,
                                               CONSTRAINT fk_mission_campagne FOREIGN KEY(mission_campagne) REFERENCES Campagne,
                                               CONSTRAINT fk_mission_drone    FOREIGN KEY(mission_drone)    REFERENCES Drone)
;
