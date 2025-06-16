# 📺 Netflix ELT SQL Project

This project follows the **ELT (Extract - Load - Transform)** approach for performing data analytics on Netflix content data.

---

## 📥 Data Source

- The dataset was downloaded from Kaggle: [Netflix Shows Dataset](https://www.kaggle.com/datasets/shivamb/netflix-shows)
- Format: `.csv`

---

## ⚙️ ELT Process Overview

1. **Extract**:  
   - Data imported in Jupyter Notebook using pandas- `read_csv()`.
  
2. **Load**:  
   - Connection established to **MS SQL Server** using `pyodbc` and `SQLAlchemy`.
   - Raw data inserted into a staging table.

3. **Transform**:  
   - Performed data cleaning and transformation using both Jupyter and SQL Server Management Studio (SSMS).

---

## ✅ Tasks Performed

### 🔁 Data Transformation (Jupyter + SSMS)

- Performed **Structural Data Transformation**:
  - Modified column data types after import
  - Dropped and recreated the table
  - Appended cleaned data from Jupyter

### 🧹 Data Cleaning (SSMS)

- Handled special/foreign characters
- Removed duplicates
- Created separate tables for specific columns
- Populated missing values
- Converted data types for consistency
- Dropped unnecessary columns
- Created a final clean table for analysis

### 📊 Data Analysis (SSMS)

**Business Questions:**
1. For each director, count the number of movies and TV shows separately (only for those who directed both).
2. Which country has the highest number of **comedy movies**?
3. For each year (based on `date_added`), which director released the most movies?
4. What is the **average duration** of movies by genre?
5. 
   a. Find directors who have created **both horror and comedy** movies.  
   b. Show the number of such movies directed by them.

---

## 📌 Insights

1. 🎬 **Marcus Raboy** created the most number of movies.
2. 📺 **Alastair Fothergill** created the most number of shows.
3. 🇺🇸 **USA** produced the most comedy movies.
4. 📆 **Rajiv Chilaka** released the highest number of movies in **2021**.
5. 🕐 Genre with **least average duration**: **Movies**
6. 🕐 Genre with **highest average duration**: **Classic Movies**
7. 😂 **Steve Brill** directed the most number of **comedy movies**.
8. 😱 **Poj Amon** directed the most number of **horror movies**.

---

## 🙏 Acknowledgement

Huge thanks to [Ankit Bansal](https://www.linkedin.com/in/ankitbansal6/) for inspiring this project.
