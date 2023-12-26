-- INSERT 1 department:
insert into dept (Dnumber,Dname,founded,budget) values (1, "programming", '1940-01-01',1000);
-- insert 8 employees:
insert into employee (Ename,Bdate,Dno,salary) values("Nagy","1920-01-01",1,500);
insert into employee (Ename,Bdate,Dno,salary) values("asmaa", '1970-01-01',1,750);
insert into employee (Ename,Bdate,Dno,salary) values("Gamal","1920-01-01",1,500);
insert into employee (Ename,Bdate,Dno,salary) 
values
("Abdel-Halem", '1970-01-01',1,750),
("Mabrouk","1920-01-01",1,500),
("Mariam", '1970-01-01',1,750),
("Khouloud","1920-01-01",1,500),
("Asmaa Mohamed", '1970-01-01',1,750);
-- insert 9th employee: (The CURDATE function returns the current date)
insert into employee (Ename,Bdate,Dno,salary) values(check_employee_count"9th employeee",curdate(),1,500);
SELECT * FROM companylab3.employee;
SELECT COUNT(*) FROM companylab3.employee;
-- DROP TRIGGER check_employee_count;

