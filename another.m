I=imread('Gaadi/gadi1.jpg'); %baza{k}
im1=rgb2gray(I);
im1=medfilt2(im1,[3 3]);
% BW = edge(im1,'canny');

Mhe = [-1 -1 -1; 0 0 0; 1 1 1]; % horizontal edge detection
Mve = [-1 0 1; -1 0 1; -1 0 1]; % vertical edge detection
hor = imfilter(im1,Mhe1);
ver = imfilter(im1,Mve1);
s_wynikowy = abs(ver) + abs(hor);
[RR CC]=size(s_wynikowy);
for i=1:RR
    for j=1:CC
        if (s_wynikowy(i,j)<100) % intensity of pixel which is below the thresold ... = 0
            s_wynikowy(i,j)=0;
        end
    end
end
BW=im2bw(s_wynikowy,0.15);
figure(3); imshow(s_wynikowy)
[rr cc]=size(BW);
% N=zeros(1,30);
% for i=1:rr
% for j=1:30:cc-30
% N=BW(i,j:j+30);
% suma=sum(N); % remove the horizontal edge line which sum of
% pixels is more then thresold
% if (suma > 20)
% BW(i,j:j+30)=0;
% end
% end
% end
% figure(3); imshow(BW);
N=zeros(50,1);
for i=1:cc
    for j=1:50:rr-50
        N=BW(j:j+50,i);
        suma=sum(N); % here is the same - vertical edges
        if (suma > 20)
        BW(j:j+50,i)=0;
        end
    end
end
figure(4); imshow(BW)
msk=[0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
     1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
     1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
     1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
     0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;];
 
 dil=imdilate(BW, msk);
 figure(5); imshow(dil);
 se=here is a matrix of ones [13 52]
 I_opened = imopen(dil,se);
figure(6), imshow(I_opened,[])

L = bwlabel(I_opened,8);
mx=max(max(L))
for n=1:mx
    [r,c] = find(L==n);
    rc = [r c];
    [sx sy]=size(rc);
    n1=zeros(rr,cc);
        for i=1:sx
            x1=rc(i,1);
            y1=rc(i,2);
            n1(x1,y1)=255;
        end % Storing the extracted image in an array
end

b_meas = regionprops(L, 'all');
numberOfBlobs = size(b_meas, 1);

figure(7); imagesc(I); axis square;
hold on;
boundaries = bwboundaries(I_opened);
for k = 1 : numberOfBlobs
thisBoundary = boundaries{k};
plot(thisBoundary(:,2), thisBoundary(:,1), 'g', 'LineWidth', 2);
end
hold off;

for k = 1 : numberOfBlobs % Loop through all blobs.
blobArea = b_meas(k).Area; % Get area.
blobPerimeter = b_meas(k).Perimeter; % Get perimeter.
blobCentroid = b_meas(k).Centroid; % Get centroid.
    fprintf(1,' %18f %18f\n',blobArea,blobPerimeter,blobCentroid);
end

all_b_Areas = [b_meas.Area];
allowableArea = (all_b_Areas > 1800 & all_b_Areas < 4500);
keeperIndexes = find(allowableArea);
keeperBlobsImage = ismember(L, keeperIndexes);
% Re-label with only the keeper blobs kept.
labeledDimeImage = bwlabel(keeperBlobsImage, 8); % Label each blob so we can make measurements of it
% Now we're done. We have a labeled image of blobs that meet our specified criteria.
figure(8);
imshow(labeledDimeImage, []);
axis square;

b_meas1 = regionprops(labeledDimeImage, 'all');
numberOfBlobs1 = size(b_meas1, 1);

figure(9); imagesc(I); axis square;
hold on;
boundaries = bwboundaries(keeperBlobsImage);
for k = 1 : numberOfBlobs1
thisBoundary1 = boundaries{k};
          plot(thisBoundary1(:,2), thisBoundary1(:,1), 'g', 'LineWidth', 2);
end
hold off; 