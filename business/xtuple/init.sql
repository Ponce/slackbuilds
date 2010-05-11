--
-- This script creates the group openmfg and the user mfgadmin
--

--
-- Create the openmfg group
--
CREATE GROUP openmfg;

--
-- Create the mfgadmin user with createdb and createuser
-- permissions.  Place the user in the openmfg group and
-- set the password to the default of mfgadmin.
--
CREATE USER mfgadmin WITH PASSWORD 'mfgadmin'
                          CREATEDB CREATEUSER
                          IN GROUP openmfg;
CREATE USER admin WITH PASSWORD 'admin'
                       CREATEDB CREATEUSER
                       IN GROUP openmfg;

