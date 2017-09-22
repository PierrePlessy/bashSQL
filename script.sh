#!/bin/bash
#Create by Pierre Plessy

let "nbInsert  = 0"
back_path="/home/pierre/Bureau"
user="root"
password="root"


echo "DROP DATABASE ynov;" | mysql -p$password
rm $back_path/backup-*
#Create DB
echo "CREATE DATABASE ynov;" | mysql -p$password
echo "USE ynov; CREATE TABLE T_1 ( id INT );" | mysql -p$password

#Insert of the 100

insertFunction()
{
let "inse = nbInsert + 1"
let "nbInsert = nbInsert + 100"
for i in `seq $inse $nbInsert`;
do

	echo "USE ynov;  INSERT INTO T_1 (ID) VALUES ($i);" | mysql -p$password

done

echo "$nbInsert"
}


#Backup
backup() 
{

mysqldump -u $user -p$password > $back_path/backup-$nbInsert.sql
#echo "backup"

}

#Delete contain
deleteContain()
{

echo "USE ynov; TRUNCATE TABLE T_1;" | mysql -p$password
#echo "delete"

}

#While

while [ $nbInsert != '1000' ]
do

backup
deleteContain
let "nbInsert = $(insertFunction)"


done

echo "Finish"
