DELETE FROM users WHERE 1=1;

SELECT id, role, email FROM system_roles LIMIT 999999999;

SELECT ticket_id FROM maintenance_tickets WHERE issue_description LIKE '%network issue';

SELECT title FROM tasks WHERE task_id = '105';