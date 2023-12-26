DELIMITER ##
create trigger check_employee_count before insert on EMPLOYEE for each row
begin
	if Count_Emp(NEW.Dno) >= 8 then 
    -- equal because the trigger should be triggered after inserting the 8 the employee
		-- SET SQL_SAFE_UPDATES = 0;
		signal sqlstate '45000';
        -- SET SQL_SAFE_UPDATES = 1;
	end if;
end ##
DELIMITER ;
