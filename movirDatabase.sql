use moviedatabase;

create table actor(
act_id int primary key,
act_name varchar(20),
act_gender char(1)
);

create table director(
dir_id int primary key,
dir_name varchar(20),
dir_phone varchar(10)
);

alter table actor modify act_id varchar(5);
create table movies(
mov_id varchar(4) primary key,
mov_title varchar(20),
mov_year varchar(4),
mov_lang varchar(20),
dir_id varchar(4),
foreign key(dir_id) references director(dir_id));
show tables;


create table movie_cast(
act_id varchar(5) ,
mov_id varchar(5),
role varchar(20),
primary key(act_id,mov_id),
foreign key(act_id) references actor(act_id),
foreign key(mov_id) references movies(mov_id));


create table rating(
mov_id varchar(5) primary key,
rev_stars varchar(20),
foreign key(mov_id) references movies(mov_id)
);
show tables;
desc actor;

INSERT INTO ACTOR VALUES ('1', 'MADHURI DIXIT', 'F');
INSERT INTO ACTOR VALUES ('2', 'AAMIR KHAN', 'M');
INSERT INTO ACTOR VALUES ('3', 'JUHI CHAWLA', 'F');
INSERT INTO ACTOR VALUES ('4', 'SRIDEVI', 'F');
INSERT INTO ACTOR VALUES ('5', 'SALMANKHAN', 'M');

desc director;


INSERT INTO DIRECTOR VALUES ('100','SUBHASH KAPOOR','9346452542');
INSERT INTO DIRECTOR VALUES ('101','ALYAN TAYLOR','9966135231');
INSERT INTO DIRECTOR VALUES ('102','SANTOSH ANANDDRAM','9966196437');
INSERT INTO DIRECTOR VALUES ('103','HITCHCOCK','9966166382');
INSERT INTO DIRECTOR VALUES ('104','STEVEN SPIELBERG','9966138934');

INSERT INTO MOVIES VALUES ('501','RAJAKUMARA','2017','KANNADA','101');
INSERT INTO MOVIES VALUES ('502','JOLLY LLB 2', '2013','HINDI', '102');
INSERT INTO MOVIES VALUES ('503','TERMINATOR GENESYS','2015','ENGLISH','103');
INSERT INTO MOVIES VALUES ('504','JAWS','1975','ENGLISH','104');
INSERT INTO MOVIES VALUES ('505','BRIDGE OF SPIES','2015','ENGLISH', '104');

desc movie_cast;

show tables;
INSERT INTO MOVIE_CAST VALUES ('1', '501','HEROINE');
INSERT INTO MOVIE_CAST VALUES ('1', '502','HERO');
INSERT INTO MOVIE_CAST VALUES ('3', '503','COMEDIAN');
INSERT INTO MOVIE_CAST VALUES ('4', '504','GUEST');
INSERT INTO MOVIE_CAST VALUES ('4', '501','HERO');


INSERT INTO RATING VALUES ('501', '4');
INSERT INTO RATING VALUES ('502', '2');
INSERT INTO RATING VALUES ('503', '5');
INSERT INTO RATING VALUES ('504', '4');
INSERT INTO RATING VALUES ('505', '3');

select * from actor;
select * from director;
select * from movies;
select * from movie_cast;
select * from rating;

-- 1.Listthe titles of all movies directed by ‘Hitchcock’.

select d.dir_name,m.mov_title,d.dir_phone 
from director d
join movies m on d.dir_id=m.dir_id
where d.dir_name='hitchcock';


-- .Find the movie names where one or more actors acted in two or more movies.


select m.mov_title from movies m 
join movie_cast mc on mc.mov_id=m.mov_id 
where mc.act_id in(
select act_id from movie_cast group by act_id having count(distinct mov_id)>1)
group by m.mov_title;

-- List all actors who acted in a movie before 2000 and also in a movie after 2015 (use JOIN
-- operation)

select act_name,mov_title,mov_year from actor a join movie_cast mc on mc.act_id=a.act_id 
join movies m on mc.mov_id=m.mov_id
where m.mov_year not between 2000 and 2015;

/* Find the title of movies and number ofstars for each movie that has at least one rating and find
 the highest number of stars that movie received. Sort the result by movie title.
*/
select mov_title,max(rev_stars) from movies m,rating r
where m.mov_id=r.mov_id 
group by mov_title
having max(rev_stars)>'0';


-- Update the rating of all movies directed by ‘Steven Spielberg’ to 5.
update rating set rev_stars ='5' where mov_id in(
select mov_id from movies where dir_id in(
select dir_id from director where dir_name='steven spielberg'
));

select * from rating;