create database HR_Analytics;
use HR_Analytics;
select * from hr_Data;
select count(*) from hr_data;
SELECT
    COUNT(*) AS TotalRecords,
    COUNT(`ï»¿Employee ID`) - COUNT(CASE WHEN `ï»¿Employee ID` IS NULL THEN 1 END) AS Null_EmployeeID,
    COUNT(MonthlyRate) - COUNT(CASE WHEN MonthlyRate IS NULL THEN 1 END) AS Null_MonthlyRate,
    count(Numcompaniesworked)- count(case when numcompaniesworked is null then 1 end) as null_numcompworked,
    count(overtime)-count(case when overtime is null then 1 end) as null_overtime,
    count(percentsalaryhike)-count(case when percentsalaryhike is null then 1 end) as null_persalhike,
    count(`PerformanceRating`)-count(case when`PerformanceRating` is null then 1 end) as perfrating,
    count(relationshipsatisfaction)-count(case when relationshipsatisfaction is null then 1 end) as relstatfcn,
    count(stockoptionlevel)-count(case when stockoptionlevel is null then 1 end) as stockoption,
    count(totalworkingyears)-count(case when totalworkingyears is null then 1 end) as workingyr,
    count(`Monthly Income group`)- count(case when `Monthly Income group` is null then 1 end) as monthgroup,
    count(`TrainingTimesLastYear`)-count(case when `TrainingTimesLastYear` is null then 1 end) as triningtimes,
    count(`YearsInCurrentRole`)-count(case when `YearsInCurrentRole` is null then 1 end) as yearincurrentrole,
    count(`YearsWithCurrManager`)-count(case when `YearsWithCurrManager` is null then 1 end) as yrwithmngr,
    count(`Workm life balance`)-count(case when `Workm life balance` is null then 1 end) aswoklifeblnce,
     count(`yr since last prmtn grp`)-count(case when `yr since last prmtn grp` is null then 1 end)as yrsinprmtn,
      count(`Year at Company GROUP`)-count(case when`Year at Company GROUP`  is null then 1 end) as yratcopmgp,
      count(`Age`)-count(case when`Age` is null then 1 end) as age,
      count(`Attrition`)-count(case when `Attrition`is null then 1 end) as attrition,
      count(`BusinessTravel`)-count(case when `BusinessTravel` is null then 1 end)as buistravel,
      count(`DailyRate`)-count(case when`DailyRate` is null then 1 end)as dailyrate,
      count(`Department`)-count(case when `Department`is null then 1 end) as dep,
      count(`DistanceFromHome`)-count(case when`DistanceFromHome`  is null then 1 end) as disfromhome,
      count(`Education`)-count(case when `Education` is null then 1 end) as eductn,
      count(`EducationField`)-count(case when `EducationField` is null then 1 end) as edufield,
       count(`EnvironmentSatisfaction`)-count(case when `EnvironmentSatisfaction` is null then 1 end) as envrmntstfctn,
       count(`Gender`)-count(case when `Gender` is null then 1 end) as gndr,
       count(`HourlyRate`)-count(case when  `HourlyRate`is null then 1 end) as hrlyrate,
       count(`JobInvolvement`)-count(case when `JobInvolvement` is null then 1 end) as jobinvlmnt,
       count(`JobLevel`)-count(case when `JobLevel` is null then 1 end) as joblvl,
       count(`Job Role`)-count(case when `Job Role`is null then 1 end) as Jobrole,
        count(`JobSatisfaction`)-count(case when`JobSatisfaction` is null then 1 end) as Jobstfctn,
       count(`MaritalStatus`)-count(case when`MaritalStatus` is null then 1 end) as mrgstts,
        count(`Total Work Year Group`)-count(case when `Total Work Year Group`is null then 1 end) as totworkyrgp
        from hr_data;
      
      SELECT `ï»¿Employee ID`, COUNT(*) AS DuplicateCount
FROM HR_data
GROUP BY `ï»¿Employee ID`
HAVING COUNT(*) > 1;

 SELECT *
FROM HR_data
WHERE MonthlyRate <= 0 OR HourlyRate <= 0;


#---count of active employee and attrition

SELECT 
    COUNT(*) AS Total_Employees,
    COUNT(CASE WHEN Attrition = 'No' THEN 1 END) AS Active_Employees,
    COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) AS Attrition_Employees
FROM HR_data;

#---count of active employee and attrition by gender

SELECT 
    COUNT(CASE WHEN Attrition = 'No' AND Gender = 'Male' THEN 1 END) AS Active_Male_Employees,
    COUNT(CASE WHEN Attrition = 'No' AND Gender = 'Female' THEN 1 END) AS Active_Female_Employees
FROM HR_data;

SELECT 
    COUNT(CASE WHEN Attrition = 'Yes' AND Gender = 'Male' THEN 1 END) AS Attrition_Male_Employees,
    COUNT(CASE WHEN Attrition = 'Yes' AND Gender = 'Female' THEN 1 END) AS Attrition_Female_Employees
FROM HR_data;
 


   
  
#---Average Attrition Rate for All Departments
  
  SELECT concat(format( AVG(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)*100,2),"%") AS Avg_Attrition_Rate
FROM HR_data;
  
#-- Average Attrition Rate for Each Department

  SELECT Department, concat(format(avg(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)*100,2),"%") AS Avg_Attrition_Rate
FROM HR_data
GROUP BY Department;
  
  #---4. Average Hourly Rate of Male Research Scientists

  SELECT AVG(HourlyRate) AS Avg_Hourly_Rate
FROM HR_data
WHERE Gender = 'Male' AND`Job Role`  = 'Research Scientist';


#--Attrition Rate vs Monthly Income Status

SELECT`Monthly Income group` , concat(format(AVG(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)*100,2),"%") AS Attrition_Rate
FROM HR_data
GROUP BY `Monthly Income group`;

#---Average Working Years for Each Department

SELECT Department,AVG(TotalWorkingYears) AS Avg_Working_Years
FROM HR_data
GROUP BY Department;



#---Job Role vs Work-Life Balance


SELECT`Job Role` ,`Workm life balance` , COUNT(*) AS Count
FROM HR_data
GROUP BY`Job Role` , `Workm life balance` order by `Workm life balance`;


#---Attrition Rate vs Years Since Last Promotion


SELECT`yr since last prmtn grp` , concat(format(AVG(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)*100,2),"%") AS Attrition_Rate
FROM HR_data
GROUP BY`yr since last prmtn grp` order by `yr since last prmtn grp`;


#---9. Attrition Rate of Male and Female Employees

SELECT Gender, concat(format(AVG(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)*100,2),"%") AS Attrition_Rate
FROM HR_data
GROUP BY Gender;
