-- This only clears the GURU schema
-- The views in the orangeleap schema will be drop before they
-- are recreated in orangeLeapReportViews.sql

drop schema IF EXISTS theguru;
create schema theguru;

DROP schema IF EXISTS `company1theguru`;
create schema company1theguru;
DROP schema IF EXISTS `company2theguru`;
create schema company2theguru;
DROP schema IF EXISTS `company3theguru`;
create schema company3theguru;
DROP schema IF EXISTS `demotheguru`;
create schema demotheguru;
DROP schema IF EXISTS `sandboxtheguru`;
create schema sandboxtheguru;
