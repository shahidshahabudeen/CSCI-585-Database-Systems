-- Database Used : LiveSQL Oracle
-- Q2. Most Self-Reported Symptom

SELECT Sym_ID, COUNT(*) AS Symptom_Count
FROM SYMPTOM
GROUP BY Sym_ID
ORDER BY Symptom_Count DESC
FETCH FIRST 1 ROW ONLY;