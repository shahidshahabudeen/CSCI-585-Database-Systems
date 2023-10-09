-- Database Used : LiveSQL Oracle
-- Q1. Write SQL commands to create the above tables (create your own column names), and populate them with data (as many/few rows as you see fit
CREATE TABLE EMPLOYEE  
(  
    Emp_ID INTEGER NOT NULL,  
    Name CHAR(50) NOT NULL,  
    Ph_NO VARCHAR(15) NOT NULL,  
    Email_ID VARCHAR(20) DEFAULT 'N/A',  
    Dept_ID VARCHAR(5) NOT NULL,  
    PRIMARY KEY(Emp_ID)  
);

CREATE TABLE MEETING 
( 
	Meet_ID VARCHAR(5) NOT NULL, 
    Emp_ID INTEGER NOT NULL, 
    Dept_ID VARCHAR(5) NOT NULL,  
	Room_ID INTEGER NOT NULL, 
    Floor_ID INTEGER NOT NULL , 
	Meet_Start INTEGER NOT NULL, 
    Meet_End INTEGER NOT NULL, 
    CONSTRAINT Clock_Check CHECK (8<= Meet_Start AND Meet_END <= 18), 
    CONSTRAINT Time_Check CHECK (Meet_Start<Meet_End),  
    PRIMARY KEY (Meet_ID,Emp_ID), 
	FOREIGN KEY (Emp_ID) REFERENCES EMPLOYEE,
    CONSTRAINT Floor_Check CHECK (1<= Floor_ID AND Floor_ID <=10) 
);

CREATE TABLE NOTIFICATION 
( 
	Noti_ID VARCHAR(5) NOT NULL, 
	Emp_ID INTEGER NOT NULL, 
    Noti_Date DATE NOT NULL, 
    Noti_Type CHAR(10) DEFAULT 'MANDATORY', 
    PRIMARY KEY (Noti_ID), 
    FOREIGN KEY (Emp_ID) REFERENCES EMPLOYEE 
);

CREATE TABLE SYMPTOM 
( 
	Sym_ID INTEGER NOT NULL, 
    Date_Reported DATE NOT NULL, 
    Emp_ID INTEGER NOT NULL,  
	FOREIGN KEY (Emp_ID) REFERENCES EMPLOYEE,
    CONSTRAINT Sym_Check CHECK (1<= Sym_ID AND Sym_ID <=5) 
);

CREATE TABLE SCAN (
    Scan_ID INTEGER NOT NULL,
    Scan_date DATE NOT NULL,
    Scan_time INTEGER NOT NULL,
    Emp_ID INTEGER NOT NULL,
    Temp DECIMAL(5, 2) NOT NULL,
	PRIMARY KEY (Scan_ID),
	FOREIGN KEY (Emp_ID) REFERENCES EMPLOYEE
);

CREATE TABLE TEST (
    Test_ID INTEGER NOT NULL,
    Location VARCHAR(30),
    Test_date DATE NOT NULL,
    Test_time INTEGER NOT NULL,
    Emp_ID INTEGER NOT NULL,
    Test_result VARCHAR(10) DEFAULT 'NEGATIVE',
    PRIMARY KEY (Test_ID),
	FOREIGN KEY (Emp_ID) REFERENCES EMPLOYEE
);

-- Creating a Sequence for HEALTHSTATUS 's Row_ID
CREATE SEQUENCE healthstatus_seq
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

CREATE TABLE HEALTHSTATUS (
    Row_ID INTEGER DEFAULT healthstatus_seq.NEXTVAL,
    Emp_ID INTEGER,
    Latest_Check DATE,
    Status VARCHAR(20) DEFAULT 'Well',
    PRIMARY KEY (Row_ID)
);

CREATE OR REPLACE TRIGGER healthstatus_trigger
AFTER INSERT ON TEST
FOR EACH ROW
BEGIN
    IF :NEW.Test_result = 'POSITIVE' THEN
        INSERT INTO HEALTHSTATUS (Emp_ID, Latest_Check, Status)
        VALUES (:NEW.Emp_ID, :NEW.Test_date, 'Sick');
    ELSE
        INSERT INTO HEALTHSTATUS (Emp_ID, Latest_Check, Status)
        VALUES (:NEW.Emp_ID, :NEW.Test_date, 'Well');
    END IF;
END;
/

-- All Tables have Been Generated.
-- Inserting into EMPLOYEE Table
INSERT INTO EMPLOYEE (Emp_ID, Name, Ph_NO, Email_ID, Dept_ID) VALUES (1, 'Shahid','123-456-7890', 'shahid@gmail.com', 'IT');
INSERT INTO EMPLOYEE (Emp_ID, Name, Ph_NO, Email_ID, Dept_ID) VALUES (2, 'Arshak', '567-873-3456', 'arshak@usc.com', 'IT');
INSERT INTO EMPLOYEE (Emp_ID, Name, Ph_NO, Email_ID, Dept_ID) VALUES (3, 'Rohit','234-678-1234', 'rohit@yahoo.com', 'DEV');
INSERT INTO EMPLOYEE (Emp_ID, Name, Ph_NO, Email_ID, Dept_ID) VALUES (4, 'Joshiga', '345-567-1099', 'jo@usc.com', 'IT');
INSERT INTO EMPLOYEE (Emp_ID, Name, Ph_NO, Email_ID, Dept_ID) VALUES (5, 'Rose', '123-332-1234', 'rose@gmail.com', 'IT');
INSERT INTO EMPLOYEE (Emp_ID, Name, Ph_NO, Email_ID, Dept_ID) VALUES (6, 'Abirami', '678-123-1111', 'abs@gmail.com', 'HR');
INSERT INTO EMPLOYEE (Emp_ID, Name, Ph_NO, Email_ID, Dept_ID) VALUES (7, 'Pratik', '111-222-1234', 'pratik@yahoo.com', 'DEV');
INSERT INTO EMPLOYEE (Emp_ID, Name, Ph_NO, Email_ID, Dept_ID) VALUES (8, 'Meenakshi', '101-1234-9909', 'meens@hotmail.com', 'HR');

-- Inserting into MEETING Table
INSERT INTO MEETING (Meet_ID, Emp_ID, Dept_ID, Room_ID, Floor_ID, Meet_Start, Meet_End) VALUES ('M1', 1, 'IT', 101, 1, 10, 11);
INSERT INTO MEETING (Meet_ID, Emp_ID, Dept_ID, Room_ID, Floor_ID, Meet_Start, Meet_End) VALUES ('M1', 2, 'IT', 101, 1, 10, 11);
INSERT INTO MEETING (Meet_ID, Emp_ID, Dept_ID, Room_ID, Floor_ID, Meet_Start, Meet_End) VALUES ('M1', 4, 'IT', 101, 1, 10, 11);
INSERT INTO MEETING (Meet_ID, Emp_ID, Dept_ID, Room_ID, Floor_ID, Meet_Start, Meet_End) VALUES ('M1', 5, 'IT', 101, 1, 10, 11);
INSERT INTO MEETING (Meet_ID, Emp_ID, Dept_ID, Room_ID, Floor_ID, Meet_Start, Meet_End) VALUES ('M2', 6, 'HR', 401, 4, 12, 14);
INSERT INTO MEETING (Meet_ID, Emp_ID, Dept_ID, Room_ID, Floor_ID, Meet_Start, Meet_End) VALUES ('M2', 8, 'HR', 401, 4, 12, 14);
INSERT INTO MEETING (Meet_ID, Emp_ID, Dept_ID, Room_ID, Floor_ID, Meet_Start, Meet_End) VALUES ('M3', 3, 'DEV', 201, 2, 14, 15);
INSERT INTO MEETING (Meet_ID, Emp_ID, Dept_ID, Room_ID, Floor_ID, Meet_Start, Meet_End) VALUES ('M3', 7, 'DEV', 201, 2, 14, 15);
INSERT INTO MEETING (Meet_ID, Emp_ID, Dept_ID, Room_ID, Floor_ID, Meet_Start, Meet_End) VALUES ('M4', 3, 'DEV', 102, 1, 10, 12);
INSERT INTO MEETING (Meet_ID, Emp_ID, Dept_ID, Room_ID, Floor_ID, Meet_Start, Meet_End) VALUES ('M4', 7, 'DEV', 102, 1, 10, 12);

-- Inserting into NOTIFICATION table
-- Since Emp_ID 2 Tested Positive, Employees in the meeting with 2 got mandatory, same floor got Optional.
INSERT INTO NOTIFICATION (Noti_ID, Emp_ID, Noti_Date, Noti_Type) VALUES ('N1', 1, TO_DATE('2023-10-07', 'YYYY-MM-DD'), 'MANDATORY');
INSERT INTO NOTIFICATION (Noti_ID, Emp_ID, Noti_Date, Noti_Type) VALUES ('N2', 2, TO_DATE('2023-10-07', 'YYYY-MM-DD'), 'MANDATORY');
INSERT INTO NOTIFICATION (Noti_ID, Emp_ID, Noti_Date, Noti_Type) VALUES ('N3', 4, TO_DATE('2023-10-07', 'YYYY-MM-DD'), 'MANDATORY');
INSERT INTO NOTIFICATION (Noti_ID, Emp_ID, Noti_Date, Noti_Type) VALUES ('N4', 5, TO_DATE('2023-10-07', 'YYYY-MM-DD'), 'MANDATORY');
INSERT INTO NOTIFICATION (Noti_ID, Emp_ID, Noti_Date, Noti_Type) VALUES ('N5', 3, TO_DATE('2023-10-07', 'YYYY-MM-DD'), 'OPTIONAL');
INSERT INTO NOTIFICATION (Noti_ID, Emp_ID, Noti_Date, Noti_Type) VALUES ('N6', 7, TO_DATE('2023-10-07', 'YYYY-MM-DD'), 'OPTINAL');

-- Inserting into SYMPTOM Table (Repoted - Same as Reported)
-- Symptom 1: NO Symptoms
-- Symptom 2: Fever
-- Symptom 3: Cough & Fever
-- Symptom 4: Loss of Taste and Smell
-- Symptom 5: 2-4 All of them
INSERT INTO SYMPTOM (Sym_ID, Date_Reported, Emp_ID) VALUES (1, TO_DATE('2023-09-25','YYYY-MM-DD'), 1);
INSERT INTO SYMPTOM (Sym_ID, Date_Reported, Emp_ID) VALUES (1, TO_DATE('2023-09-25','YYYY-MM-DD'), 5);
INSERT INTO SYMPTOM (Sym_ID, Date_Reported, Emp_ID) VALUES (5, TO_DATE('2023-09-27','YYYY-MM-DD'), 2);
INSERT INTO SYMPTOM (Sym_ID, Date_Reported, Emp_ID) VALUES (2, TO_DATE('2023-09-27','YYYY-MM-DD'), 4);
INSERT INTO SYMPTOM (Sym_ID, Date_Reported, Emp_ID) VALUES (1, TO_DATE('2023-09-26','YYYY-MM-DD'), 7);
INSERT INTO SYMPTOM (Sym_ID, Date_Reported, Emp_ID) VALUES (1, TO_DATE('2023-09-25','YYYY-MM-DD'), 3);

-- Inserting into SCAN table
-- Normal Body Temperature is 97.5°F to 98.9°F
INSERT INTO Scan (Scan_ID, Scan_date, Scan_time, Emp_ID, Temp) VALUES (1, TO_DATE('2023-10-01','YYYY-MM-DD'), 10, 1, 98.5);
INSERT INTO Scan (Scan_ID, Scan_date, Scan_time, Emp_ID, Temp) VALUES (2, TO_DATE('2023-10-02','YYYY-MM-DD'), 11, 2, 100.0);
INSERT INTO Scan (Scan_ID, Scan_date, Scan_time, Emp_ID, Temp) VALUES (3, TO_DATE('2023-10-01','YYYY-MM-DD'), 10, 4, 100.0);
INSERT INTO Scan (Scan_ID, Scan_date, Scan_time, Emp_ID, Temp) VALUES (4, TO_DATE('2023-10-01','YYYY-MM-DD'), 10, 7, 98.5);
INSERT INTO Scan (Scan_ID, Scan_date, Scan_time, Emp_ID, Temp) VALUES (5, TO_DATE('2023-10-01','YYYY-MM-DD'), 10, 3, 98.5);
INSERT INTO Scan (Scan_ID, Scan_date, Scan_time, Emp_ID, Temp) VALUES (6, TO_DATE('2023-10-01','YYYY-MM-DD'), 10, 5, 98.5);

--Inserting into TEST Table
INSERT INTO Test (Test_ID, Location, Test_date, Test_time, Emp_ID, Test_result) VALUES (1, 'Hospital A', TO_DATE('2023-10-08','YYYY-MM-DD'), 9, 4, 'POSITIVE');
INSERT INTO Test (Test_ID, Location, Test_date, Test_time, Emp_ID, Test_result) VALUES (2, 'Clinic B', TO_DATE('2023-10-08','YYYY-MM-DD'), 15, 2, 'POSITIVE');
INSERT INTO Test (Test_ID, Location, Test_date, Test_time, Emp_ID, Test_result) VALUES (3, 'Hospital A', TO_DATE('2023-10-08','YYYY-MM-DD'), 9, 5, 'NEGATIVE');
INSERT INTO Test (Test_ID, Location, Test_date, Test_time, Emp_ID, Test_result) VALUES (4, 'Hospital A', TO_DATE('2023-10-08','YYYY-MM-DD'), 9, 1, 'NEGATIVE');
INSERT INTO Test (Test_ID, Location, Test_date, Test_time, Emp_ID, Test_result) VALUES (5, 'Clinic B', TO_DATE('2023-10-08','YYYY-MM-DD'), 9, 3, 'NEGATIVE');
INSERT INTO Test (Test_ID, Location, Test_date, Test_time, Emp_ID, Test_result) VALUES (6, 'Hospital B', TO_DATE('2023-10-08','YYYY-MM-DD'), 9, 7, 'NEGATIVE');

--Inserting into HEALTHSTATUS Table
-- We have a Trigger to Automatically Enter Values into this Table.
-- SAMPLE INSERT 
-- INSERT INTO HEALTHSTATUS (Emp_ID, Latest_Check, Status) VALUES (1, TO_DATE('2023-10-08', 'YYYY-MM-DD'), 'Well');