-- Challenge Bonus queries.
-- 1. (2.5 pts)
-- Retrieve all the number of backer_counts in descending order for each cf_id for the "live" campaigns. 
select backers_count,
cf_id,
outcome
from campaign 
where outcome = 'live'
order by backers_count desc;


-- 2. (2.5 pts)
-- Using the "backers" table confirm the results in the first query.
select distinct campaign.backers_count,
backers.cf_id,
campaign.outcome
from campaign
left join backers
on campaign.cf_id = backers.cf_id
where campaign.outcome = 'live'
order by campaign.backers_count desc;


-- 3. (5 pts)
-- Create a table that has the first and last name, and email address of each contact.
-- and the amount left to reach the goal for all "live" projects in descending order. 
drop table if exists email_contacts_remaining_goal_amount;

select contacts.first_name,
contacts.last_name,
contacts.email,
(campaign.goal - campaign.pledged) as remaining_goal_amount
into email_contacts_remaining_goal_amount
from contacts
join campaign
on campaign.contact_id = contacts.contact_id
where campaign.outcome = 'live'
order by remaining_goal_amount desc;

-- Check the table
select*from email_contacts_remaining_goal_amount;

-- 4. (5 pts)
-- Create a table, "email_backers_remaining_goal_amount" that contains the email address of each backer in descending order, 
-- and has the first and last name of each backer, the cf_id, company name, description, 
-- end date of the campaign, and the remaining amount of the campaign goal as "Left of Goal". 
drop table if exists email_backers_remaining_goal_amount;

select backers.email,
backers.first_name,
backers.last_name,
backers.cf_id,
campaign.company_name, 
campaign.description,
campaign.end_date,
campaign.goal - campaign.pledged as left_of_goal
into email_backers_remaining_goal_amount
from backers
join campaign
on campaign.cf_id = backers.cf_id
group by backers.email,
backers.first_name,
backers.last_name,
backers.cf_id,
campaign.company_name, 
campaign.description,
campaign.end_date,
left_of_goal
order by backers.last_name asc;

-- Check the table
select*from email_backers_remaining_goal_amount;

