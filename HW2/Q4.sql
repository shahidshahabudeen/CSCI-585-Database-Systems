-- Database Used : LiveSQL Oracle
--Q4. Statistics

--No Scans Conducted
SELECT COUNT(*) AS Scan_Count
FROM Scan
WHERE Scan_date BETWEEN TO_DATE('2023-01-01','YYYY-MM-DD') AND TO_DATE('2024-01-01','YYYY-MM-DD');

-- Number of tests taken
SELECT COUNT(*) AS Test_Count
FROM Test
WHERE Test_date BETWEEN TO_DATE('2023-01-01','YYYY-MM-DD') AND TO_DATE('2024-01-01','YYYY-MM-DD');

-- Number of Employees Who Self-Reported Symptoms
SELECT COUNT(DISTINCT Emp_ID) AS Symptom_Reporters
FROM SYMPTOM
WHERE Date_Reported BETWEEN TO_DATE('2023-01-01','YYYY-MM-DD') AND TO_DATE('2024-01-01','YYYY-MM-DD');

-- Number of Positive Cases
SELECT COUNT(*) AS Positive_Cases
FROM Test
WHERE Test_result = 'POSITIVE' 
AND Test_date BETWEEN TO_DATE('2023-01-01','YYYY-MM-DD') AND TO_DATE('2024-01-01','YYYY-MM-DD');
