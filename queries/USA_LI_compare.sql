--This shows the average number of low income people who live greater then one mile from a grocery store
--in a state vs in the average of the United States.

DROP FUNCTION IF EXISTS USA_LI_compare(sta text);

CREATE FUNCTION USA_LI_compare(sta text)
RETURNS TABLE(sta text, grocery_States_LI double precision) AS $$

SELECT 'state', grocery_states_LI AS "# low income people > one mile from grocery store"
FROM states
WHERE st = sta
UNION
SELECT 'USA', AVG(grocery_states_LI)
FROM states


$$ LANGUAGE SQL STABLE STRICT;

ALTER FUNCTION USA_LI_compare(sta text) OWNER TO foodies;