-- Количество видов в описаниях
SELECT ReleveId,
       COUNT( * ) AS SpeciesCount
  FROM SpeciesAbundance
 WHERE Abundance > 0
 GROUP BY ReleveId
 ORDER BY SpeciesCount DESC;

-- Топ-20 видов по встречаемости 
SELECT SA.SpeciesId,
       SD.LatinName,
       COUNT( * ) AS Frequency,
       ROUND(COUNT( * ) * 100.0 / (
                                      SELECT COUNT(DISTINCT ReleveId) 
                                        FROM SpeciesAbundance
                                  ), 1) AS FrequencyPercent
  FROM SpeciesAbundance SA
       JOIN
       SpeciesDictionary SD ON SA.SpeciesId = SD.SpeciesId
 WHERE SA.Abundance > 0
 GROUP BY SA.SpeciesId,
          SD.LatinName
 ORDER BY Frequency DESC
 LIMIT 20;

