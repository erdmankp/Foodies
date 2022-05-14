/*
Creates a view of correlation coefficients between diabetes2013(percent with diabetes in 2013) in Virginia 
and various other Virginia percentage variables to show the movement relationship.

1  = Strong positive relationship
-1 = Strong negative relationship
0  = No relationship

Kory Erdmann
*/

CREATE VIEW virginia_diabetes_corr_coef AS
    SELECT 
      round(corr(diabetes2013, pct_laccess_pop15)::numeric, 2) AS one_mile_grocery, 
      round(corr(diabetes2013, pct_laccess_lowi15)::numeric, 2) AS one_mile_grocery_low_income, 
      round(corr(diabetes2013, pct_laccess_hhnv15)::numeric, 2) AS one_mile_grocery_no_car, 
      round(corr(diabetes2013, pct_laccess_seniors15)::numeric, 2) AS one_mile_grocery_senior, 
      round(corr(diabetes2013, pct_laccess_white15)::numeric, 2) AS one_mile_grocery_white, 
      round(corr(diabetes2013, pct_laccess_black15)::numeric, 2) AS one_mile_grocery_black, 
      round(corr(diabetes2013, pct_laccess_hisp15)::numeric, 2) AS one_mile_grocery_hisp, 
      round(corr(diabetes2013, pct_laccess_nhasian15)::numeric, 2) AS one_mile_grocery_asian, 
      round(corr(diabetes2013, pct_laccess_snap15)::numeric, 2) AS receiving_snap
    FROM virginiacountiesinfo AS v
    JOIN access_and_proximity_to_grocery_store AS access ON v.fips = access.fips
    WHERE 
      diabetes2013 > 0 AND diabetes2013 IS NOT NULL
      AND pct_laccess_pop15 > 0 AND pct_laccess_pop15 IS NOT NULL
      AND pct_laccess_lowi15 > 0 AND pct_laccess_lowi15 IS NOT NULL
      AND pct_laccess_hhnv15 > 0 AND pct_laccess_hhnv15 IS NOT NULL
      AND pct_laccess_snap15 > 0 AND pct_laccess_snap15 IS NOT NULL
      AND pct_laccess_seniors15 > 0 AND pct_laccess_seniors15 IS NOT NULL
      AND pct_laccess_white15 > 0 AND pct_laccess_white15 IS NOT NULL
      AND pct_laccess_black15 > 0 AND pct_laccess_black15 IS NOT NULL
      AND pct_laccess_hisp15 > 0 AND pct_laccess_hisp15 IS NOT NULL
      AND pct_laccess_nhasian15 > 0 AND pct_laccess_nhasian15 IS NOT NULL