dbname = 'noplate';
username = 'root';
password = '619619champ';
driver = 'com.mysql.jdbc.Driver';
dburl = ['jdbc:mysql://localhost:3306' dbname];
javaclasspath('C:\Users\champ\Downloads\mysql-connector-java-5.1.40/mysql-connector-java-5.1.40-bin.jar');
conn = database(dbname,username,password,driver,dburl);
if isconnection(conn) 
   disp(sprintf('Connection succsess', dbConn.Message))
end