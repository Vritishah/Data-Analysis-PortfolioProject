Sales Analysis of ABC Company

Requirement of the project:
1.	Top 5 and Bottom 5 products by sale (Ribbon chart to know the ranks of the products)
2.	Sales by region
3.	All details about a product in a given order ID
4.	Number of orders by time of the day
5.	Number of orders by date
6.	Sales by month
7.	Orders by Month
8.	Top 5 and Bottom 5 products by cost
9.	5 most and 5 least ordered products
10.	Relationship between sales and quantity ordered

Steps
Option 1 - Loaded data in Power BI – One Excel at a time
Option 2 – Load data – get data > More > Folder > Select entire folder and click (combine and load)/(combine and transform)
Cleaning Data (same for both options)
-	Removed blank rows by using ‘Remove blank rows’ option
-	Check for errors – first check what is the error by clicking ‘keep errors’ option. In our case there was datatype error. So we converted the datatype to text (by using filter option) checked the errors and then removed them by using ‘remove errors’ option
-	Changed the datatype for date by using ‘Using Locale’ option and changing the locale to English(United States) 
-	Combined 4 different queries/tables into one table/query by using ‘Append Queries ‘ option
-	Remove duplicates
-	Structuring the data using the key parameters
o	Created sales column
o	Separated date and time column
o	Created city column by using extract > delimiters
o	Extracted month column
What to check before proceeding to report making in Power BI
1.	Data types
2.	Data profiling – shows distinct and unique counts (important for the primary key column as both distinct and unique count should be same)
3.	Column distribution
4.	Column Quality – shows errors and blanks
Take aways:
Learnt to use Drill Through option
Learnt to use tooltip option
Used Map chart
