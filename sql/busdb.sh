#!/bin/bash

help(){
echo 'Help for busdb.sh.'
echo 'Recommendation: execute scripts from "postgres" user: (sudo -u postgres bash busdb.sh  <conf file> <command>) '
echo
echo 'Usage:' 
echo '	bash busdb.sh <conf file> <command>'
echo
echo 'Commands:'
echo '	create: 	      create database;'
echo '	drop: 		      drop database;'
echo '	update_structure: update database structure(tables,schemas,functions and triggers) from scripts;'
echo '	update_data:      clear and fill new data from  $DATA_DIR/data_init.sql;'
echo '	update_triggers:  update trigger functions and triggers from scripts;'
echo 'End.'
}

if [ ! -n "$1" ]&&[ ! -n "$2" ]; then
  help 
  exit
fi

if [ "$1"=="help" ]&&[ ! -n "$2" ]; then
    help
    exit
fi
CONFIG_FILE_NAME=$1
DIRECTORY="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"


 . $DIRECTORY/$CONFIG_FILE_NAME

case "$2" in
"create")
    echo $PORT
    sudo -u postgres createdb -h $HOST -p $PORT -U $USER $DATABASE -T $TEMPLATE_DB
    sudo -u postgres psql -U postgres -f $PGROUTING_DIR/routing_core.sql $DATABASE
    sudo -u postgres psql -U postgres -f $PGROUTING_DIR/routing_core_wrappers.sql $DATABASE
	# With TSP
	#psql -U postgres -f /usr/share/postlbs/routing_tsp.sql $DATABASE
	#psql -U postgres -f /usr/share/postlbs/routing_tsp_wrappers.sql $DATABASE

	# With Driving Distance
	#psql -U postgres -f /usr/share/postlbs/routing_dd.sql $DATABASE
	#psql -U postgres -f /usr/share/postlbs/routing_dd_wrappers.sql $DATABASE
    exit
;;
"close")
    sudo -u postgres psql -c "SELECT pg_terminate_backend(pg_stat_activity.pid) FROM pg_stat_activity WHERE pg_stat_activity.datname = '"$DATABASE"'" -d  $DATABASE;
	exit;
;;
"drop")
    sudo -u postgres psql -c "SELECT pg_terminate_backend(pg_stat_activity.pid) FROM pg_stat_activity WHERE pg_stat_activity.datname = '"$DATABASE"'" -d  $DATABASE;
	sudo -u postgres dropdb -h $HOST -p $PORT -U $USER $DATABASE
    exit
;;
"update_structure")
     sudo -u postgres psql -f $SCRIPT_DIR/db_drop.sql -d  $DATABASE
     sudo -u postgres psql -f $SCRIPT_DIR/db_create.sql -d  $DATABASE
     sudo -u postgres psql -f $SCRIPT_DIR/func_create.sql -d  $DATABASE
     sudo -u postgres psql -f $SCRIPT_DIR/triggers_create.sql -d  $DATABASE
     exit
;;
"update_data")
     sudo -u postgres psql -f $SCRIPT_DIR/data_clear.sql -d  $DATABASE
     sudo -u postgres psql -f $DATA_DIR/data_init.sql -d $DATABASE
     exit
;;
"update_funcs")
     sudo -u postgres psql -f $SCRIPT_DIR/func_clear.sql -d  $DATABASE
     sudo -u postgres psql -f $SCRIPT_DIR/func_create.sql -d  $DATABASE
     exit
;;
"drop_funcs")
     sudo -u postgres psql -f $SCRIPT_DIR/func_clear.sql -d  $DATABASE
     exit
;;
"update_triggers")
     sudo -u postgres psql -f $SCRIPT_DIR/triggers_clear.sql -d  $DATABASE
     sudo -u postgres psql -f $SCRIPT_DIR/triggers_create.sql -d  $DATABASE
     exit
;;
"dump_obj")
	echo 'saving IOBJ DUMP to file: ' $DUMP_DIR'/dump_obj.sql'
	chown -R postgres $DUMP_DIR
	chgrp -R postgres $DUMP_DIR
	chmod 750 -R $DUMP_DIR
	sudo -u postgres pg_dump -f $DUMP_DIR/dump_obj.sql -c -t bus.import_objects $DATABASE
	echo 'ok.'
	exit
;;
"dump")
	echo 'saving FULL DUMP to file: ' $DUMP_DIR'/dump.sql'
	chown -R postgres $DUMP_DIR
	chgrp -R postgres $DUMP_DIR
	chmod 750 -R $DUMP_DIR
	sudo -u postgres pg_dump -f $DUMP_DIR/dump.sql --schema 'bus' -c  $DATABASE
	echo 'ok.'
	exit
;;
"restore_obj")
	echo 'restore from file: ' $DUMP_DIR'/dump_obj.sql'
	chown -R postgres $DUMP_DIR
	chgrp -R postgres $DUMP_DIR
	chmod 750 -R $DUMP_DIR
	sudo -u postgres psql -f $DUMP_DIR/dump_obj.sql -d  $DATABASE
	echo 'ok.'
	exit
;;
"restore")
	echo 'restore from file: ' $DUMP_DIR'/dump.sql'
	chown -R postgres $DUMP_DIR
	chgrp -R postgres $DUMP_DIR
	chmod 750 -R $DUMP_DIR
	
	sudo -u postgres psql -f $DUMP_DIR/dump.sql -d  $DATABASE
	echo 'ok.'
	exit
;;    
"help")
    help
    exit
;;

esac

echo 'error: unknown command "${2}". Please, see help (command: help)'

