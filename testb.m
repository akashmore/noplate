A=imread(strcat('images/auto7.jpg'));
org=A;
[h,w,f]=size(A);
A = rgb2gray(A);
level = graythresh(A);
A = im2bw(A,level*1.3);
BW = edge(A,'sobel',0.1) ;
figure(7);
imshow(BW);