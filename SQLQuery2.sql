
  CREATE TABLE Users (
    UserID INT PRIMARY KEY IDENTITY(1,1),
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(15),
    UserType VARCHAR(10) CHECK (UserType IN ('Patient', 'Doctor', 'Admin')),
    CreatedAt DATE DEFAULT GETDATE()
);

  CREATE TABLE Hospital (
    HospitalID INT PRIMARY KEY IDENTITY(1,1),
    HospitalName VARCHAR(100) NOT NULL,
    Address VARCHAR(200),
    City VARCHAR(50),
    Phone VARCHAR(15)
);

CREATE TABLE Department (
    DepartmentID INT PRIMARY KEY IDENTITY(1,1),
    DepartmentName VARCHAR(100) NOT NULL,
    HospitalID INT FOREIGN KEY REFERENCES Hospital(HospitalID)
);


CREATE TABLE Doctor (
    DoctorID INT PRIMARY KEY,
    Specialty VARCHAR(100),
    LicenseNumber VARCHAR(50) UNIQUE,
    DepartmentID INT FOREIGN KEY REFERENCES Department(DepartmentID),
    FOREIGN KEY (DoctorID) REFERENCES Users(UserID)
);

CREATE TABLE Patient (
    PatientID INT PRIMARY KEY,
    BirthDate DATE,
    BloodType VARCHAR(5),
    Address VARCHAR(200),
    FOREIGN KEY (PatientID) REFERENCES Users(UserID)
);


CREATE TABLE Admin (
    AdminID INT PRIMARY KEY,
    AccessLevel INT DEFAULT 1,
    FOREIGN KEY (AdminID) REFERENCES Users(UserID)
);

 CREATE TABLE Appointment (
    AppointmentID INT PRIMARY KEY IDENTITY(1,1),
    PatientID INT FOREIGN KEY REFERENCES Patient(PatientID),
    DoctorID INT FOREIGN KEY REFERENCES Doctor(DoctorID),
    AppointmentDate DATETIME NOT NULL,
    Status VARCHAR(20) CHECK (Status IN ('Scheduled', 'Completed', 'Cancelled')),
    Notes VARCHAR(500)
);


CREATE TABLE Prescription (
    PrescriptionID INT PRIMARY KEY IDENTITY(1,1),
    AppointmentID INT FOREIGN KEY REFERENCES Appointment(AppointmentID),
    MedicineName VARCHAR(100) NOT NULL,
    Dosage VARCHAR(50),
    Duration VARCHAR(50)
);

CREATE TABLE LabResult (
    LabResultID INT PRIMARY KEY IDENTITY(1,1),
    PatientID INT FOREIGN KEY REFERENCES Patient(PatientID),
    DoctorID INT FOREIGN KEY REFERENCES Doctor(DoctorID),
    TestName VARCHAR(100),
    Result VARCHAR(200),
    TestDate DATE
);


CREATE TABLE Insurance (
    InsuranceID INT PRIMARY KEY IDENTITY(1,1),
    PatientID INT FOREIGN KEY REFERENCES Patient(PatientID),
    CompanyName VARCHAR(100),
    PolicyNumber VARCHAR(50) UNIQUE,
    ExpiryDate DATE
);

CREATE TABLE Billing (
    BillingID INT PRIMARY KEY IDENTITY(1,1),
    PatientID INT FOREIGN KEY REFERENCES Patient(PatientID),
    AppointmentID INT FOREIGN KEY REFERENCES Appointment(AppointmentID),
    Amount DECIMAL(10,2),
    PaymentStatus VARCHAR(20) CHECK (PaymentStatus IN ('Paid', 'Pending', 'Cancelled')),
    BillingDate DATE
);

INSERT INTO Hospital VALUES ('Ankara City Hospital', 'Bilkent Cd. No:1', 'Ankara', '0312-111-1111');
INSERT INTO Hospital VALUES ('Istanbul Medical Center', 'Taksim Sq. No:5', 'Istanbul', '0212-222-2222');
INSERT INTO Hospital VALUES ('Izmir State Hospital', 'Kordon Cd. No:3', 'Izmir', '0232-333-3333');


INSERT INTO Department VALUES ('Cardiology', 1);
INSERT INTO Department VALUES ('Neurology', 1);
INSERT INTO Department VALUES ('Orthopedics', 2);
INSERT INTO Department VALUES ('Pediatrics', 2);
INSERT INTO Department VALUES ('Dermatology', 3);

INSERT INTO Users (FirstName, LastName, Email, Phone, UserType) VALUES ('Ahmet', 'Yýlmaz', 'ahmet.yilmaz@hospital.com', '0555-111-1111', 'Doctor');
INSERT INTO Users (FirstName, LastName, Email, Phone, UserType) VALUES ('Ayþe', 'Kaya', 'ayse.kaya@hospital.com', '0555-222-2222', 'Doctor');
INSERT INTO Users (FirstName, LastName, Email, Phone, UserType) VALUES ('Mehmet', 'Demir', 'mehmet.demir@hospital.com', '0555-333-3333', 'Doctor');

INSERT INTO Users (FirstName, LastName, Email, Phone, UserType) VALUES ('Ali', 'Çelik', 'ali.celik@gmail.com', '0544-111-1111', 'Patient');
INSERT INTO Users (FirstName, LastName, Email, Phone, UserType) VALUES ('Fatma', 'Þahin', 'fatma.sahin@gmail.com', '0544-222-2222', 'Patient');
INSERT INTO Users (FirstName, LastName, Email, Phone, UserType) VALUES ('Hasan', 'Arslan', 'hasan.arslan@gmail.com', '0544-333-3333', 'Patient');
INSERT INTO Users (FirstName, LastName, Email, Phone, UserType) VALUES ('Zeynep', 'Kurt', 'zeynep.kurt@gmail.com', '0544-444-4444', 'Patient');
INSERT INTO Users (FirstName, LastName, Email, Phone, UserType) VALUES ('Mustafa', 'Aydýn', 'mustafa.aydin@gmail.com', '0544-555-5555', 'Patient');

INSERT INTO Users (FirstName, LastName, Email, Phone, UserType) VALUES ('Selin', 'Öz', 'selin.oz@hospital.com', '0533-111-1111', 'Admin');
INSERT INTO Users (FirstName, LastName, Email, Phone, UserType) VALUES ('Kemal', 'Yýldýz', 'kemal.yildiz@hospital.com', '0533-222-2222', 'Admin');


INSERT INTO Doctor VALUES (1, 'Cardiology', 'LIC-001', 1);
INSERT INTO Doctor VALUES (2, 'Neurology', 'LIC-002', 2);
INSERT INTO Doctor VALUES (3, 'Orthopedics', 'LIC-003', 3);

INSERT INTO Patient VALUES (4, '1990-05-15', 'A+', 'Ankara, Çankaya');
INSERT INTO Patient VALUES (5, '1985-08-22', 'B-', 'Istanbul, Kadýköy');
INSERT INTO Patient VALUES (6, '1992-03-10', 'O+', 'Izmir, Bornova');
INSERT INTO Patient VALUES (7, '1978-11-30', 'AB+', 'Ankara, Keçiören');
INSERT INTO Patient VALUES (8, '2000-07-04', 'A-', 'Istanbul, Beþiktaþ');

INSERT INTO Admin VALUES (9, 2);
INSERT INTO Admin VALUES (10, 1); 

SELECT * FROM Doctor;
SELECT * FROM Patient;
SELECT * FROM Admin;

INSERT INTO Appointment VALUES (4, 1, '2026-01-10 09:00', 'Completed', 'Routine checkup');
INSERT INTO Appointment VALUES (5, 2, '2026-01-15 10:30', 'Completed', 'Headache complaint');
INSERT INTO Appointment VALUES (6, 3, '2026-02-01 11:00', 'Completed', 'Knee pain');
INSERT INTO Appointment VALUES (7, 1, '2026-02-10 09:30', 'Cancelled', 'Heart palpitations');
INSERT INTO Appointment VALUES (8, 2, '2026-03-05 14:00', 'Completed', 'Dizziness');
INSERT INTO Appointment VALUES (4, 3, '2026-03-20 10:00', 'Scheduled', 'Follow-up');
INSERT INTO Appointment VALUES (5, 1, '2026-04-01 09:00', 'Completed', 'Chest pain');

INSERT INTO Prescription VALUES (1, 'Aspirin', '100mg', '7 days');
INSERT INTO Prescription VALUES (2, 'Paracetamol', '500mg', '5 days');
INSERT INTO Prescription VALUES (3, 'Ibuprofen', '400mg', '10 days');
INSERT INTO Prescription VALUES (5, 'Betaserc', '24mg', '30 days');
INSERT INTO Prescription VALUES (7, 'Coraspin', '100mg', '60 days');

INSERT INTO LabResult VALUES (4, 1, 'Blood Test', 'Normal', '2026-01-10');
INSERT INTO LabResult VALUES (5, 2, 'MRI', 'No abnormality', '2026-01-15');
INSERT INTO LabResult VALUES (6, 3, 'X-Ray', 'Mild arthritis', '2026-02-01');
INSERT INTO LabResult VALUES (8, 2, 'EEG', 'Normal', '2026-03-05');

INSERT INTO Insurance VALUES (4, 'SGK', 'SGK-001', '2027-12-31');
INSERT INTO Insurance VALUES (5, 'Axa Sigorta', 'AXA-002', '2026-06-30');
INSERT INTO Insurance VALUES (6, 'Allianz', 'ALL-003', '2027-03-15');
INSERT INTO Insurance VALUES (7, 'SGK', 'SGK-004', '2028-01-01');
INSERT INTO Insurance VALUES (8, 'Mapfre', 'MAP-005', '2026-12-31');

INSERT INTO Billing VALUES (4, 1, 250.00, 'Paid', '2026-01-10');
INSERT INTO Billing VALUES (5, 2, 400.00, 'Paid', '2026-01-15');
INSERT INTO Billing VALUES (6, 3, 350.00, 'Pending', '2026-02-01');
INSERT INTO Billing VALUES (7, 4, 150.00, 'Cancelled', '2026-02-10');
INSERT INTO Billing VALUES (8, 5, 300.00, 'Paid', '2026-03-05'); 


-- Query 1: Doctors with more than 1 patient
SELECT d.DoctorID, u.FirstName, u.LastName, COUNT(a.PatientID) AS PatientCount
FROM Doctor d
JOIN Users u ON d.DoctorID = u.UserID
JOIN Appointment a ON d.DoctorID = a.DoctorID
GROUP BY d.DoctorID, u.FirstName, u.LastName
HAVING COUNT(a.PatientID) > 1;

-- Query 2: Patients with no appointments
SELECT u.FirstName, u.LastName, u.Email
FROM Patient p
JOIN Users u ON p.PatientID = u.UserID
WHERE p.PatientID NOT IN (SELECT PatientID FROM Appointment);

-- Query 3: Doctor with most appointments
SELECT TOP 1 u.FirstName, u.LastName, COUNT(a.AppointmentID) AS Total
FROM Doctor d
JOIN Users u ON d.DoctorID = u.UserID
JOIN Appointment a ON d.DoctorID = a.DoctorID
GROUP BY u.FirstName, u.LastName
ORDER BY Total DESC;

-- Query 4: Total revenue from paid bills
SELECT SUM(Amount) AS TotalRevenue
FROM Billing
WHERE PaymentStatus = 'Paid';

-- Query 5: Total bill per patient
SELECT u.FirstName, u.LastName, SUM(b.Amount) AS TotalBill
FROM Patient p
JOIN Users u ON p.PatientID = u.UserID
JOIN Billing b ON p.PatientID = b.PatientID
GROUP BY u.FirstName, u.LastName
ORDER BY TotalBill DESC;

-- Query 6: Most expensive appointment
SELECT TOP 1 u.FirstName, u.LastName, b.Amount, a.AppointmentDate
FROM Billing b
JOIN Appointment a ON b.AppointmentID = a.AppointmentID
JOIN Users u ON a.PatientID = u.UserID
ORDER BY b.Amount DESC;

-- Query 7: Patients with expired insurance
SELECT u.FirstName, u.LastName, i.CompanyName, i.ExpiryDate
FROM Insurance i
JOIN Patient p ON i.PatientID = p.PatientID
JOIN Users u ON p.PatientID = u.UserID
WHERE i.ExpiryDate < GETDATE();

-- Query 8: Number of doctors per department
SELECT d.DepartmentName, COUNT(doc.DoctorID) AS DoctorCount
FROM Department d
LEFT JOIN Doctor doc ON d.DepartmentID = doc.DepartmentID
GROUP BY d.DepartmentName;

-- Query 9: Cancelled appointments
SELECT u.FirstName, u.LastName, a.AppointmentDate, a.Notes
FROM Appointment a
JOIN Users u ON a.PatientID = u.UserID
WHERE a.Status = 'Cancelled';

-- Query 10: Prescriptions with patient names
SELECT u.FirstName, u.LastName, p.MedicineName, p.Dosage, p.Duration
FROM Prescription p
JOIN Appointment a ON p.AppointmentID = a.AppointmentID
JOIN Users u ON a.PatientID = u.UserID;

CREATE INDEX IX_Appointment_PatientID ON Appointment(PatientID);
CREATE INDEX IX_Appointment_DoctorID ON Appointment(DoctorID);
CREATE INDEX IX_Patient_BloodType ON Patient(BloodType);


CREATE UNIQUE INDEX IX_Users_Email ON Users(Email);


CREATE INDEX IX_Billing_Status_Date ON Billing(PaymentStatus, BillingDate); 


ALTER TABLE Doctor ADD [YearsOfExperience] INT;
ALTER TABLE Appointment ADD Duration INT DEFAULT 30;

UPDATE Doctor SET [YearsOfExperience] = 10 WHERE DoctorID = 1;
UPDATE Doctor SET [YearsOfExperience] = 7 WHERE DoctorID = 2;
UPDATE Doctor SET [YearsOfExperience] = 15 WHERE DoctorID = 3;
