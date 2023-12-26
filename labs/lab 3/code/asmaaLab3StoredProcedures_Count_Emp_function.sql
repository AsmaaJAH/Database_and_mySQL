DELIMITER **
create function Count_Emp (Dnumber int) returns int deterministic
Begin
declare myCount int;
select COUNT(*) into myCount from EMPLOYEE where Dno=Dnumber;
return myCount;
end **
DELIMITER ;