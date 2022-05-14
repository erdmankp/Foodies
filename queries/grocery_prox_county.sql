-- Function to search grocery proximity in a given county.
-- Includes columns for both general populus and low income.
-- This can be used to see the status of a given county's access to quality food.
-- Eric Anderson 3/9/22
DROP FUNCTION IF EXISTS grocery_prox_county(county text);

CREATE FUNCTION grocery_prox_county(county text) RETURNS TABLE(
    county text,
    gp2015 double precision,
    gp2015_LI double precision
) AS $$
SELECT
    county,
    gp2015,
    gp2015_LI
FROM
    virginiacountiesinfo AS va
WHERE
    va.county = $1
    OR va.county = 'Richmond'
	OR va.county = 'Harrisonburg' -- Placeholders TODO
GROUP BY
    va.county,
    va.gp2015,
    va.gp2015_LI
ORDER BY
    gp2015 DESC,
    gp2015_LI DESC $$ LANGUAGE SQL STABLE STRICT;

ALTER FUNCTION grocery_prox_county(county text)
OWNER TO foodies;