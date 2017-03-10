close all;
clear all;
clc;

img=imread('44scribble2.jpg');%read image
maskimg=imread('44mask2.jpg');%reade mask
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
cnt = sum(sum(mask(:,:)));%count the brouken image
for k=1:50   %ID until all repaired or 50 loops
    k
    for i=1:n
        for j=1:m
            tmpmask(i,j) = 0;
            if mask(i,j) == 0    %if it is broken
                    if(j+1 <= m && mask(i,j+1) ~= 0)
                        img(i,j,1) = img(i,j+1,1);
                        img(i,j,2) = img(i,j+1,2);
                        img(i,j,3) = img(i,j+1,3);
                        tmpmask(i,j) = 1;% Repaired but do not used by other pixels during this loop
                        cnt = cnt + 1;
                    elseif(i+1 <= n && mask(i+1,j) ~= 0)
                        img(i,j,1) = img(i+1,j,1);
                        img(i,j,2) = img(i+1,j,2);
                        img(i,j,3) = img(i+1,j,3);
                        tmpmask(i,j) = 1;
                        cnt = cnt + 1;
                    elseif(i-1 >= 1 && mask(i-1,j) ~= 0)
                        img(i,j,1) = img(i-1,j,1);
                        img(i,j,2) = img(i-1,j,2);
                        img(i,j,3) = img(i-1,j,3);
                        tmpmask(i,j) = 1;
                        cnt = cnt + 1;
                    elseif(j-1 >= 1 && mask(i,j-1) ~= 0)
                        img(i,j,1) = img(i,j-1,1);
                        img(i,j,2) = img(i,j-1,2);
                        img(i,j,3) = img(i,j-1,3);
                        tmpmask(i,j) = 1;
                        cnt = cnt + 1;
                    elseif(i-1 >= 1 && j+1 <= m && mask(i-1,j+1) ~= 0)
                        img(i,j,1) = img(i-1,j+1,1);
                        img(i,j,2) = img(i-1,j+1,2);
                        img(i,j,3) = img(i-1,j+1,3);
                        tmpmask(i,j) = 1;
                        cnt = cnt + 1;
                    elseif(i+1 <= n && j+1 <= m && mask(i+1,j+1) ~= 0)
                        img(i,j,1) = img(i+1,j+1,1);
                        img(i,j,2) = img(i+1,j+1,2);
                        img(i,j,3) = img(i+1,j+1,3);
                        tmpmask(i,j) = 1;
                        cnt = cnt + 1;
                    elseif(i-1 >= 1 && j-1 >= m && mask(i-1,j-1) ~= 0)
                        img(i,j,1) = img(i-1,j-1,1);
                        img(i,j,2) = img(i-1,j-1,2);
                        img(i,j,3) = img(i-1,j-1,3);
                        tmpmask(i,j) = 1;
                        cnt = cnt + 1;
                    elseif(i+1 <= n && j-1 >= 1 && mask(i+1,j-1) ~= 0)
                        img(i,j,1) = img(i+1,j-1,1);
                        img(i,j,2) = img(i+1,j-1,2);
                        img(i,j,3) = img(i+1,j-1,3);
                        tmpmask(i,j) = 1;
                        cnt = cnt + 1;
                    end
            end
        end
    end
    mask = mask | tmpmask;% make pixels that are repaired this loop used by other pixels the nest loop
    if cnt >= m*n %if complete the repair
        break;
    end;
end
figure;
imshow(img);
imwrite(img,'44result2.jpg');