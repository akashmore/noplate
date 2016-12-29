clc
close all

colorImage = imread('sshz1.jpg');
I = rgb2gray(colorImage);
%imshow(I);

% Detect MSER regions.
[mserRegions,mserConnComp]=detectMSERFeatures(I);
%,'RegionAreaRange',[200 8000],'ThresholdDelta',4    paste on the above
%line after I


figure
imshow(I)
hold on
plot(mserRegions, 'showPixelList', true,'showEllipses',false)
title('MSER regions')
hold off