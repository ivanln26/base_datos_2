# Download sakila db
wget http://downloads.mysql.com/docs/sakila-db.tar.gz
tar -zxvf sakila-db.tar.gz

docker exec -i mysql_container mysql -uroot -ppassword < sakila-db/sakila-schema.sql
docker exec -i mysql_container mysql -uroot -ppassword < sakila-db/sakila-data.sql

docker exec -i mysql_container mysql -uroot -ppassword < class_02.sql
