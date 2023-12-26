DELIMITER ^^
create trigger onUpdate_DeptNum_cascade_theEmpDno after update on DEPT for each row
begin
update employee 
	set Dno = new.Dnumber
	where Dno = old.Dnumber ;
end ^^
DELIMITER ;