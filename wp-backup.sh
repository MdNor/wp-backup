#!/bin/bash
NOW=$(date +"%Y-%m-%d-%H%M")
PARENT_DIRECTORY=/usr/share/nginx
SITE_NAME=$1
SITE_DIRECTORY=$PARENT_DIRECTORY/$1
WP_CONFIG_FILE=$SITE_DIRECTORY/wp-config.php
DB_NAME=`grep -Po "(?<=DB_NAME', ').+(?=')" $WP_CONFIG_FILE`
TEMP_DIRECTORY=/tmp/$SITE_NAME-$NOW
DUMP_PATH=$TEMP_DIRECTORY/database.sql

mkdir $TEMP_DIRECTORY
mysqldump --add-drop-table -u root -p $DB_NAME >$DUMP_PATH
cp -r -u -x $SITE_DIRECTORY $TEMP_DIRECTORY/www
tar -zcf $SITE_NAME-$NOW.tar.gz -C $TEMP_DIRECTORY .
rm -rf $TEMP_DIRECTORY 
