# Ordersales-Analysis
Data cleaning using python &amp;  Data analysis using advanced SQL queries in SQL Server

Dataset was first imported using Kaggle API. Some of the columns had 'Not Available' or "Unknown" values. These values were replaced with "Nan" value as part of Data cleaning.
New calculated columns were then created namely [Discount], [Sale_Price] & [Profit] as  follows as part of Data transformation for Data analysis 
df['discount'] = df['list_price']*df['discount_percent']*.01
df['sale_price'] = df['list_price']-df['discount']
df['profit'] = df['sale_price']-df['cost_price']
Unwanted columns were then removed namely ['cost_price'], ['list_price'],['discount_percent'] &  finally the cleaned dataset was then exported to Sql Server for data analysis

Data Analysis in SQL Server consisted of 5 ques only e.g top 5 highest selling products in each region,  month over month growth comparison for 2022 & 2023 sales eg. jan 2022 vs jan 2023, Which sub category had highest growth by profit in 2023 compare to 2022. Advanced SQL queries involving Case expression, Window function & Sub queries were used to derive solutions.
