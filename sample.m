a=imread('cameraman.tif');
[rows,columns] =size(a);
c=zeros(rows/2,columns/2);
i=1;j=1;
for x =1:2:rows
    for y =1:2:columns 
        c(i,j) = a(x,y);
        j= j+1;
    end;
i=i+1;
j=1;
end
figure,imshow(a)

figure,imshow(c/255)        
        