DELIMITER $$
/*
Delimiters other than the default ; are typically used when defining functions,
stored procedures, and triggers wherein you must define multiple statements.
defining a different delimiter like $$ which is used to define the end of the entire procedure, 
but inside it, individual statements are each terminated by ;.
*/
create procedure insertRandom(in numRows int)
begin
	declare i int ;
	declare pName varchar(45) ;
	declare count int default 0;
	set i=1;
	start transaction;
	loop1: while i<= numRows do
		set pName= CONCAT(left(MD5(RAND()), 39),i);
        select count(*) into count from publisher where 'PublisherName'=pName;
        if count > 0 then
			iterate loop1;
		end if;
        insert into publisher values (pName, left(MD5(RAND()),100), left(MD5(RAND()),13) );
        set i=i+1;
	end while;
    commit;
    
	set i=1;
    start transaction;
    while i<= numRows do
		insert into book(  Title, PublisherName)
        select left(MD5(RAND()), 45), PublisherName
        FROM publisher limit i,1;
        set i=i+1;
	end while;
    commit;  
  
    
    set i=1;
    start transaction;
    while i<= numRows do
		set pName= CONCAT(left(MD5(RAND()), 39),i);
        select count(*) into count from book_authors where 'AuthorName'=pName;
        insert into book_authors(AuthorName,BookID)
        select pName , BookID from book limit i,1;
        set i=i+1;
	end while;
    commit;
    
	set i=1;
    start transaction;
    while i<= numRows do
        insert into library_branch(BranchName,Address)
        Values(left(MD5(RAND()),45), left(MD5(RAND()),100));
        set i=i+1;
	end while;
    commit;
    
	set i=1;
    start transaction;
    while i<= numRows do
        insert into borrower (borrowerName,Address,phone)
        Values(left(MD5(RAND()),45), left(MD5(RAND()),100),left(MD5(RAND()),13));
        set i=i+1;
	end while;
    commit;
    
    set i=1;
    start transaction;
    while i<= numRows do
        insert into book_copies ( BookID, BranchID, No_Of_Copies)
        select BookID,BranchID, (10+CEIL(RAND()*(1000-10)))
        FROM book, library_branch limit i,1;
        set i=i+1;
	end while;
    commit;
    
	set i=1;
    start transaction;
    while i<= numRows do
        insert into book_loans( BookID, BranchID, CardNo, DateOut, DueDate)
        select BookID,BranchID, CardNo , curdate(),curdate()
        FROM book, library_branch, borrower limit i,1;
        set i=i+1;
	end while;
    commit;
    end$$
/* Finally, reset the delimiter to the default ; */
DELIMITER ;
