# TechVizInsights
# Top 1000 Technology Companies Analysis

This repository hosts an end-to-end data analysis project showcasing insights into the **Top 1000 Technology Companies**. The project leverages **Microsoft SQL Server**, **Microsoft Excel**, and **Power BI** to clean, analyze, and visualize data sourced from **Kaggle**. This README provides an overview of the project's objectives, tools, methodologies, and outcomes.

## Objective
To analyze a dataset of the world's top 1000 technology companies, uncover unique insights, and create dynamic visualizations. The project involves data cleaning, transformation, and advanced calculations to provide actionable business intelligence.

---

## Dataset
**Source**: Kaggle  
**Columns**:
- **Ranking**: Position of the company
- **CompanyName**: Name of the company
- **MarketCap**: Market capitalization (in Trillions, Billions, or Millions)
- **CountryName**: Country of origin
- **IndustryType**: Industry sector of the company

---

## Tools Used
1. **Microsoft SQL Server**:
   - Database creation, data import, cleaning, and transformations.
   - Advanced SQL queries to derive insights and perform calculations.
2. **Microsoft Excel**:
   - Data validation and formula-driven transformations.
   - Pivot table creation for summarizing key metrics.
3. **Power BI**:
   - Dynamic dashboards to visualize trends and insights.
   - Measures and calculated fields for enhanced analysis.

---

## Key Operations Performed
### 1. **Data Cleaning (SQL)**
- Created a database and tables for structured data storage.
- Imported the CSV file into SQL Server.
- Removed duplicates and null values.
- Checked for inconsistent entries in **CountryName** and **IndustryType**.
- Standardized formatting (e.g., removing `$`, handling `T`, `B`, `M` in MarketCap).
- Ensured **MarketCap** column was numeric by converting text values to numbers.
- Trimmed extra spaces and removed double quotes in text fields.
- Altered and updated table entries for consistency.

### 2. **Data Transformation (SQL)**
- Created new columns using:
  - **SUBSTRING**: Extracted parts of strings (e.g., values before/after commas).
  - **REPLACE**: Replaced unwanted characters.
  - **CAST/CONVERT**: Standardized data types (e.g., numeric conversions).
- Updated column names for better readability.
- Dropped unwanted columns and cleaned wrong input values.

### 3. **Analysis Performed (SQL)**
- **Top 10 Companies** by Market Capitalization.
- **Trillion-Dollar Companies**: Identified and counted companies with MarketCap > 1 Trillion.
- **Industry Market Share**:
  - Total market share by industry.
  - Percentage breakdown by market cap for each industry.
- **Country Rankings**: Ranked countries by the number of companies.
- **MarketCap Distribution**: Analyzed proportions of companies categorized as Trillion, Billion, or Million-dollar firms.
- **Market Share Analysis**:
  - Percentage share of market cap by country.
  - Percentage share of company categories using subqueries and Common Table Expressions (CTEs).

### 4. **Microsoft Excel Enhancements**
- Used **IFS** formulas to convert MarketCap values (e.g., `T`, `B`, `M`) into standardized numbers.
- Removed symbols and extra spaces in text fields.
- Built detailed **Pivot Tables**:
  - MarketCap by Industry.
  - MarketCap by Country.
  - Count of companies by continent.
  - Top 10 companies by MarketCap.
  - Companies count by Industry and Country.
- Applied **Conditional Formatting** to highlight specific cells based on conditions.
- Created **Excel Visualizations** and a **dashboard** using tables from pivot charts.
- Utilized **Power Query Editor** for advanced transformations.

### 5. **Power BI Visualizations**
- **Dashboard Name**: "Tech Titans Market Intelligence Hub"
- Visuals include:
  1. **% Share of Market Capitalization by Top 10 Countries**
   - Analyzes the market capitalization distribution among the leading ten countries, highlighting their economic significance.

2. **Top 10 Companies by Market Capitalization**
   - Identifies the highest-valued companies in the dataset, showcasing their dominance in the technology sector.

3. **% Share of Market Capitalization by Industry Type**
   - Visualizes the market capitalization distribution across various industry types, providing insights into sector performance.

4. **Count of Companies by Industry Type**
   - Compiles the number of companies operating within each industry, revealing competitive landscapes.

5. **Total Companies Card**
   - Displays the total count of 1,000 companies analyzed, emphasizing the breadth of the dataset.

6. **Total Countries Covered Card**
   - Shows the total number of countries represented in the analysis, highlighting global market diversity.

7. **Combined Market Capitalization in Trillions Card**
   - Summarizes the total market capitalization in trillions, reflecting the overall market scale.

8. **Number of Trillion-Dollar Companies Card**
   - Showcases the count of companies with a market cap exceeding one trillion dollars, indicating elite market players.

9. **Number of Billion-Dollar Companies Card**
   - Highlights the number of companies valued at one billion dollars or more, representing substantial market participants.

10. **Number of Million-Dollar Companies Card**
    - Displays the count of companies with market valuations in the million-dollar range, illustrating the market's entry-level players.


## Unique Insights
- **Trillion-Dollar Companies**: Percentage and count of companies exceeding $1 Trillion.
- **Dominant Countries**: Countries with the most technology companies.
- **Top Industries**: Industries with the highest cumulative market capitalization.
- **Outliers**: Identified data anomalies or companies with unique trends.

## Live Visualizations
You can explore the interactive visualizations at the following link: [Tech Titans Market Intelligence Hub](https://app.powerbi.com/view?r=eyJrIjoiZjM2MTljYmEtMmIyZC00NjdiLTkwNjYtZGRkYzliNDI3YmJlIiwidCI6IjM0YmQ4YmVkLTJhYzEtNDFhZS05ZjA4LTRlMGEzZjExNzA2YyJ9)


## Getting Started
To explore these visualizations, please download the Power BI file from this repository and open it in Power BI Desktop.

---

## How to Use
1. **SQL Code**:
   - Import the dataset into Microsoft SQL Server.
   - Use provided SQL scripts for cleaning and analysis.
2. **Excel**:
   - Open the provided Excel file for pivot table insights.
   - Apply transformation formulas as needed.
3. **Power BI**:
   - Import cleaned data for visualization.
   - Use the included PBIX file to view or enhance the dashboard.

---

## Repository Structure
- **SQL Scripts**: SQL code for database creation, cleaning, and analysis.
- **Excel File**: Cleaned dataset with pivot tables and formulas.
- **Power BI File**: Interactive dashboard (PBIX format).
- **Dataset**: Original and cleaned datasets.
- **Documentation**: Detailed steps and methodology.

## Acknowledgements
Special thanks to the data sources and contributors who made this analysis possible.

---

## Contact
Feel free to reach out for questions, feedback, or collaboration opportunities:
- **Name**: Anwesh Nandi
- **Location**: India
- **Email**: anwesh.nandi1@gmail.com
- **LinkedIn**: [Anwesh Nandi](https://www.linkedin.com/in/anwesh-nandi-aab8011b7)

---

Enjoy exploring the world of technology companies with this project!

