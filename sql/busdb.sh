#!/bin/bash

if [ ! -n "$2" ]; then
  echo 'error! Please, write config path' 
  exit
fi

  . $2

case "$1" in
"create")
    echo $PORT
    sudo -u postgres createdb -h $HOST -p $PORT -U $USER $DATABASE -T $TEMPLATE_DB
    exit
;;
"drop")
    sudo -u postgres dropdb -h $HOST -p $PORT -U $USER $DATABASE
    exit
;;
"make")

     sudo -u postgres psql -f $SCRIPT_DIR/func_clear.sql -d  $DATABASE
     sudo -u postgres psql -f $SCRIPT_DIR/db_clear.sql -d  $DATABASE

     sudo -u postgres psql -f $SCRIPT_DIR/db_create.sql -d  $DATABASE
     sudo -u postgres psql -f $SCRIPT_DIR/func_create.sql -d  $DATABASE
    exit
;;
esac

echo 'commands: {create,drop,make}'