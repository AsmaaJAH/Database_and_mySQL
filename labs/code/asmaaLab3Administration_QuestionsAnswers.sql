-- ----------------------------------------
-- administration questions
-- ----------------------------------------
-- Q 10:
-- ===

alter table book row_format= compressed;
alter table book_authors row_format= compressed;
alter table book_copies row_format= compressed;
alter table book_loans row_format= compressed;
alter table borrower row_format= compressed;
alter table library_branch row_format= compressed;
alter table publisher row_format= compressed;
select table_name as "table",
ROUND(((data_length+ index_length)/1024/1024),2 ) as  "Size(MB)"
from information_schema.tables
where table_schema="sample_asmaa_commudepartment"
order by(data_length+ index_length) DESC;

-- -------------------------------------------------------------------------------
-- Q 13:
-- ===
SELECT * FROM sample_asmaa_commudepartment.publisher where Phone like '%\39';
-- -------------------------------------------------------------------------------
-- Q14:
-- ====
alter user 'HR'@'%' password expire;
drop user 'SAMPLE' @'%';