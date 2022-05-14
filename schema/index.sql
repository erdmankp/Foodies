--CREATE INDEX ON Proximity_To_Grocery_Store (grocery_proximity_2015, grocery_proximity_2015_LI);

CREATE INDEX ON food_assistance (food_banks_2018);

CREATE INDEX ON health_and_physical_activity (diabetes_rate_2013, rec_and_fitness_facilities_2016);

-- Think about which columns you will need to index (other than primary key columns,
-- which are indexed automatically). Write CREATE INDEX statements, and run them after creating constraints.