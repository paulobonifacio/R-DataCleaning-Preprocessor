# 🧹 Data Cleaning and Preprocessing in R

## Overview
This project demonstrates how to clean and preprocess a dataset in **R**.  
The program:
- Loads a dataset from a CSV file.  
- Handles missing values in numeric and categorical columns.  
- Creates categorized columns using `case_when`.  
- Converts variables to factors for analysis.  
- Generates histograms before and after cleaning.  
- Saves the cleaned dataset to a new CSV file.  

---

## Requirements Met
- ✅ Display output to the screen.  
- ✅ Use at least 5 R datatypes (`numeric`, `character`, `logical`, `factor`, `list`).  
- ✅ Loop through lists/arrays.  
- ✅ Use dataframes.  
- ✅ Extra: read/write **CSV** and use **`case_when`**.  

---

## Project Structure

/R-DataCleaning-Preprocessor
│── data.csv
│── final.R
│── cleaned_data.csv # output file
│── age_before.png
│── age_after.png
│── salary_before.png
│── salary_after.png
│── README.md

---

## How to Run

### Run with Rscript (Terminal)
```bash
cd ~/Downloads/R-DataCleaning-Preprocessor
Rscript final.R

