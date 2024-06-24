create database example;

create table practice(id int primary key, age int not null check (age>21), city varchar(50) unique)

insert into practice (id,age,city) values
(1,25,'bengaluru'),(2,26,'mumbai'),(3,27,'delhi'),(4,28,'chennai'), (5,29,'kolkata')

select * from practice

select max(age) as max_age,min(age) as min_age, avg(age) as avg_age, sum(age) as sum_of_age, 
count(city) as city_count from practice

select id,age,city, rank() over(order by age Desc) as rank
from practice
where age>=27

insert into practice values (6,30,'cochin')
select * from practice

update practice
set city = 'kannur' where city = 'cochin'

select * from practice

exec sp_rename 'practice.city', 'indian_city', 'COLUMN'

SELECT * from practice

alter table practice
add pincode varchar(20)

update practice
set pincode = 10 where id = 1

update practice
set pincode = 20 where id =2

select indian_city, lead(indian_city) over(order by age) as next_value, lag(indian_city) over (order by age) as previous_value
from practice

select max(age) as sec_max_age from practice
where age<(select max(age) from practice)

alter table practice
add gender varchar(10)

update practice
set gender = 'male' where id = 1

update practice
set gender = 'male' where id = 2
update practice
set gender = 'female' where id = 3
update practice
set gender = 'female' where id = 4
update practice
set gender = NULL where id = 5
update practice
set gender = NULL where id = 6

select * from practice

update practice
set gender = case
when gender = 'male' then 0
when gender = 'female' then 1
else gender --
end

with top_three_ages as(
select id,age,indian_city,rank() over(order by age desc) as age_rank
from practice)

select id,age,age_rank from top_three_ages
where age_rank <=3

begin transaction
update practice
set age = 31 where indian_city = 'kannur'

save transaction x

update practice
set age = 32 where indian_city = 'kannur'

select age from practice

rollback transaction x
commit

rollback transaction

create view [only_id_and_age] as
select id,age from practice
where age>=25

select * from only_id_and_age

create procedure sample_city
@city varchar(30) as
 select * from practice
 where indian_city = @city
 go

exec sample_city @city = 'bengaluru'