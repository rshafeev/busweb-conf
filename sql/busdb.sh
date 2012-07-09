#!/bin/bash

help(){
echo 'Help for busdb.sh.'
echo 'Recommendation: execute scripts from "postgres" user: (sudo -u postgres bash busdb.sh  <conf file> <command>) '
echo
echo 'Usage:' 
echo '	bash busdb.sh <conf file> <command>'
echo
echo 'Commands:'
echo '	create: 	  create database;'
echo '	drop: 		  drop database;'
echo '	structure: 	  update database structure(tables,schemas,functions and triggers) from scripts;'
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
    createdb -h $HOST -p $PORT -U $USER $DATABASE -T $TEMPLATE_DB
    exit
;;
"drop")
    dropdb -h $HOST -p $PORT -U $USER $DATABASE
    exit
;;
"structure")
     psql -f $SCRIPT_DIR/triggers_clear.sql -d  $DATABASE
     psql -f $SCRIPT_DIR/func_clear.sql -d  $DATABASE
     psql -f $SCRIPT_DIR/db_drop.sql -d  $DATABASE
     
     psql -f $SCRIPT_DIR/db_create.sql -d  $DATABASE
     psql -f $SCRIPT_DIR/func_create.sql -d  $DATABASE
     psql -f $SCRIPT_DIR/triggers_create.sql -d  $DATABASE
     exit
;;
"update_data")
     psql -f $DATA_DIR/data_clear.sql -d  $DATABASE
     psql -f $DATA_DIR/data_init.sql -d $DATABASE
     exit
;;
"update_funcs")
     psql -f $SCRIPT_DIR/func_clear.sql -d  $DATABASE
     psql -f $SCRIPT_DIR/func_create.sql -d  $DATABASE
     exit
;;
"update_triggers")
     psql -f $SCRIPT_DIR/triggers_clear.sql -d  $DATABASE
     psql -f $SCRIPT_DIR/triggers_create.sql -d  $DATABASE
     exit
;;    
"help")
    help
    exit
;;

esac

echo 'error: unknown command "${2}". Please, see help (command: help)'

