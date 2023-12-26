create schema companyLab3;
use companyLab3;
create table DEPT(
Dnumber int auto_increment primary key,
Dname varchar(45),
founded date,
Mgr_ssn int  ,
budget int);
create table EMPLOYEE(
Ssn int primary key auto_increment,
Ename varchar(45),
Bdate date,
Dno int,
salary int);
alter table DEPT add constraint FK_Mgr_ssn FOREIGN KEY (Mgr_ssn) REFERENCES EMPLOYEE(Ssn);
alter table EMPLOYEE add constraint FK_Dno FOREIGN KEY (Dno) REFERENCES DEPT(Dnumber)

