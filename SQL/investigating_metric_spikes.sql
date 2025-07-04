select *
from events;

select extract(week from occured_at) as weeks,
	count(distinct user_id) as no_of_users
from events
group by weeks
order by weeks;

select *
from users;

select weeks, `year`, 
	sum(active_users) over (order by weeks, `year`
	rows between unbounded preceding and current row) as c_users
from (
	select 
		week (activated_at) as weeks,
		year(activated_at) as `year`,
		count(distinct user_id) as active_users 
    from users
    group by weeks, `year`
) as weekly_users;

select extract(week from occured_at) as weeks,
	count(distinct user_id) as users
from events
where event_type = 'signup_flow' and event_name = 'complete_signup'
group by weeks
order by weeks;

select device, extract(week from occured_at) as weeks,
	count(distinct user_id) as users
from events
where event_type = 'engagement'
group by device, weeks
order by weeks;

select *
from email_events;

select `action`, count(distinct user_id) as users,
	count(*) as total
from email_events
group by `action`
order by `action`;

select (sum(case when email_type = 'email_opened' then 1 else 0 end) /
	sum(case when email_type = 'email_sent' then 1 else 0 end)) * 100 as open_rate,
    (sum(case when email_type = 'email_clickthrough' then 1 else 0 end) /
    sum(case when email_type = 'email_sent' then 1 else 0 end)) * 100 as clickthrough_rate
from (
	select *, case when action in ('sent_weekly_digest', 'sent_reengagement_email') 
    then ('email_sent')
    when action in ('email_open') then ('email_opened')
    when action in ('email_clickthrough') then ('email_clickthrough')
    end as email_type
    from email_events
) as email_engage;
