#!/bin/bash
#!/bin/bash


DIRECTORY="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SCRIPT_DIR=$DIRECTORY/scripts
echo 'Current directory:'
echo $DIRECTORY
if [ ! -n "$2" ]; then
  echo 'error! Please, write config path' 
  exit
fi

  . $DIRECTORY/$2

case "$1" in
"create")
    echo $PORT
    createdb -h $HOST -p $PORT -U $USER $DATABASE -T $TEMPLATE_DB
    exit
;;
"drop")
    dropdb -h $HOST -p $PORT -U $USER $DATABASE
    exit
;;
"make")

     psql -f $SCRIPT_DIR/func_clear.sql -d  $DATABASE
     psql -f $SCRIPT_DIR/db_clear.sql -d  $DATABASE

     psql -f $SCRIPT_DIR/db_create.sql -d  $DATABASE
     psql -f $SCRIPT_DIR/func_create.sql -d  $DATABASE
     psql -f $SCRIPT_DIR/db_init.sql -d $DATABASE
    exit
;;
esac

echo 'commands: {create,drop,make}'
