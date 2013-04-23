# ------------------------------------------------------------------------------
# Setup template containing PostGIS and/or pgRouting
# ------------------------------------------------------------------------------
#
# To create a GIS database as non-superuser run: 
#
# 	"createdb -h hostname -W -T template_postgis mydb
#
# Source: http://geospatial.nomad-labs.com/2006/12/24/postgis-template-database/
#
# Note: requires "libpq-dev" package

if [ -e `pg_config --sharedir` ]
then
	echo "PostGIS installed in" `pg_config --sharedir`
	POSTGIS_SQL_PATH=`pg_config --sharedir`/contrib
else
	POSTGIS_SQL_PATH=/usr/share/postgresql/contrib
fi
echo "PostGIS path set as $POSTGIS_SQL_PATH"

ROUTING_SQL_PATH=/usr/share/postlbs

# Create "template_routing"
# -------------------------
if  sudo -u postgres psql --list | grep -q template_routing ;
then
	echo "pgRouting template already exists!"
else
	echo "Create pgRouting template ..."
	sudo -u postgres createdb -E UTF8 template_routing
  
  sudo -u postgres psql --quiet -d template_routing -c "create extension postgis;"
  sudo -u postgres psql --quiet -d template_routing -c "create extension postgis_topology;"

	sudo -u postgres psql --quiet -d template_routing -f $ROUTING_SQL_PATH/routing_core.sql
	sudo -u postgres psql --quiet -d template_routing -f $ROUTING_SQL_PATH/routing_core_wrappers.sql
	sudo -u postgres psql --quiet -d template_routing -f $ROUTING_SQL_PATH/routing_topology.sql
	sudo -u postgres psql --quiet -d template_routing -f $ROUTING_SQL_PATH/matching.sql

  sudo -u postgres psql --quiet -d template_routing -c "GRANT ALL ON geometry_columns TO PUBLIC;"
  sudo -u postgres psql --quiet -d template_routing -c "GRANT ALL ON geography_columns TO PUBLIC;"
  sudo -u postgres psql --quiet -d template_routing -c "GRANT ALL ON raster_columns TO PUBLIC;"
  sudo -u postgres psql --quiet -d template_routing -c "GRANT ALL ON spatial_ref_sys TO PUBLIC;"

	sudo -u postgres psql --quiet -d template_routing -c "VACUUM FULL;"
	sudo -u postgres psql --quiet -d template_routing -c "VACUUM FREEZE;"

	sudo -u postgres psql --quiet -d postgres -c "UPDATE pg_database SET datistemplate='true' WHERE datname='template_routing';"
	sudo -u postgres psql --quiet -d postgres -c "UPDATE pg_database SET datallowconn='false' WHERE datname='template_routing';"
	echo "... template_routing created."
fi
