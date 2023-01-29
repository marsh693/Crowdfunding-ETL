-- Retrieve all the number of backer_counts in descending order for each 
--`cf_id` for the "live" campaigns.
SELECT cmpg.backers_count, cmpg.cf_id, cmpg.outcome
FROM campaign as cmpg
WHERE (cmpg.outcome = 'live')
ORDER BY  cmpg.backers_count DESC;

-- Using the "backers" table confirm the results in the first query.
SELECT COUNT (bck.cf_id), bck.cf_id
FROM backers as bck
GROUP BY bck.cf_id
ORDER BY COUNT(bck.cf_id) DESC;

-- Create a table that has the first and last name, and email address of each contact.
-- and the amount left to reach the goal for all "live" projects in descending order.
SELECT con.first_name, con.last_name, con.email, (cmpg.goal - cmpg.pledged) as remaining_goal_amount
INTO email_contacts_reamining_goal_amount
FROM campaign as cmpg
INNER JOIN contacts as con
ON (cmpg.contact_id = con.contact_id)
WHERE (cmpg.outcome = 'live')
ORDER BY remaining_goal_amount DESC;

-- Check the table
SELECT * FROM email_contacts_reamining_goal_amount;

-- Create a table, "email_backers_remaining_goal_amount" that contains the email address of each backer in descending order, 
-- and has the first and last name of each backer, the cf_id, company name, description, 
-- end date of the campaign, and the remaining amount of the campaign goal as "Left of Goal". 
SELECT bck.email, bck.first_name, bck.last_name, cmpg.cf_id, cmpg.company_name, cmpg.description, (cmpg.goal - cmpg.pledged) as left_of_goal
INTO email_backers_remaining_goal_amount
FROM campaign as cmpg
INNER JOIN backers as bck
ON (cmpg.cf_id = bck.cf_id)
WHERE (cmpg.outcome = 'live')
ORDER BY bck.last_name, bck.email;

-- Check the table
SELECT * FROM email_backers_remaining_goal_amount;

