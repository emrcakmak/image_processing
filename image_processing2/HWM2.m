#Emre Çakmak
#180316021
clear all;
close all;
clc;
pkg load image
I=imread('moon.tif');
N=imnoise(I, 'gaussian',0,0.01);
subplot(2,4,1),imshow(N),title('Noisy imange');
F1=fspecial("gaussian",10,10);
S=imfilter(N,F1);
subplot(2,4,2),imshow(S),title('Smoothed image');

H = [-1,-2,-1; 0,0,0; 1,2,1];
V = [-1,0,1; -2,0,2; -1,0,1];
E_S_H = filter2(H,S);
E_S_V = filter2(V,S);
E_S = uint8(sqrt(E_S_H.^2 + E_S_V.^2));

subplot(2,4,3),imshow(E_S),title('Smoothed Sobel');

E_N_H = filter2(H,N);
E_N_V = filter2(V,N);
E_N = uint8(sqrt(E_N_H.^2 + E_N_V.^2));

subplot(2,4,4),imshow(E_N),title('Noisy Sobel'); 


subplot(2,4,7),imhist(E_N,150),axis([0 255 0 4000]),title('Histogram Noise Sobel');
subplot(2,4,8),imhist(E_S,150),axis([0 255 0 8000]),title('Histogram Smoothed Sobel');
 
 
M_s = zeros(size(E_S));
t_s = 120;
t_s = uint8(t_s);

x = 0:255;
y = zeros(1,256);
ind = find(x>t_s);
y(ind) = 255;

ind = find(E_S>t_s);
M_s(ind) = 1;
subplot(2,4,6),imshow(M_s), title('Thresholded  Smoothed Sobel');
 
 
M_n = zeros(size(E_N));
t_n = 232;
t_n = uint8(t_n);

x = 0:255;
y = zeros(1,256);
ind = find(x>t_n);
y(ind) = 255;

ind = find(E_N>t_n);
M_n(ind) = 1;
subplot(2,4,5),imshow(M_n), title('Thresholded Noisy Sobel');