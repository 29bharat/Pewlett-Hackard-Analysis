# Pewlett-Hackard-Analysis
  
## Challenge 7 - Part 1
Objective: 
  
From the given data, we need to derive the number of employees who are retiring and also from which title. 
  
We would also like to find out how many employees are retiring per title per date with no duplicates. 
  
From the given data files, we would also like to find out which currrent employees can be potential mentors based on their birth date and title.
  
### Number of Titles Retiring
  
Tables joined: Employees table is the driving table since we are looking for employees who are retiring with their titles and salaries. We get Emp_no, first_name and last_name from employees and join to titles to get their respective titles along with from_date by joining on emp_no from both tables. Further, to get the salary of each employee, we join the result to salaries table again on emp_no. Also, additional check was done to make sure that salaries table has unique emp_no i.e. no more than one salary exists for each employee.
Data: This data is stored in number_retirement_titles.csv in Data folder. Total rows: 65428
  
![alt text](https://github.com/29bharat/Pewlett_Hackard_Analysis/blob/master/Data/number_retirement_titles.PNG)

From the data we see that there are few employees who were holding more than one title based on their from_date. However, for our analysis, it wouldn't make sense to take into account those rows where an employee is no longer in that title anymore. Hence we will try to remove these duplicates by using partitioning in the following section.
  
### Only the Most Recent Titles
Tables used: number_retirement_titles - derived from the above
To get the most recent titles of the employees who are retiring, we're using the feature of partitioning. What it does is - it ranks the rows for titles grouped by the emp_no, first_name, last_name by dec order of from_date. The most latest title will be ranked 1 followed by rank 2 to the previous titles and 3 to the second previous title and so on. What we have done is filtered this data to exclude everything but rank = 1 so that we get the latest titles of these employees. This data is store in number_retirement_latest_titles.csv in Data folder: Total rows: 41381. We see that after removinig duplicates the rows count has dropped by about 24k.
  
To get the counts of each title by date desc, we have grouped by from_date and title to do a count of emp_no. This gives us the count of employees retiring under each titles by date. This data is stored in count_employee_titles.csv in Data folder
  
Data:
  
![alt text](https://github.com/29bharat/Pewlett_Hackard_Analysis/blob/master/Data/count_employee_titles.PNG)

### Who’s Ready for a Mentor?
Tables used: Titles table was first updated to remove duplicates so that we have the list of employees with thier latest titles. This data is stored in latest_titles.csv
  
Employees table is then joined on emp_no to latest_titles table to get the employee info i.e. emp_no, first_name, last_name, title, from_date and to_date. Since we are looking for mentors born in 1965, hence filter was used on employees birth_date for January 1, 1965 to December 31, 1965. Also, to ensure that the employees are currently employed, we sue a filter on the to_date of the dept_emp table to be ('9999-01-01'). We join to this table on emp_no to get the final mentor_list.csv in Data folder.
  
Data:
  
![alt text](https://github.com/29bharat/Pewlett_Hackard_Analysis/blob/master/Data/Mentor_List.PNG)
