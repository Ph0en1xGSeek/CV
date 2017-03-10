clear all;
close all;
clc;
arr = [0,0,0];
zero = [0,0,0;0,0,0;0,0,0];

for i=1:3
    if i == 1
        img=imread('D:\’’∆¨\image\11.jpg');
    elseif i == 2
        img=imread('D:\’’∆¨\image\22.jpg');
    else
        img=imread('D:\’’∆¨\image\33.jpg');
        
    end;
    img=rgb2gray(img);
    a(i)=sum(sum(img));
    img=double(img);

    w=fspecial('gaussian',[7,7]);
    imgG=imfilter(img,w,'replicate');

    img_canny=edge(img,'canny',0.15);
    figure;
    imshow(img_canny);
    title('Canny');
    img_canny=im2bw(img_canny);
    [row,col]=size(img_canny);
    %Calculate the isolate pixels
    %to distinguish the cons of the edge image
    for j=2:row-1
        for k = 2:col-1
            if img_canny(j, k) == 1
                if img_canny(j-1, k) == 0 && img_canny(j,k-1) == 0 && img_canny(j+1, k) == 0 && img_canny(j, k+1) == 0
                    zero(i,1)=zero(i,1)+1;
                end;
            end;
        end;
    end;

    img_prewitt=edge(img, 'prewitt', 9);
    figure;
    imshow(img_prewitt);
    title('Prewitt');
    img_prewitt=im2bw(img_prewitt);
    [row,col]=size(img_prewitt);
    for j=2:row-1
        for k = 2:col-1
            if img_canny(j, k) == 1
                if img_prewitt(j-1, k) == 0 && img_prewitt(j,k-1) == 0 && img_prewitt(j+1, k) == 0 && img_prewitt(j, k+1) == 0
                    zero(i,2)=zero(i,2)+1;
                end;
            end;
        end;
    end;

    img_sobel=edge(img,'sobel', 9);
    figure;
    imshow(img_sobel);
    title('Sobel');
    img_sobel=im2bw(img_sobel);
    [row,col]=size(img_sobel);
    for j=2:row-1
        for k = 2:col-1
            if img_sobel(j, k) == 1
                if img_sobel(j-1, k) == 0 && img_sobel(j,k-1) == 0 && img_sobel(j+1, k) == 0 && img_sobel(j, k+1) == 0
                    zero(i,3)=zero(i,3)+1;
                end;
            end;
        end;
    end;
end;


