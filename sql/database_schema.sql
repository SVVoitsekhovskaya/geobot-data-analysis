-- Таблица с описаниями (точками исследований)
CREATE TABLE Releves (
    ReleveId   VARCHAR (20)   PRIMARY KEY
                              REFERENCES SpeciesAbundance (ReleveId),
    Author     TEXT,
    Geo        TEXT,
    Date       DATE,
    Community  TEXT,
    Latitude   NUMERIC (3, 6),
    Longitude  NUMERIC (3, 6),
    Alt        INTEGER,
    Angle      INTEGER,
    Exposition TEXT,
    Relief     TEXT,
    AltBelt    TEXT
);

-- Словарь видов растений

CREATE TABLE SpeciesDictionary (
    SpeciesId INT           PRIMARY KEY
                            REFERENCES SpeciesAbundance (SpeciesId),
    LatinName VARCHAR (100),
    Family    VARCHAR (50) 
);

-- Связующая таблица видов растений и их обилия (по Друде) в каждом описании (содержит внешние ключи)
CREATE TABLE SpeciesAbundance (
    RecordId  INT             PRIMARY KEY,
    ReleveId  VARCHAR (20),
    SpeciesId INT,
    Abundance DECIMAL (10, 4),
    FOREIGN KEY (
        ReleveId
    )
    REFERENCES Releves (ReleveId),
    FOREIGN KEY (
        SpeciesId
    )
    REFERENCES SpeciesDictionary (SpeciesId) 
);

