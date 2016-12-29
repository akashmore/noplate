close all

A=imread(strcat('newplates/DSC_0938.jpg'));
org=A;
B=A;
[h,w,f]=size(B);

figure();
imshow(B);
figure();
B=rgb2gray(org);
%level = graythresh(B);
%B = im2bw(B,level*1.3);
imshow(B);

figure();
J = imnoise(B,'salt & pepper',0.02);
Kaverage = filter2(fspecial('average',3),J)/255;
Kmedian = medfilt2(J);
%imshowpair(Kaverage,Kmedian,'montage')% Median filtering to remove noise.
B=Kmedian
imshow(B);

se=strel('disk',1);
%figure();
gi=imdilate(B,se);
%imshow(gi);
%figure();
ge=imerode(B,se);
%imshow(ge);

gdiff=imsubtract(gi,ge); % Morphological Gradient for edges enhancement.
gdiff=mat2gray(gdiff); % Converting the class to double.
%figure();
%imshow(gdiff);

gdiff=conv2(gdiff,[1 1;1 1]); % Convolution of the double image for brightening the edges.
gdiff=imadjust(gdiff,[0.5 0.7],[0 1],0.1); % Intensity scaling between the range 0 to 1.
B=logical(gdiff); % Conversion of the class from double to binary. 
figure();
imshow(gdiff);


figure();
er=imerode(B,strel('line',60,0));
out1=imsubtract(B,er);
imshow(out1);


horHist=zeros(w);

horHist=zeros(w);% The number of white pixels are added up each column and being low
for i=1:w
    tot=0;
    for j=1:h
        if (B(j,i)==1)
            tot=tot+1;
        end
    end
    horHist(i)=tot;
end

figure();
gem=max(horHist)/3;
plot(horHist);
hstart=0;
heinde=0;
width=0;
hcounter=0;
arc=0;
hcoor=zeros(1,2);

for i=1:w
    if horHist(i)>gem(1)
        if(hstart==0)
            hstart=i;
        end
        hcounter=0;
    else
        if hstart>0
            if hcounter>(w*0.07)
                heinde=i-hcounter;
                width=heinde-hstart;
                if(width>(w*0.5))
                    arc=arc+1;
                    hcoor(arc,1)=hstart;
                    hcoor(arc,2)=width;
                end
                hstart=0;
                hcounter=0;
                heinde=0;
                width=0;
            end
            hcounter=hcounter+1;
        end
    end
end
[ww,f]=size(hcoor);
hstart=0;
hwidth=0;

for i=1:ww
    if(hcoor(i,2)>hwidth)
        hwidth=hcoor(i,2);
        hstart=hcoor(i,1);
    end
end


figure();
B=B(:,hstart:(hstart+hwidth),:);
imshow(B);

verHist=zeros(h);
for j=1:h
    tot=0;
    for i=2:hwidth
        if (B(j,i-1)==1 && B(j,i)==0) || (B(j,i-1)==0 && B(j,i)==1) 
            tot=tot+1;
        end
    end
    verHist(j)=tot;
end

verh=zeros(1);
coun=1;

for i=1:h
    if(verHist(i)>0)
        verh(coun)=verHist(i);
        coun=coun+1;
    end
end

gem=mean(verh)
figure();
plot(verHist);
vstart=0;
veinde=0;
height=0;
vcounter=0;
arc=0;
vcoor=zeros(1,2);
h*0.07

for(i=1:h)
    if verHist(i)>gem(1)
        if(vstart==0)
            vstart=i;
        end
        vcounter=0;
    else
        if vstart>0
            if vcounter>(h*0.03)
                veinde=i-vcounter;
                height=veinde-vstart;
                if(height>(h*0.05))
                    arc=arc+1;
                    vcoor(arc,1)=vstart;
                    vcoor(arc,2)=height;
                end
                vstart=0;
                vcounter=0;
                veinde=0;
                height=0;
            end
            vcounter=vcounter+1;
        end
    end
end
[l,f]=size(vcoor);

figure();
B=org(vcoor(l,1):vcoor(l,1)+vcoor(l,2),hstart:(hstart+hwidth),:);
imshow(B);