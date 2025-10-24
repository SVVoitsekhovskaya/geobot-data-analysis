-- Таблица, которая показывает, к какому высотному поясу относится каждое описание
SELECT R.ReleveId,
       CASE WHEN R.alt BETWEEN 0 AND 500 THEN 'лесостепной' WHEN R.alt BETWEEN 500 AND 1200 THEN 'подтаежный' WHEN R.alt BETWEEN 1200 AND 1700 THEN 'горнотаежный' WHEN R.alt > 1700 THEN 'альпийско-тундровый' ELSE 'неклассифицировано' END AS Altitude_belt,
       R.alt
  FROM releves R
 WHERE R.alt IS NOT NULL
 ORDER BY R.alt ASC;

-- Создание сводной таблицы, которая показывает распределение описаний по высотным поясам и одновременно видовые хар-ки
SELECT R.ReleveId,
       R.alt,
       CASE WHEN R.alt BETWEEN 0 AND 500 THEN 'лесостепной' WHEN R.alt BETWEEN 500 AND 1200 THEN 'подтаежный' WHEN R.alt BETWEEN 1200 AND 1700 THEN 'горнотаежный' WHEN R.alt > 1700 THEN 'альпийско-тундровый' ELSE 'неклассифицировано' END AS altitude_zone,
       SA.SpeciesId,
       SD.LatinName,
       SD.Family,
       SA.Abundance,
       (
           SELECT COUNT(DISTINCT SpeciesId) 
             FROM SpeciesAbundance
            WHERE ReleveId = R.ReleveId AND
                  Abundance > 0
       )
       AS species_richness
  FROM releves R
       LEFT JOIN
       SpeciesAbundance SA ON R.ReleveId = SA.ReleveId
       LEFT JOIN
       SpeciesDictionary SD ON SA.SpeciesId = SD.SpeciesId
 WHERE R.alt IS NOT NULL
