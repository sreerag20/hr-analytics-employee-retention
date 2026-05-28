create schema HR_Analyst;
use hr_analyst;

desc hr_1csv;
desc hr_2csv;

show tables;
select * from hr_1csv;
select * from hr_2csv;

#1  Average Attrition Rate for All Department 

select h1.Department, concat(format(avg(h1.attrition_yes)*100,2),'%') as Attrition_Rate
from  
( select department,attrition,
case when attrition='Yes'
then 1
Else 0
End as attrition_yes from hr_1csv ) as h1
group by h1.department
order by Attrition_Rate desc;

#2  Average Hourly Rate for Male Research Scientist
 
select JobRole, format(avg(hourlyrate),2) as Average_Hourly_Rate,Gender
from hr_1csv
where jobrole = 'Research Scientist' and gender='Male'
group by jobrole,gender;

#3  AttritionRate VS MonthlyIncomeStats against department

ALTER TABLE hr_2csv
CHANGE COLUMN `Employee ID` EmployeeID INT;

select h1.department, concat(format(avg(h1.attrition_rate)*100,2),'%') as Average_attrition,format(avg(h2.monthlyincome),2) as Average_Monthly_Income
from ( select department,attrition,employeenumber,
case when attrition = 'yes' then 1
else 0
end as attrition_rate from hr_1csv) as h1
inner join hr_2csv as h2 on h2.EmployeeID = h1.EmployeeNumber
group by h1.department
order by Average_attrition desc, Average_Monthly_Income;

#4  Average Working Years for Each Department
 
select h1.department, format(avg(h2.TotalWorkingYears),1) as Average_Working_Years
from hr_1csv as h1
inner join hr_2csv as h2 on h2.EmployeeID = h1.EmployeeNumber
group by h1.department
order by Average_Working_Years desc;

#5  Job Role VS Work Life Balance

select h1.JobRole,
sum(case when performancerating = 1 then 1 else 0 end) as 1st_Rating_Total,
sum(case when performancerating = 2 then 1 else 0 end) as 2nd_Rating_Total,
sum(case when performancerating = 3 then 1 else 0 end) as 3rd_Rating_Total,
sum(case when performancerating = 4 then 1 else 0 end) as 4th_Rating_Total, 
count(h2.performancerating) as Total_Employee, format(avg(h2.WorkLifeBalance),2) as Average_Work_Life_Balance_Rating
from hr_1csv as h1
inner join hr_2csv as h2 on h2.EmployeeID = h1.EmployeeNumber
group by h1.jobrole
order by Average_Work_Life_Balance_Rating desc;

#6  Attrition Rate Vs Year Since Last Promotion Relation Against Job Role 

select h1.JobRole,concat(format(avg(h1.attrition_rate)*100,2),'%') as Average_Attrition_Rate,
format(avg(h2.YearsSinceLastPromotion),2) as Average_Years_Since_Last_Promotion
from ( select JobRole,attrition,employeenumber,
case when attrition = 'yes' then 1
else 0
end as attrition_rate from hr_1csv) as h1
inner join hr_2csv as h2 on h2.EmployeeID = h1.EmployeeNumber
group by h1.JobRole
order by Average_Attrition_Rate desc, Average_Years_Since_Last_Promotion;

#7 Job role vs job satisfaction

select h1.JobRole, round(avg(h1.JobSatisfaction),2) as Avg_Job_Satisfaction
from hr_1csv h1
group by h1.JobRole
order by Avg_Job_Satisfaction desc;

#8 Gender vs avg work life balance

select h1.Gender as Gender, round(avg(h2.WorkLifeBalance), 2) as Avg_Work_Life_Balance
from hr_1csv h1
join hr_2csv h2
on h1.EmployeeNumber = h2.EmployeeID
group by Gender;
