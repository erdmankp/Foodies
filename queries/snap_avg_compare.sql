-- This query displays each county/city's name, SNAP amount in 2017, and the number
-- of states(excluding Virginia) with a higher average snap amount than 
-- that county. This could be  helpful for those who need to move to Virginia 
-- and rely on SNAP vouchers.
-- Author: Arman Saadat

DROP FUNCTION IF EXISTS snap_avg_compare(va_snap double precision, snapstates double precision);

CREATE FUNCTION snap_avg_compare(va_snap double precision, snapstates double precision)
RETURNS TABLE(va_county text, va_snap double precision, count bigint) AS $$


    SELECT DISTINCT va.county, va.snap2017,  count(s.st)
    FROM virginiacountiesinfo AS va
	JOIN states as s ON va.st != s.st 
    WHERE va.snap2017 < s.snapstates	
    GROUP BY va.county, va.snap2017
    ORDER BY count , va.snap2017

$$ LANGUAGE SQL STABLE STRICT;

ALTER FUNCTION snap_avg_compare(va_snap double precision, snapstates double precision) OWNER TO foodies;