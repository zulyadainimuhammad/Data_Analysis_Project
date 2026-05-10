-- A1. Calculate the total sales for each respective month

Create View A1 As
Select
To_Char(Transaction_Date, 'Month') as Month_Name,
Sum(Quantity * Unit_Price) as Total_Sales
From Transactions
Group By
To_Char(Transaction_Date, 'Month'),
Date_Part('Month', Transaction_Date)
Order By Date_Part('Month', Transaction_Date);

Select * From A1

-- A2. Determine the month-on-month increase or decrease in sales


Create View AA2 As
SELECT 
TO_CHAR(transaction_date, 'Mon YYYY') AS month,
SUM(quantity * unit_price) AS total_sales,
LAG(SUM(quantity * unit_price)) OVER (ORDER BY DATE_TRUNC('month', transaction_date)) AS previous_month_sales,
(SUM(quantity * unit_price) - LAG(SUM(quantity * unit_price)) OVER (ORDER BY DATE_TRUNC('month', transaction_date))) AS sales_change,
ROUND(((SUM(quantity * unit_price) - LAG(SUM(quantity * unit_price)) OVER (ORDER BY DATE_TRUNC('month', transaction_date)))
/ NULLIF(LAG(SUM(quantity * unit_price)) OVER (ORDER BY DATE_TRUNC('month', transaction_date)), 0)
) * 100, 2
) AS percent_change
FROM transactions
GROUP BY 
DATE_TRUNC('month', transaction_date),
TO_CHAR(transaction_date, 'Mon YYYY')
ORDER BY 
DATE_TRUNC('month', transaction_date);

Select * From AA2


-- A3. Calculate the difference in sales between the selected month and the previous month

Create View A3 As
SELECT 
TO_CHAR(transaction_date, 'Mon YYYY') AS month,
SUM(quantity * unit_price) AS total_sales,
LAG(SUM(quantity * unit_price)) OVER (ORDER BY DATE_TRUNC('month', transaction_date)) AS previous_month_sales,
(SUM(quantity * unit_price) - LAG(SUM(quantity * unit_price)) OVER (ORDER BY DATE_TRUNC('month', transaction_date))) AS sales_difference
FROM transactions
GROUP BY 
DATE_TRUNC('month', transaction_date),
TO_CHAR(transaction_date, 'Mon YYYY')
ORDER BY 
DATE_TRUNC('month', transaction_date);

Select * From A3
	


--B1. Calculate the total number of orders for each respective month

Create View B1 As
Select 
To_Char(Transaction_Date, 'Mon YYYY') as Month,
Count(Transaction_Id) as Total_Orders
From Transactions
Group By
Date_Trunc('Month', Transaction_Date),
To_Char(Transaction_Date, 'Mon YYYY')
Order By
Date_Trunc('Month', Transaction_Date);

Select * From B1


--B2. Determine the month-on-month increase or decrease in the number of orders.

Create View B2 as
Select
To_Char(Transaction_Date, 'Mon YYYY') as Month,
Count(Transaction_Id) as Total_Orders,
Lag(Count(Transaction_Id))
Over(Order By Date_Trunc('Month', Transaction_Date)) as Previous_Month_Orders,
(Count(Transaction_Id) - Lag(Count(Transaction_Id))
Over(Order by Date_Trunc('Month', Transaction_Date))) as Order_Change,
Round(((Count(Transaction_Id) - Lag(Count(Transaction_Id))
Over(Order By Date_Trunc('Month', Transaction_Date)))::numeric
/ Nullif(Lag(Count(Transaction_Id))
Over(Order By Date_Trunc('Month', Transaction_Date)), 0)) *100,2) as Percent_Change
From Transactions
Group By 
Date_Trunc('Month', Transaction_Date),
To_Char(Transaction_Date, 'Mon YYYY')
Order By
Date_Trunc('Month', Transaction_Date);

Select * From B2


--B3. Calculate the difference in the number of orders between the selected month and the previous month

Create View B3 As
Select
To_Char(Transaction_Date, 'Mon YYYY') as Month,
Count(Transaction_Id) as Total_Orders,
Lag(Count(Transaction_Id))
Over(Order By Date_Trunc('Month', Transaction_Date)) as Previous_Month_Orders,
(Count(Transaction_Id) - Lag(Count(Transaction_Id))
Over(Order By Date_Trunc('Month', Transaction_Date))) as Order_Change
From Transactions
Group By
Date_Trunc('Month', Transaction_Date),
To_Char(Transaction_Date, 'Mon YYYY')
Order By
Date_Trunc('Month', Transaction_Date);

Select * From B3


--C1. Calculate the total quantity sold for each respective month.

Create View CC1 as
Select 
To_Char(Transaction_Date, 'Mon YYYY') as Month,
Sum(Quantity) as Total_Quantity
From Transactions
Group By
Date_Trunc('Month', Transaction_Date),
To_Char(Transaction_Date, 'Mon YYYY')
Order By
Date_Trunc('Month', Transaction_Date);

Select * From CC1


--C2. Determine the month-on-month increase or decrease in the total quantity sold.

Create View C2 as
Select 
To_Char(Transaction_Date, 'Mon YYYY') as Month,
Sum(Quantity) as Total_Quantity,
Lag(Sum(Quantity))
Over(Order by Date_Trunc('Month', Transaction_Date)) as Previous_Month_Quantity,
(Sum(Quantity) - Lag(Sum(Quantity))
Over(Order by Date_Trunc('Month', Transaction_Date))) as Quantity_Change,
Round(((Sum(Quantity) - Lag(Sum(Quantity))
Over(Order By Date_Trunc('Month', Transaction_Date)))::numeric
/ nullif(Lag(Sum(Quantity))
Over(Order by Date_Trunc('Month', Transaction_Date)),0)) * 100,2) as Percent_Change
From Transactions
Group By 
Date_Trunc('Month', Transaction_Date),
To_Char(Transaction_Date, 'Mon YYYY')
Order By
Date_Trunc('Month', Transaction_Date);

Select * From C2


--C3. Calculate the difference in the total quantity sold between the selected month and the previous month

Create View C3 As
Select 
To_Char(Transaction_Date, 'Mon YYYY') As Month,
Sum(Quantity) As Total_Quantity,
Lag(Sum(Quantity))
Over(Order By Date_Trunc('Month', Transaction_Date)) As Previous_Month_Quantity,
Sum(Quantity) - Lag(Sum(Quantity))
Over(Order By Date_Trunc('Month', Transaction_Date)) As Quantity_Change
From Transactions
Group By
Date_Trunc('Month', Transaction_Date),
To_Char(Transaction_Date, 'Mon YYYY')
Order By
Date_Trunc('Month', Transaction_Date)

Select * From C3

