close all;
clear all;
clc;

img=imread('44scribble2.jpg');%read the image
maskimg=imread('44mask2.jpg');%read the mask
[n m]=size(img);
m = m/3;
for i = 1:n %scan the mask
    for j = 1:m
        if maskimg(i,j,1) < 250 || maskimg(i,j,2) < 250 || maskimg(i,j,3) < 250
            mask(i,j) = 0;
        else
            mask(i,j) = 1;
        end;
    end;
end;
%mask = im2bw(mask); 
figure;
imshow(mask);
figure;
imshow(img);
img = double(img);
cnt = sum(sum(mask(:,:)))
for k=1:50  %ID until all repaired or 50 loops
    k
    for i=1:n
        for j=1:m
            tmpmask(i,j) = 0;
            if mask(i,j) == 0    %broken pixels
                img(i,j,1) = 0;
                img(i,j,2) = 0;
                img(i,j,3) = 0;
                count = 0;
                if(i+1 <= n && (j+1 <= m && mask(i+1,j+1) ~= 0))
                    img(i,j,1) = img(i,j,1) + img(i+1,j+1,1);
                    img(i,j,2) = img(i,j,2) + img(i+1,j+1,2);
                    img(i,j,3) = img(i,j,3) + img(i+1,j+1,3);
                    count = count + 1;
                end;
                if(i+1 <= n && (j-1 >= 1 && mask(i+1,j-1) ~= 0))
                    img(i,j,1) = img(i,j,1) + img(i+1,j-1,1);
                    img(i,j,2) = img(i,j,2) + img(i+1,j-1,2);
                    img(i,j,3) = img(i,j,3) + img(i+1,j-1,3);
                    count = count + 1;
                end
                if(i-1 >= 1 && (j+1 <= m && mask(i-1,j+1) ~= 0))
                    img(i,j,1) = img(i,j,1) + img(i-1,j+1,1);
                    img(i,j,2) = img(i,j,2) + img(i-1,j+1,2);
                    img(i,j,3) = img(i,j,3) + img(i-1,j+1,3);
                    count = count + 1;
                end;
                if(i-1 >= 1 && (j-1 >= m && mask(i-1,j-1) ~= 0))
                    img(i,j,1) = img(i,j,1) + img(i-1,j-1,1);
                    img(i,j,2) = img(i,j,2) + img(i-1,j-1,2);
                    img(i,j,3) = img(i,j,3) + img(i-1,j-1,3);
                    count = count + 1;
                end;
                if count ~= 0
                    tmpmask(i,j) = 1; %pixels which are repaired this loop will not be used by other pixels
                    img(i,j,1) = img(i,j,1) / count;
                    img(i,j,2) = img(i,j,2) / count;
                    img(i,j,3) = img(i,j,3) / count;
                    cnt = cnt + 1;
                end;
            end
        end
    end
    mask = mask | tmpmask; %pixels which are repaired this loop will be used the next loop
    if cnt >= m*n %if complete the repair
        break;
    end;
end
figure;
img = uint8(img);
imshow(img);
imwrite(img,'44result2.jpg');