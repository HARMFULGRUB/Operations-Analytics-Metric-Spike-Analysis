create database if not exists jda;

use jda;

show tables;

select *
from job_data;

select ds, round((count(job_id)/sum(time_spent))*3600) as jobs_reviewed
from job_data
where ds like '11/%/2020'
group by ds
order by ds;

select ds, round((count(event)/sum(time_spent)),2) as throughput
from job_data
group by ds;

select `language`, (count(`language`)/8) * 100 as lang_share
from job_data
group by language
order by language desc;

select job_id, count(*) total
from job_data
group by job_id
having total > 1;

select actor_id, count(*) total
from job_data
group by actor_id
having total > 1;