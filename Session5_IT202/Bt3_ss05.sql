SELECT driver_id, status, trust_score, distance_km
FROM Drivers
WHERE status = 'AVAILABLE' and trust_score >= min_trust_score
ORDER BY distance_km ASC, trust_score DESC;