# STEPS TO CREATE DATABASE

1. Export a csv of "USDA FoodEnvironmentAtlas - Access and Proximity to Grocery Store" from:
    https://data.virginia.gov/Family-Health/USDA-FoodEnvironmentAtlas-Access-and-Proximity-to-/cip4-x9wd

2. Export a csv of "USDA FoodEnvironmentAtlas - Food Assistance" from:
    https://data.virginia.gov/Family-Health/USDA-FoodEnvironmentAtlas-Food-Assistance/pic2-5978

3. Export a csv of "USDA FoodEnvironmentAtlas - Health and Physical Activity" from:
    https://data.virginia.gov/Family-Health/USDA-FoodEnvironmentAtlas-Health-and-Physical-Acti/hbsb-w9zu

4. Export a csv of "USDA FoodEnvironmentAtlas - Store Availability" from: 
   https://data.virginia.gov/Economy/USDA-FoodEnvironmentAtlas-Store-Availability/3e4a-97e2

5. Export a csv of "USDA FoodEnvironmentAtlas - Socioeconomic Characteristics" from:
   https://data.virginia.gov/Economy/USDA-FoodEnvironmentAtlas-Socioeconomic-Characteri/ecfy-navr
   
6. Open each of the CSVs created in the first 3 steps in a spread sheet.

7. Filter each sheet so that the only state selected is VA

8. Create a new CSV called "VirginiaCountiesInfo" and manually add the correct columns from each of the downloaded CSVs

9. Run create.sql (psql < create.sql) to create/drop the tables in PGAdmin. Use the following environment variables:
SET PGHOST=localhost
SET PGDATABASE=foodies
SET PGUSER=saadatat
SET PGPASSWORD=112552071

9. Run copy.sh on data.cs.jmu.edu to copy data from all of the .csv files. 

10. Run populate_states.sql to populate the states table in PGAdmin.

11. Run alter.sql to add PRIMARY/FOREIGN key constraints.

12. Run index.sql to create indexes on specific tables.

13. Run stats.sql to count rows and analyze the tables.
