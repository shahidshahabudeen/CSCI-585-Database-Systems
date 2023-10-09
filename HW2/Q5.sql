-- Database Used : LiveSQL Oracle
-- Q5. The Number of Positive and Negative cases for employees in each department

SELECT
    E.Dept_ID,
    COUNT(CASE WHEN T.Test_result = 'POSITIVE' THEN 1 ELSE NULL END) AS Positive_Count,
    COUNT(CASE WHEN T.Test_result = 'NEGATIVE' THEN 1 ELSE NULL END) AS Negative_Count
FROM
    EMPLOYEE E
LEFT JOIN
    Test T ON E.Emp_ID = T.Emp_ID
GROUP BY
    E.Dept_ID;