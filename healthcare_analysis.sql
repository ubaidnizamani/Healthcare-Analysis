/*
================================================================================
PROJECT: Healthcare Operational Analysis
DESCRIPTION: Cleaning and analyzing 1,635 patient records to derive insights 
             on hospital performance, billing, and patient demographics.
================================================================================
*/

-- =============================================
-- 1. DATA PREPARATION & CLEANING
-- =============================================

-- Normalize Name casing for consistency
-- UPDATE healthcare SET Name = UPPER(Name);

-- Ensure correct data types for date calculations
-- ALTER TABLE healthcare ALTER COLUMN Date_of_Admission DATE;
-- ALTER TABLE healthcare ALTER COLUMN Discharge_Date DATE;

-- Check for data integrity (e.g., negative length of stay)

SELECT * FROM healthcare 
WHERE Discharge_Date < Date_of_Admission;


-- =============================================
-- 2. DEMOGRAPHIC OVERVIEW
-- =============================================

-- Distribution of patients by Hospital
SELECT Hospital, COUNT(*) AS Amount_of_Patients
FROM healthcare
GROUP BY Hospital
ORDER BY Amount_of_Patients DESC;

-- Distribution by Medical Condition
SELECT Medical_Condition, COUNT(*) AS Total_Amount
FROM healthcare
GROUP BY Medical_Condition
ORDER BY Total_Amount DESC;

-- Distribution by Insurance Provider
SELECT Insurance_Provider, COUNT(*) AS Total_Patients
FROM healthcare
GROUP BY Insurance_Provider
ORDER BY Total_Patients DESC;

-- Distribution by Admission Type
SELECT Admission_Type, COUNT(*) AS Total_Admissions
FROM healthcare
GROUP BY Admission_Type;

-- Distribution by Test Results
SELECT Test_Results, COUNT(*) AS Result_Count
FROM healthcare
GROUP BY Test_Results
ORDER BY Result_Count DESC;


-- =============================================
-- 3. OPERATIONAL & CLINICAL ANALYSIS
-- =============================================

-- Medication usage frequency
SELECT Medication, COUNT(*) AS total_medication
FROM healthcare
GROUP BY Medication
ORDER BY total_medication DESC;

-- Doctor workload performance (Total cases vs. Admission types)
SELECT 
    Doctor, 
    COUNT(*) AS Total_Cases,
    COUNT(CASE WHEN Admission_Type = 'Emergency' THEN 1 END) AS Emergency_Cases,
    COUNT(CASE WHEN Admission_Type = 'Urgent' THEN 1 END) AS Urgent_Cases,
    COUNT(CASE WHEN Admission_Type = 'Elective' THEN 1 END) AS Elective_Cases
FROM healthcare
GROUP BY Doctor
ORDER BY Total_Cases DESC;


-- =============================================
-- 4. FINANCIAL & PERFORMANCE METRICS
-- =============================================

-- Average billing amount by Medical Condition
SELECT Medical_Condition, AVG(Billing_Amount) AS Avg_Bill
FROM healthcare
GROUP BY Medical_Condition
ORDER BY Avg_Bill DESC;

-- Average Length of Stay (LOS) per Medical Condition
WITH PatientStays AS (
    SELECT 
        Medical_Condition,
        DATEDIFF(day, Date_of_Admission, Discharge_Date) AS Days_Stayed
    FROM healthcare
)
SELECT 
    Medical_Condition,
    AVG(CAST(Days_Stayed AS FLOAT)) AS Avg_Length_of_Stay
FROM PatientStays
GROUP BY Medical_Condition
ORDER BY Avg_Length_of_Stay DESC;

-- Identification of High-Cost Outliers (Bills above average)
SELECT Name, Medical_Condition, Billing_Amount
FROM healthcare
WHERE Billing_Amount > (SELECT AVG(Billing_Amount) FROM healthcare)
ORDER BY Billing_Amount DESC;