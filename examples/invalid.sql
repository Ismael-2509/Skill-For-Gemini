-- (Violación CRITICAL)
UPDATE tasks SET status = 'DONE';

-- Violación MEDIUM
SELECT * FROM users_log;

-- Violación CRITICAL
SELECT id, title FROM tasks WHERE title = '' + @userInput + '';

-- Violación HIGH - Hard Delete
DELETE FROM employees WHERE department = 'HR';