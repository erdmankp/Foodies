ALTER TABLE virginiacountiesinfo ADD PRIMARY KEY (FIPS);
ALTER TABLE states ADD PRIMARY KEY (st);
ALTER TABLE virginiacountiesinfo ADD FOREIGN KEY (st) REFERENCES states;



