#!/bin/sh
#
# NOTE: \copy imports from a local file
#       COPY imports from another database

# Credentials for all users
#export PGDATABASE=postgres
#export PGHOST=localhost
# Credentials for specific users

# Run create
echo "Running PSQL create file..."
#psql.exe -h localhost foodies < create.sql;
echo "---------------"

# Run copy
echo "Copying from VirginiaCountiesInfo.csv..."
psql -c "\copy VirginiaCountiesInfo FROM VirginiaCountiesInfo.csv WITH CSV HEADER" foodies

echo "Copying from access_and_proximity_grocery_stores.csv..."
psql -c "\copy Access_and_Proximity_to_Grocery_Store FROM USDA_FoodEnvironmentAtlas_-_Access_and_Proximity_to_Grocery_Store.csv WITH CSV HEADER" foodies

echo "Copying from food_assistance.csv..."
psql -c "\copy food_assistance FROM USDA_FoodEnvironmentAtlas_-_Food_Assistance.csv WITH CSV HEADER" foodies

echo "Copying from health_and_physical_activity.csv..."
psql -c "\copy health_and_physical_activity FROM USDA_FoodEnvironmentAtlas_-_Health_And_Physical_Activity.csv WITH CSV HEADER" foodies



#This sleep statement allows time to read error messages
sleep 100
