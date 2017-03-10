close all;
clear all;
clc;

for j = 1:4
img = imread([int2str(j), int2str(j),'.jpg']);
%img = imread('33.jpg');
    for i = 1:9
        img2 = imread(['./径向基随机结果2/',int2str(j), int2str(j),'result', int2str(i) ,'0%.jpg']);
        %img2 = imread('./最近邻结果/33result2.jpg');
        E = double(img) - double(img2);
        MSE(j,i) = sum(E(:).*E(:))/ numel(img);
        PSNR(j,i) = 10*log10(255^2/MSE(j,i));
        SSIM(j,i) = (ssim(img(:,:,1),img2(:,:,1)) + ssim(img(:,:,2),img2(:,:,2)) + ssim(img(:,:,3),img2(:,:,3))) / 3;
    end;
end;


% for j = 1:4
% img = imread([int2str(j), int2str(j),'.jpg']);
% %img = imread('33.jpg');
%     for i = 1:2
%         img2 = imread(['./OtherResult/',int2str(j), int2str(j),'result', int2str(i) ,'.jpg']);
%         %img2 = imread('./最近邻结果/33result2.jpg');
%         E = double(img) - double(img2);
%         MSE(j,i) = sum(E(:).*E(:))/ numel(img);
%         PSNR(j,i) = 10*log10(255^2/MSE(j,i));
%         SSIM(j,i) = (ssim(img(:,:,1),img2(:,:,1)) + ssim(img(:,:,2),img2(:,:,2)) + ssim(img(:,:,3),img2(:,:,3))) / 3;
%     end;
% end;