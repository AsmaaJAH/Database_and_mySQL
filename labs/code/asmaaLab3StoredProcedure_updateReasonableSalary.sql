DELIMITER $$
create procedure update_reasonable_salary(in employeeSSN int,in newSalary int )
begin
declare managerSSN int;

-- join to know the manager of the disered employee:
select Mgr_ssn into managerSSN from
 DEPT natural join employee where Ssn= employeeSSN;
 
-- if the manger salary is less than the empolyee salary ,
--  update the manager salary
update employee
	set salary = newSalary 
    where  salary < newSalary and Ssn=managerSSN;

-- then update the employee salary     
update employee
	set salary = newSalary 
    where  Ssn=employeeSSN;
end $$
DELIMITER ;