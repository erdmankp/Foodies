DROP TABLE VirginiaCountiesInfo CASCADE;
CREATE TABLE virginiacountiesinfo (
    FIPS integer NOT NULL,
    st text NOT NULL,
    county text NOT NULL,
    food2018 integer NOT NULL,
    rec2016 integer NOT NULL,
    SNAP2017 double precision,
    diabetes2013 double precision,
    gp2015 double precision,
    gp2015_LI double precision
    );
ALTER TABLE virginiacountiesinfo OWNER TO foodies;
COMMENT ON TABLE virginiacountiesinfo IS 'Stats regarding SNAP, fitness, and groceries in VA counties';

DROP TABLE IF EXISTS states;
CREATE TABLE states (
    st text NOT NULL,
    recStates integer,
    SNAPStates double precision,
    diabetes_States double precision,
    grocery_States double precision,
    grocery_States_LI double precision
    );
ALTER TABLE states OWNER TO foodies;
COMMENT ON TABLE states IS 'Stats regarding SNAP, fitness, and groceries in each state';


DROP TABLE IF EXISTS Access_and_Proximity_to_Grocery_Store;
CREATE TABLE Access_and_Proximity_to_Grocery_Store(
    FIPS integer NOT NULL,
    st text,
    County text,
    LACCESS_POP10 double precision,
    LACCESS_POP15 double precision,
    PCH_LACCESS_POP_10_15 double precision,
    PCT_LACCESS_POP10 double precision,
    PCT_LACCESS_POP15 double precision,
    LACCESS_LOWI10 double precision,
    LACCESS_LOWI15 double precision,
    PCH_LACCESS_LOWI_10_15 double precision,
    PCT_LACCESS_LOWI10 double precision,
    PCT_LACCESS_LOWI15 double precision,
    LACCESS_HHNV10 double precision,
    LACCESS_HHNV15 double precision,
    PCH_LACCESS_HHNV_10_15 double precision,
    PCT_LACCESS_HHNV10 double precision,
    PCT_LACCESS_HHNV15 double precision,
    LACCESS_SNAP15 double precision,
    PCT_LACCESS_SNAP15 double precision,
    LACCESS_CHILD10 double precision,
    LACCESS_CHILD15 double precision,
    LACCESS_CHILD_10_15 double precision,
    PCT_LACCESS_CHILD10 double precision,
    PCT_LACCESS_CHILD15 double precision,
    LACCESS_SENIORS10 double precision,
    LACCESS_SENIORS15 double precision,
    PCH_LACCESS_SENIORS_10_15 double precision,
    PCT_LACCESS_SENIORS10 double precision,
    PCT_LACCESS_SENIORS15 double precision,
    LACCESS_WHITE15 double precision,
    PCT_LACCESS_WHITE15 double precision,
    LACCESS_BLACK15 double precision,
    PCT_LACCESS_BLACK15 double precision,
    LACCESS_HISP15 double precision,
    PCT_LACCESS_HISP15 double precision,
    LACCESS_NHASIAN15 double precision,
    PCT_LACCESS_NHASIAN15 double precision,
    LACCESS_NHNA15 double precision,
    PCT_LACCESS_NHNA15 double precision,
    LACCESS_NHPI15 double precision,
    PCT_LACCESS_NHPI15 double precision,
    LACCESS_MULTIR15 double precision,
    PCT_LACCESS_MULTIR15 double precision
);
ALTER TABLE Access_and_Proximity_to_Grocery_Store OWNER TO foodies;


DROP TABLE IF EXISTS Food_Assistance;
CREATE TABLE Food_Assistance(
    FIPS integer,
    st text,
    County text,
    REDEMP_SNAPS12 double precision,
    REDEMP_SNAPS17 double precision,
    PCH_REDEMP_SNAPS_12_17 double precision,
    PCT_SNAP12 double precision,
    PCT_SNAP17 double precision,
    PCH_SNAP_12_17 double precision,
    PC_SNAPBEN12 double precision,
    PC_SNAPBEN17 double precision,
    PCH_PC_SNAPBEN_12_17 double precision,
    SNAP_PART_RATE11 double precision,
    SNAP_PART_RATE16 double precision,
    SNAP_OAPP09 double precision,
    SNAP_OAPP16 double precision,
    SNAP_CAP09 double precision,
    SNAP_CAP16 double precision,
    SNAP_BBCE09 double precision,
    SNAP_BBCE16 double precision,
    SNAP_REPORTSIMPLE09 double precision,
    SNAP_REPORTSIMPLE16 double precision,
    PCT_NSLP12 double precision,
    PCT_NSLP17 double precision,
    PCH_NSLP_12_17 double precision,
    PCT_FREE_LUNCH10 double precision,
    PCT_FREE_LUNCH15 double precision,
    PCT_REDUCED_LUNCH10 double precision,
    PCT_REDUCED_LUNCH15 double precision,
    PCT_SBP12 double precision,
    PCT_SBP17 double precision,
    PCH_SBP_12_17 double precision,
    PCT_SFSP12 double precision,
    PCT_SFSP17 double precision,
    PCH_SFSP_12_17 double precision,
    PC_WIC_REDEMP11 double precision,
    PC_WIC_REDEMP16 double precision,
    PCH_PC_WIC_REDEMP_11_16 double precision,
    REDEMP_WICS11 double precision,
    REDEMP_WICS16 double precision,
    PCH_REDEMP_WICS_11_16 double precision,
    PCT_WIC12 double precision,
    PCT_WIC17 double precision,
    PCH_WIC_12_17 double precision,
    PCT_WICINFANTCHILD14 double precision,
    PCT_WICINFANTCHILD16 double precision,
    PCH_WICINFANTCHILD_14_16 double precision,
    PCT_WICWOMEN14 double precision,
    PCT_WICWOMEN16 double precision,
    PCH_WICWOMEN_14_16 double precision,
    PCT_CACFP12 double precision,
    PCT_CACFP17 double precision,
    PCH_CACFP_12_17 double precision,
    FDPIR12 double precision,
    FDPIR15 double precision,
    PCH_FDPIR_12_15 double precision,
    FOOD_BANKS18 double precision
);
ALTER TABLE Food_Assistance OWNER TO foodies;


DROP TABLE IF EXISTS Health_and_Physical_Activity;
CREATE TABLE Health_and_Physical_Activity(
    FIPS integer,
    st text,
    County text,
    PCT_DIABETES_ADULTS08 double precision,
    PCT_DIABETES_ADULTS13 double precision,
    PCT_OBESE_ADULTS12 double precision,
    PCT_OBESE_ADULTS17 double precision,
    PCT_HSPA17 double precision,
    RECFAC11 double precision,
    RECFAC16 double precision,
    PCH_RECFAC_11_16 double precision,
    RECFACPTH11 double precision,
    RECFACPTH16 double precision,
    PCH_RECFACPTH_11_16 double precision
);
ALTER TABLE Health_and_Physical_Activity OWNER TO foodies;

DROP TABLE IF EXISTS logins;
CREATE TABLE logins(
    Username text,
    "Password" text
);
ALTER TABLE logins OWNER TO foodies;

DROP TABLE IF EXISTS SavedQueries;

ALTER TABLE logins OWNER TO foodies;
