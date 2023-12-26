DELIMITER !!
create procedure set_foundation_year()
begin
update DEPT set founded='1960/01/01' where year(founded) < 1960;
end !! 
DELIMITER ;
