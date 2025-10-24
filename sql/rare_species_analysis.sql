-- Количество редких для региона видов по описаниям
WITH species_frequency AS (
    SELECT 
        SpeciesId,
        COUNT(DISTINCT ReleveId) as frequency,
        COUNT(DISTINCT ReleveId) * 100.0 / (SELECT COUNT(DISTINCT ReleveId) FROM SpeciesAbundance) as frequency_percent
    FROM SpeciesAbundance 
    WHERE Abundance > 0
    GROUP BY SpeciesId
)
SELECT 
    SA.ReleveId,
    COUNT(*) as RareSpeciesCount
FROM SpeciesAbundance SA
JOIN species_frequency SF ON SA.SpeciesId = SF.SpeciesId
WHERE SA.Abundance > 0 AND SF.frequency_percent <= 5
GROUP BY SA.ReleveId
Order by RareSpeciesCount desc
