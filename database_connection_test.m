%This script sets up the DB connection
%
%This script is intended to be used to connect to remote
%a MySQL/Maria database using a JDBC connection.
%
%Created by: Alex Heiden
%Created on: 2013-06-08

dbname = 'stockdata_t01';
username = 'alex';
password = '';
driver = 'com.mysql.jdbc.Driver';
dburl = ['jdbc:mysql://10.0.0.15:3306/' dbname];

javaclasspath('lib/mysql-connector-java-5.1.25/mysql-connector-java-5.1.25-bin.jar');

conn = database(dbname, username, password, driver, dburl);