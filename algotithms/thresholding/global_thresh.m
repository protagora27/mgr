close all;
clc;
im_array = read_montage();
im = im_array{55};
im_bin = repmat(false,size(im));
im_uint8 = repmat(uint8(0),size(im));

figure('Name','Choose thresholds');
imshow(im);
thresh_arr = input('choose threshold array e.x. [120 150]:','s');
[im_label,index] = imquantize(im,str2num(thresh_arr));

for i = 1:numel(im)
    if(im_label(i)~=2)
         im_uint8(i) = 0;
         im_bin(i) = 0;
         
    else
        im_uint8(i)=255;
        im_bin(i) = 1;
    end
end
figure;
imshow(im_uint8);

% se = strel('disk',5);
% im_open = imdilate(im_label,se);

im_filled = imfill(im_bin,'holes');

ROI = figure('Name','filled holes');
imshow(im_filled);

marker = roipoly(im_filled);
% p2 = min(im2uint8(p),im1);
im_seg = imreconstruct(marker,im_filled);
figure;
subplot(2,2,1);
imshow(im);
subplot(2,2,2);
imshow(im + im2uint8(im_seg)/3);
subplot(2,2,3);
imshow(im_seg);
