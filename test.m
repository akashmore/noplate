A=imread(strcat('Gaadi/gadi1.jpg'));
org=A;
[h,w,f]=size(A);
A = rgb2gray(A);
level = graythresh(A);
A = im2bw(A,level*1.3);
A=edge(A,'roberts');
imshow(A);

horHist=zeros(w);

horHist=zeros(w);% The number of white pixels are added up each column and being low
for i=1:w
    tot=0;
    for j=1:h
        if (A(j,i)==1)
            tot=tot+1;
        end
    end
    horHist(i)=tot;
end

figure(2);
gem=max(horHist)/2.3;
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
                if(width>(w*0.1))
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


figure(3);
A=A(:,hstart:(hstart+hwidth),:);
imshow(A);

verHist=zeros(h);
for j=1:h
    tot=0;
    for i=2:hwidth
        if (A(j,i-1)==1 && A(j,i)==0) || (A(j,i-1)==0 && A(j,i)==1) 
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
figure(4);
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

figure(5);
A=org(vcoor(l,1):vcoor(l,1)+vcoor(l,2),hstart:(hstart+hwidth),:);
imshow(A);
figure(6);
f=ocr(A);

