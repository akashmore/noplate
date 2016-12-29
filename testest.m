clc;
close all;
javaaddpath([matlabroot,'/java/jarext/mysql-connector-java-5.0.8-bin.jar'])
clc;
close all;
database('wcewle8w_image','wcewle8w_npr','619619champ','com.mysql.jdbc.Driver','jdbc:mysql://192.185.129.7:3306/wcewle8w_image');
conn = database('wcewle8w_image','wcewle8w_npr','619619champ','com.mysql.jdbc.Driver','jdbc:mysql://192.185.129.7:3306/wcewle8w_image');
sqlquery ='select * from vehicle';
curs=exec(conn,sqlquery);
curs=fetch(curs);
v=curs.Data;
imgnm=v{1,2};
imgpath='http://wcewlug.org/NPR/uploads/';
getimg=strcat(imgpath,imgnm);
f=imread(getimg);
f=imresize(f,[500 NaN]);
imshow(f);

figure();
g=rgb2gray(f);
imshow(g);

figure();
g=medfilt2(g,[3 3]); % Median filtering to remove noise.
imshow(g);

se=strel('disk',1);
figure();
gi=imdilate(g,se);
imshow(gi);
figure();
ge=imerode(g,se);
imshow(ge);

gdiff=imsubtract(gi,ge); % Morphological Gradient for edges enhancement.
gdiff=mat2gray(gdiff); % Converting the class to double.
figure();
imshow(gdiff);

gdiff=conv2(gdiff,[1 1;1 1]); % Convolution of the double image for brightening the edges.
gdiff=imadjust(gdiff,[0.5 0.7],[0 1],0.1); % Intensity scaling between the range 0 to 1.
B=logical(gdiff); % double to binary conversion. 
figure();
imshow(gdiff);


%figure();
er=imerode(B,strel('line',60,0));
out1=imsubtract(B,er);
%imshow(out1);


figure();
F=imfill(out1,'holes');
imshow(F);


figure();
H=bwmorph(F,'thin',1);
H=imerode(H,strel('line',4,90));
imshow(H);


figure();
final=bwareaopen(H,100);
imshow(final);
final=bwlabel(final); 
% Bounding boxes are acquired.
Iprops=regionprops(final,'BoundingBox','Image');
NR=cat(1,Iprops.BoundingBox);
% Calling of controlling function.
r=controlling(NR); % Function 'controlling' outputs the array of indices of boxes required for extraction of characters.
if ~isempty(r) 
    I={Iprops.Image}; 
    noPlate=[]; % Initializing the variable of number plate string.
    for v=1:length(r)
        N=I{1,r(v)}; % Extracting the binary image corresponding to the indices in 'r'.
        letter=readLetter(N);
        noPlate=[noPlate letter]; 
    end

     sqlquery1=['select * from info where no=''' noPlate ''''];
     curs1=exec(conn,sqlquery1);
     curs1=fetch(curs1);
     
     v = curs1.Data;
     a=strcat('Owner name is:',v{1,2},' and Vehicle type is:',v{1,3});
     disp(a);
     fid = fopen('noPlate.txt', 'wt'); 
     fprintf(fid,'The number is:%s\nThe vehicle information is:\n%s',noPlate,a);     
     fclose(fid);                      
     winopen('noPlate.txt')
     sqlquery2=['insert into result values(''' a ''')'];
     curs3=exec(conn,sqlquery2);
     
 else % in case of failure
    fprintf('Unable to extract the characters from the number plate.\n');
end
pause(15)
disp('succesfull');
%sqlquery ='delete from vehicle';
%curs =exec(conn,sqlquery);
%sqlquery ='delete from result';
%curs =exec(conn,sqlquery);

