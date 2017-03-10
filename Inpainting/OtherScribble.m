close all;
clc;
clear;
imgoriginal=imread('11scribble1.jpg');
mask = imread('11mask1.jpg');
% figure(1);
% imshow(imgoriginal); 
[width,height] = size(imgoriginal); 
img= double(imgoriginal); 
%--------------------------更新原图修复区域内每点值------------------------------------------
a=zeros(width,height);
I=cat(3,a,2*a,3*a);
J=cat(3,a,2*a,3*a);
n = 1; 
itertimes=100; 
tic;
while n <= itertimes
    n
    for i = 2:width-1
        for j = 2:height/3-1
           if (mask(i,j+1,1) < 250)||(mask(i,j-1,1) < 250)||(mask(i+1,j,1) < 250)||(mask(i-1,j,1) < 250)
              
                for k=1:3 
                grid_w(k) = (img(i,j,k)-img(i-1,j,k))^2+(1.0/16)*(img(i-1,j+1,k)+img(i,j+1,k)-img(i-1,j-1,k)-img(i,j-1,k))^2;
                grid_e(k) = (img(i,j,k)-img(i+1,j,k))^2+(1.0/16)*(img(i,j+1,k)+img(i+1,j+1,k)-img(i,j-1,k)-img(i+1,j-1,k))^2;
                grid_s(k) = (img(i,j,k)-img(i,j-1,k))^2+(1.0/16)*(img(i+1,j,k)+img(i+1,j-1,k)-img(i-1,j,k)-img(i-1,j-1,k))^2;
                grid_n(k) = (img(i,j,k)-img(i,j+1,k))^2+(1.0/16)*(img(i+1,j,k)+img(i+1,j+1,k)-img(i-1,j,k)-img(i-1,j+1,k))^2;
                I(i,j,k)=0.5*(img(i+1,j,k)-img(i-1,j,k))/sqrt(0.25*(img(i+1,j,k)-img(i-1,j,k))^2+0.25*(img(i,j+1,k)-img(i,j-1,k))^2+1);
                J(i,j,k)=0.5*(img(i,j+1,k)-img(i,j-1,k))/sqrt(0.25*(img(i+1,j,k)-img(i-1,j,k))^2+0.25*(img(i,j+1,k)-img(i,j-1,k))^2+1);
                Kw(k)=sqrt((I(i,j,k)-I(i-1,j,k)+(I(i-1,j+1,k)+I(i,j+1,k)-I(i-1,j-1,k)-I(i,j-1,k))/2)^2+(J(i,j,k)-J(i-1,j,k)+(J(i-1,j+1,k)+J(i,j+1,k)-J(i-1,j-1,k)-J(i,j-1,k))/2)^2);
                Ke(k)=sqrt((I(i+1,j,k)-I(i,j,k)+(I(i,j+1,k)+I(i+1,j+1,k)-I(i,j-1,k)-I(i+1,j-1,k))/2)^2+(J(i+1,j,k)-J(i,j,k)+(J(i,j+1,k)+J(i+1,j+1,k)-J(i,j-1,k)-J(i+1,j-1,k))/2)^2);
                Ks(k)=sqrt((I(i,j,k)-I(i,j-1,k)+(I(i+1,j,k)+I(i+1,j-1,k)-I(i-1,j,k)-I(i-1,j-1,k))/2)^2+(J(i,j,k)-J(i,j-1,k)+(J(i+1,j,k)+J(i+1,j-1,k)-J(i-1,j,k)-J(i-1,j-1,k))/2)^2);
                Kn(k)=sqrt((I(i,j+1,k)-I(i,j,k)+(I(i+1,j,k)+I(i+1,j+1,k)-I(i-1,j,k)-I(i-1,j+1,k))/2)^2+(J(i,j+1,k)-J(i,j,k)+(I(i+1,j,k)+J(i+1,j+1,k)-J(i-1,j,k)-J(i-1,j+1,k))/2)^2);
                w1(k) = Kw(k)/sqrt(1+grid_w(k))+1;
                w2(k) = Ke(k)/sqrt(1+grid_e(k))+1;
                w3(k) = Ks(k)/sqrt(1+grid_s(k))+1;
                w4(k) = Kn(k)/sqrt(1+grid_n(k))+1;
                img(i,j,k) =(w1(k)*img(i-1,j,k)+w2(k)*img(i+1,j,k)+w3(k)*img(i,j-1,k)+w4(k)*img(i,j+1,k))/(w1(k)+w2(k)+w3(k)+w4(k));
                end        
            end
        end
    end
    n = n+1; 
end 
%--------------------------输出修复后图像------------------------------------
img = uint8(floor(img)); 
toc;
figure(3);
imshow(img,[]);
imwrite(img,'./OtherResult/11result1.jpg');