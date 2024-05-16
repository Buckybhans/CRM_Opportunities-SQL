create database CRM_SYSTEM;
USE CRM_SYSTEM;

# CASE1
# display info on price of product initiated by sales agent using INNER JOIN
SELECT sales_pipeline.opportunity_id, sales_pipeline.account, sales_pipeline.sales_agent, 
products.product, products.sales_price 
from sales_pipeline join products
on sales_pipeline.product = products.product;

# CASE2
# displaying info on companies from different regional offices having deal stage on products using MULTIPLE JOINS
select a.account, a.sector, st.regional_office, sp.product, sp.engage_date, sp.deal_stage
from accounts as a 
join sales_pipeline as sp
on a.account = sp.account
join sales_teams as st
on st.sales_agent = sp.sales_agent
where deal_stage in ("won","lost");

# CASE3
# detailed info on company names and their annual revenue
select sp.account, a.sector, a.revenue
from sales_pipeline as sp
join accounts as a
on sp.account = a.account;

# CASE4
# count of unique companies from sales_pipeline table
select distinct account from sales_pipeline;
select count(account) from sales_pipeline;

# CASE5
# nubmer of sectors involved from accounts table
select count(sector) from accounts;
select distinct count(sector) from accounts;

# CASE6
# average annual revenue of companies listed w.r.t sales_pipeline and accounts table
select sp.account, 
round(avg(a.revenue), 3) as avg_revenue
from sales_pipeline as sp
join accounts as a
on sp.account = a.account
group by sp.account;

# CASE7
# average price of products w.r.t sales_pipeline table
select sp.product,
round(avg(p.sales_price), 2) as avg_product_price 
from sales_pipeline as sp
join products as p
on sp.product = p.product
group by sp.product;

# CASE8
# detailed info on revenue from deals for products based on ID's
select sp.opportunity_id, sp.sales_agent, sp.product, p.series, sp.deal_stage, sp.close_value
from sales_pipeline as sp
join products as p
on p.product = sp.product
order by sp.sales_agent ;

# CASE9 
# duration taken to solve deals
select opportunity_id, product,
case
when deal_stage = "won" then "Success"
else "Fail"
end as deal_status,
datediff(close_date, engage_date) as deal_duration_in_days
from sales_pipeline
order by opportunity_id;

# CASE10
# Differentiating companies based on employee count
select distinct account, 
case
when employees >= 5000 then "MNC"
when employees >= 1000 and employees < 5000 then "SME"
else "Start-up"
end as Organization_type
from accounts;

# CASE11
# Count of managers across companies
select sp.account,
count(st.manager) as total_managers
from sales_pipeline as sp
join accounts as a
on sp.account = a.account
join sales_teams as st
on sp.sales_agent = st.sales_agent
group by sp.account 
order by total_managers desc;

# CASE12
# average and total annual revenue for each sector
select sector, 
round(avg(revenue), 2) as Avg_Annual_Revenue,
round(sum(revenue), 2) as Total_Annual_Revenue
from accounts
group by sector;

# CASE13
# Number of sales agents working under each manager
select st.manager, 
count(sp.sales_agent) as no_of_sales_agents
from sales_pipeline as sp
join sales_teams as st
on sp.sales_agent = st.sales_agent
group by st.manager;

# CASE14
# Number of products handled by each manager
select st.manager,
count(sp.product) as no_of_products
from sales_pipeline as sp
join sales_teams as st
on sp.sales_agent = st.sales_agent
group by st.manager
order by no_of_products desc;

# CASE15
# office Locations of each and every sales agent
select distinct(sp.sales_agent), a.office_location, st.regional_office
from sales_pipeline as sp
join accounts as a
on sp.account = a.account
join sales_teams as st
on st.sales_agent = sp.sales_agent;