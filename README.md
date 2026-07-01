# Healthcare Data Analysis

## Project Overview
This project involves the exploratory data analysis (EDA) of a 1,635-record healthcare dataset. The objective was to transform raw patient data into actionable insights regarding financial billing patterns, operational efficiency, and clinical workload management using SQL Server Management Studio (SSMS).

## Key Insights
- **Financial Performance:** Identified the most cost-intensive medical conditions, providing a basis for hospital resource allocation.
- **Operational Efficiency:** Calculated the average Length of Stay (LOS) per condition to benchmark facility performance.
- **Doctor Performance:** Analyzed doctor caseloads to identify high-pressure environments, segmenting by Admission Type (Emergency, Urgent, Elective).

## Tools & Skills Used
- **Database:** SQL Server Management Studio (SSMS).
- **Techniques:**
    - Data Cleaning (Handling duplicates, standardizing string data).
    - Type Casting & Date Math (`DATEDIFF`, `CAST`).
    - Advanced Aggregation (`CASE WHEN`, Window functions).
    - Outlier Detection.

## Project Structure
- `healthcare_analysis.sql`: The complete suite of analytical queries.
- `Data Source`: [https://www.kaggle.com/datasets/prasad22/healthcare-dataset]. This dataset is provided for educational purposes and contains mock records of patient hospital visits.
- `LICENSE`: MIT License.

---
*Created by Muhammad Ubaid Ur Rehman Nizamani*
