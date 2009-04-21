-- This only clears the GURU schema
-- The views in the orangeleap schema will be drop before they
-- are recreated in orangeLeapReportViews.sql

drop schema IF EXISTS theguru;
create schema theguru;



