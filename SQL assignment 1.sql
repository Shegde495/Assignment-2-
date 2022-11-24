-- create a table
CREATE TABLE Dept_table (
  Dept_id INTEGER ,
  Dname VARCHAR(30) ,
  location VARCHAR(30),
  constraint pk_dept PRIMARY KEY(Dept_id)
);
-- insert some values
INSERT INTO Dept_table VALUES (10,'Accounts','Bangalore');
INSERT INTO Dept_table VALUES (20,'IT','Delhi');
INSERT INTO Dept_table VALUES (30,'Production','Chennai');
INSERT INTO Dept_table VALUES (40,'sales','Hyderbad');
INSERT INTO Dept_table VALUES (50,'Admin','London');

CREATE TABLE Emp_table(
Empno INTEGER,
Ename VARCHAR(30) ,
sal INTEGER,
hire_date date,
comission INTEGER,
Dept_id INTEGER,
mgr INTEGER,
constraint pk_emp PRIMARY KEY(Empno),
constraint fk_dept_id foreign key (Dept_id) references Dept_table(Dept_id) on delete set null,
constraint fk_mgr foreign key (mgr) references Emp_table(Empno) on delete set null
);

INSERT INTO Emp_table VALUES(1001,'sachin',19000,'1980-01-01',2100,20,null);
INSERT INTO Emp_table values (1002,'kapil',15000,'1970-01-01',2300,10,null);
INSERT INTO Emp_table values (1003,'stephen',12000,'1990-01-01',500,20,NULL);
INSERT INTO Emp_table values (1004,'williams',9000,'2001-01-01',NULL,30,NULL);
INSERT INTO Emp_table values (1005,'john',5000,'2005-01-01',NULL,30,NULL);
INSERT INTO Emp_table values (1006,'Dravid',19000,'1985-01-01',2400,10,NULL);
INSERT INTO Emp_table values (1007,'Martin',21000,'2000-01-01',1040,NULL,NULL);

update Emp_table
set mgr=1003
where Empno=1001;
update Emp_table
set mgr=1003
where Empno=1002;
update Emp_table
set mgr=1007
where Empno=1003;
update Emp_table
set mgr=1007
where Empno=1004;
update Emp_table
set mgr=1006
where Empno=1005;
update Emp_table
set mgr=1007
where Empno=1006;

--1)
select * 
from Emp_table
where Emp_table.Dept_id =10 or Emp_table.Dept_id=30;


--2)
select Dept_table.Dept_id,Dept_table.Dname,Dept_table.location,count(Empno)as total 
from Dept_table
right join Emp_table on Emp_table.Dept_id=Dept_table.Dept_id
group by Dept_table.Dept_id
order by total desc limit 3 ;


--3)
select *
from Emp_table
where Ename regexp '^[s]';

--4)
select *
from Emp_table
where year(hire_date)<(select (year(max(hire_date))-2)
from Emp_table);


--5)
select replace(Ename,'s','$')
 as new_name
from Emp_table
where Ename regexp '^[s]';

--6)
select p.Ename as manager , s.Ename as employee
from Emp_table p
join Emp_table s on p.Empno=s.mgr;


--7)
select Dept_table.Dept_id,sum(Emp_table.sal) as total
from Dept_table
left join Emp_table on Emp_table.Dept_id=Dept_table.Dept_id
group by Dept_table.Dept_id;


--8)
select *
from Emp_table
left join Dept_table on Dept_table.Dept_id=Emp_table.Dept_id;

--9)
update Emp_table
set sal = sal+(sal*10/100);
select sal from Emp_table;


--10)
select Empno
from Emp_table
join Dept_table on Emp_table.Dept_id=Dept_table.Dept_id
where location != 'chennai';


--11)
select Ename,sal+comission as total
from Emp_table
;




--12)
alter TABLE Emp_table
alter column Ename
VARCHAR (250);


--13)
select  current_date , current_time;


-- 14)
CREATE TABLE student(
student_id INTEGER PRIMARY KEY,
student_name VARCHAR(15),
major VARCHAR(20),
gender VARCHAR(1),
date_of_birth date);


-- 15)
select count(Empno)
from Emp_table
where sal>10000;

-- 16)
select min(sal) as minimum,max(sal) as maximum ,avg(sal) as average_salary
from Emp_table;

-- 17)
select count(Empno) as employees,location
from Dept_table
left join Emp_table on Emp_table.Dept_id=Dept_table.Dept_id
group by location
order by employees desc;



--18)
select Ename 
from Emp_table
order by Ename desc;

--19)
CREATE TABLE Emp_BKP
as select *
from Emp_table;

--20)
select concat(substring(ename,1,3),sal)
from Emp_table
order by left(ename,3);

--21)
select *
from Emp_table
where Ename= any (select Ename
from Emp_table
where ename regexp '^s');

--22)
select *
from Dept_table
inner join Emp_table on Emp_table.Dept_id=Dept_table.Dept_id
where location='Bangalore';

23)
select *
from Emp_table
where Ename=any (select Ename
from Emp_table
where Ename regexp'^[a-k]');


--24)
select m.Ename as Employees_under_stephen
from Emp_table e
inner join Emp_table m on m.mgr=e.Empno
where e.Ename='stephen';

--25)
select  m.mgr as Manager_id ,
e.Ename as Manager_name,
count(e.Empno) as total_number_of_employees 
from Emp_table e
inner join Emp_table m on m.mgr=e.Empno group by m.mgr  order by total_number_of_employees desc limit 1;

--26)
select *
from Emp_table e
left join Dept_table on Dept_table.Dept_id=e.Dept_id
left join Emp_table m on e.Empno=m.mgr
where e.sal=all (select max(sal)
from Emp_table
where sal< any( select max(sal)
from Emp_table
));


--27)
select *
from Emp_table
inner join Dept_table on Dept_table.Dept_id=Emp_table.Dept_id
order by mgr asc;




--28)
select e.Empno as manager,
count(m.Empno) as number_of_employees,
(year(current_date)-year(e.hire_date)) as experience_of_manager, 
 e.Ename as manager_name,
e.comission,e.sal
from Emp_table e
inner join Emp_table m on m.mgr=e.Empno 
group by manager
order by number_of_employees;

--29)
select e.Ename
from Emp_table e 
inner join Emp_table m on e.Empno=m.mgr
inner join Dept_table on e.Dept_id=Dept_table.Dept_id
where location='Delhi' and e.comission <1000
order by e.Ename limit 1;

--30)
select *from Emp_table
where year(hire_date)< any (select year(hire_date)
from Emp_table
where Ename='Martin');













