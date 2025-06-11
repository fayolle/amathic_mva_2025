clear;
clc;
close all;

% HDR image 
img = im2double(hdrread("memorial.hdr"));
is = imSlim(img);
figure, imshow(is), title("imSlim");

% Low light image 
img = im2double(imread("540.png"));
is = imSlim(img, 0.0);
figure, imshow(is), title("imSlim");
