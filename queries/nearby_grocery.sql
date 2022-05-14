--This shows the the average number of people who live greater than one mile from a grocery store
--in Virginia and all the states that border Virginia
DROP FUNCTION IF EXISTS nearby_grocery();

CREATE FUNCTION nearby_grocery()
RETURNS TABLE(st text, grocery_states double precision) AS $$


SELECT st AS state, grocery_states AS "# people > one mile from grocery store"
FROM states
WHERE st = 'VA'
	OR st = 'WV'
	OR st = 'MD'
	OR st = 'NC'
	OR st = 'KY'
	OR st = 'TN'
	OR st = 'DC'
ORDER BY grocery_states DESC

$$ LANGUAGE SQL STABLE STRICT;

ALTER FUNCTION nearby_grocery() OWNER TO foodies;