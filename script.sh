#!/bin/bash

let "nbInsert  = 0"

echo "DROP DATABASE ynov;" | mysql -proot
rm backup-*
#Create DB
echo "CREATE DATABASE ynov;" | mysql -proot
echo "USE ynov; CREATE TABLE T_1 ( id INT );" | mysql -proot

#Insert of the 100

insertFunction()
{
let "inse = nbInsert + 1"
let "nbInsert = nbInsert + 100"
for i in `seq $inse $nbInsert`;
do
	#echo "USE ynov;" | mysql -proot
	echo "USE ynov;  INSERT INTO T_1 (ID) VALUES ($i);" | mysql -proot

done

echo "$nbInsert"
}


#Backup
backup() 
{

mysqldump -u root -proot > /home/pierre/Bureau/backup-$nbInsert.sql
#echo "backup"

}

#Delete contain
deleteContain()
{

echo "USE ynov; TRUNCATE TABLE T_1;" | mysql -proot
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
