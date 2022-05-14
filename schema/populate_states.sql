INSERT INTO states(st, recstates, snapstates, diabetes_states, grocery_states, grocery_states_li)
SELECT a.st, AVG(recfac16), AVG(redemp_snaps17), AVG(pct_diabetes_adults13), AVG(laccess_pop10), AVG(laccess_lowi15)
FROM access_and_proximity_to_grocery_store AS a
    JOIN food_assistance AS f ON a.st = f.st
    JOIN health_and_physical_activity AS h ON f.st = h.st
GROUP BY a.st