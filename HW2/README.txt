README
-------

Database Used	: LiveSQL 
Name			: Shahid Shahabudeen Shahabudeen
USC ID			: 1943722450

The Queries in the attached files are based on the barebone schema provided in the pdf.

Here are the Assumptions for each question:
--------------------------------------------

Q1. Creation of tables and Data Entry

Here I have created 7 Tables, 1 Sequence and 1 Trigger
Table list:
------------
1. EMPLOYEE
2. MEETING
3. NOTIFICATION
4. SYMPTOM
5. SCAN
6. TEST
7. HEALTHSTATUS

A Trigger was created which inserts into table 'HEALTHSTATUS' once it detects an entry on 'TEST'. This was essential as immediate updating of the 'HEALTHSTATUS' is mandatory for the functioning of my tracing system. (A Sample INSERT query is given but commented out)

A sequence was initialized to increment the Row_ID on the 'HEALTHSTATUS' table.

Here is the Symptom Code and its respective Symptom in 'SYMPTOM' Table:
Symptom ID 1: NO Symptoms
Symptom ID 2: Fever
Symptom ID 3: Cough & Fever
Symptom ID 4: Loss of Taste and Smell
Symptom ID 5: 2-4 All of them

Assumptions:
1. An employee can show multiple symptoms but deemed to be sick only if he/she reports a 'POSITIVE' on their Test.
2. I have inserted the minimum number of Records to show my execution of the Queries.
3. MEETING Table has a composite Primary Key which includes the Meet_ID along with the Emp_ID.
4. The Building has 1-10 Floors.
5. Meeting can only take place between 8:00 AM (8) and 6:00 PM (18).
-------------------------------------------------------------------------------------------------

Q2. Write a query to output the most-self-reported symptom

We count the Sym_ID as 'Symptom_Count' which will be grouped by the symptom ID, then we sort it in descending order. We output the Top result which will give us the most self-reported symptom.
The assumption here is that the employees self-report before being tested. 

-------------------------------------------------------------------------------------------------

Q3. Write a query to output the 'sickest' floor

We initially count the number of rows for each Floor, then we inner join between the MEETING and SYMPTOM tables based on the Emp_ID column, linking meetings to symptoms reported by employees.
We specify a date range (Taken for this year, Query can be modified with any range. Assumption here is that one floor can't always be the 'sickest' and can vary from time to time), we then sort this output in descending order which fetching the top row which will give us the 'sickest' floor in that specified time frame.

--------------------------------------------------------------------------------------------------

Q4. Analysis or stats

No particular Assumptions were made here, but the date range is specified for this year (2023). We are able to modify the range as per need.

---------------------------------------------------------------------------------------------------

Q5. My Own Query (Involves Table Division)

Query: To Output the Number of Positive and Negative cases for employees in each department

We select the Dept_ID from the EMPLOYEE table to group the results by department.
We use LEFT JOIN to join the EMPLOYEE table with the Test table based on the Emp_ID to include all departments, even if there are no test records for some employees in a department, we use COUNT with CASE statements to count the number of employees with positive, negative, and other test results.
Finally, we GROUP BY Dept_ID to group the results by department.
