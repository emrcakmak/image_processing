#Emre Çakmak 180316021

clear all;
close all;
clc;
pkg load image;

I=imread('hw3.tif');
imshow(I);#orijinal image 

I1=medfilt2(I);
figure, imshow(I1);# median


PQ = paddedsize(size(I1));
F=fft2(double(I1),PQ(1),PQ(2));
Fc=fftshift(F);
S1=log(1+abs(Fc)); 
figure, imshow(S1,[])

#Create Notch filters corresponding to extra peaks in the Fourier transform
H1 = notch('gaussian', PQ(1), PQ(2), 7, 32, 40);
H2 = notch('gaussian', PQ(1), PQ(2), 7, 969, 710);
figure, imshow(fftshift(H1.*H2));

#% Apply the notch filters to the Fourier spectrum of the image
FS_hw3 = F.*H1.*H2;

% convert the result to the spacial domain.
F_hw3=real(ifft2(FS_hw3)); 

% Crop the image to undo padding
F_hw3=F_hw3(1:size(I1,1), 1:size(I1,2));

figure, imshow(F_hw3,[])
FC=fftshift(FS_hw3);
Fcf=fftshift(FS_hw3);
S2=log(1+abs(Fcf));


figure, imshow(S2,[])
x = 0:255;
I3 = F_hw3.^0.33;
figure, imshow(I3,[])
