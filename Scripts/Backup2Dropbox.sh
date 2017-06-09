#!/bin/bash
# Load Config file
script_path=`dirname $0`

config_file=$1
config_path=$script_path/../Config/$config_file

if [ -z ${config_file} ] || ! [ -f ${config_path} ]; then
  echo 'Config file does not exist!!!';
  echo 'Config File Setting = ' $config_path
  exit 0
fi

source ${config_path}

if [ -z ${website_folder} ] || [ -z ${working_folder} ]; then
  echo 'Path does not setting!!!'
  echo 'WebSite Folder = ' ${website_folder}
  echo 'Working Folder = ' ${working_folder}
  exit 0
elif ! [ -d ${working_folder} ] || ! [ -d ${website_folder} ]; then
  echo 'Folder does not exist!!!'
  echo 'Working Folder = '${working_folder}
  echo 'Website Folder = '${website_folder}
  exit 0
fi

if [ -z ${dropbox_folder} ]; then
  echo 'Dropbox Folder does not setting!!'
  exit 0
fi

# Dropbox 
dropbox_uploader=$script_path'/../Dropbox-Uploader/dropbox_uploader.sh'

stamp=`date +"%Y-%m-%d"`
lastweekstamp=`date --date='7 days ago' +"%Y-%m-%d"`
dbfile=$backup_name'_db_'$stamp.sql
webfile=$backup_name'_web_'$stamp.tar.bz2
last7daydbfile=$backup_name'_db_'$lastweekstamp.sql.bz2
last7daywebfile=$backup_name'_web_'$lastweekstamp.tar.bz2

echo "change to $working_folder"
cd $working_folder

echo "back up database"
mysqldump --add-drop-table -h$hostname -u$username -p$password $database > $dbfile

echo "compress database"
bzip2 $dbfile

echo "transfer database file to dropbox"
$dropbox_uploader upload $dbfile.bz2 $dropbox_folder

echo "back up web file"
tar -jcvf $webfile $website_folder --exclude=$exclude

echo "transfer web file to dropbox"
$dropbox_uploader upload $webfile $dropbox_folder

echo "clean backup files"
rm -rf $dbfile
rm -rf $dbfile'.bz2'
rm -rf $webfile

echo "clean last week backup"
$dropbox_uploader delete $dropbox_folder/$last7daydbfile
$dropbox_uploader delete $dropbox_folder/$last7daywebfile

echo "done!"

