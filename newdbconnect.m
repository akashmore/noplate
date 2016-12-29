clc;
clear all;
javaaddpath([matlabroot,'/java/jarext/mysql-connector-java-5.0.8-bin.jar'])
database('image','root','619619champ','com.mysql.jdbc.Driver','jdbc:mysql://localhost:3306/image')
conn = database('image','root','619619champ','com.mysql.jdbc.Driver','jdbc:mysql://localhost:3306/image');
sqlquery ='select * from vehicle';
curs =exec(conn,sqlquery)
curs = fetch(curs)
v=curs.Data
disp(v{1,2})
b=imread(v{1,2});
imshow(b);
