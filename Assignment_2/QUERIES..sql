--create database
create database project_db;

--changed databse
use project_db;

--create tables
create table users(email varchar(40) primary key,password varchar(10),role enum('Student','admin'));

create table courses(course_id int primary key,course_name varchar(20),description varchar(500),fees int,start_date date,end_date date,video_expire_days int);

create table students(reg_no int primary key,name varchar(20),email varchar(40),course_id int,mobile_no int,profile_pic blob,foreign key(email) references users(email),foreign key (course_id) references courses(course_id));

create table videos(video_id int primary key,course_id int,title varchar(20),description varchar(300),youtube_url varchar(300),added_at date default(current_date),foreign key (course_id) references courses(course_id));


--inserting values in table courses
insert into courses values(1,"IIT-MERN-2025","MERN",4000,'2025-12-20','2026-01-20',30);
insert into courses values(7,"AI","some courses related to AI",10000,'2025-12-24','2026-01-24',5);
insert into courses values(8,"Android","Android related course",9999,'2025-12-24','2026-01-24',7);
insert into courses values(3,"python","py",10000,'2025-12-24','2026-01-24',20);
insert into courses values(11,"java","java course",5000,'2025-12-10','2026-01-5',20);

--inserting values in table users
insert into users values('s1','12345','student'),('s2','12345','student'),('s3','12345','student'),('a1','67890','admin');

--inserting values in table students
insert into students values(1,"student1","s1",1,123456,0x01),(3,"student3","s3",1,123456,0x01),(6,"student2","s2",3,123456,0x01);

--inserting values in table videos
INSERT INTO videos (video_id, course_id, title, description, youtube_url, added_at) VALUES(12, 1, 'MERN video 6', 'MERN', '', '2025-11-26'),(14, 1, 'MERN 10', 'MERN', '', '2025-11-26');

--Q1. Write a Sql query that will fetch all upcoming courses.
select * from courses  where start_date > current_date;

--Q2. Write a Sql query that will fetch all the registered students along with course name
select s.reg_no,s.name,s.email,s.mobile_no,s.course_id,c.course_name from 
students s inner join courses c on s.course_id=c.course_id;

-- Q3. Write an SQL query to fetch the complete details of a student (based on their email) along with the details of the course they are enrolled in.
select s.reg_no,s.name,s.email,s.mobile_no,s.course_id,c.course_name,c.description,c.fees,c.start_date,c.end_date,c.video_expire_days
from students s inner join courses c on s.course_id=c.course_id where s.email="s1";


--Q4. Write an SQL query to retrieve the course details and the list of non-expired videos for a specific student using their email address. A video is considered active (not expired) if its added_at date plus the courses video_expire_days has not yet passed compared to the current date.
select c.course_id,c.course_name,c.start_date,c.end_date,c.video_expire_days,v.video_id,v.title,v.added_at 
from courses c inner join videos v on c.course_id=v.course_id
inner join students s on s.course_id=c.course_id
where date_add(added_at, interval c.video_expire_days day)>current_date and s.email="s1" ;