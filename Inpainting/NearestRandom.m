close all;
clear all;
clc;

img = imread('44.jpg');%read the image
[n,m]=size(img);
 m = m/3;
 for amount = 1:9 % 9 levels of pixels deleted randomly
 mask = zeros(n,m);

for i=1:n
    for j = 1:m
        x = randi(10);
        if x <= amount
            mask(i,j) = 1;
            img(i,j,1)=255;
            img(i,j,2)=255;
            img(i,j,3)=255;
        end;
    end;
end;

figure;
imshow(img);
imwrite(img, ['44scribble',int2str(amount),'0%.jpg']);
cnt = sum(sum(mask(:,:)))
for k=1:50   %ID until all repaired or 50 loops
    cnt
    for i=1:n
        for j=1:m
            tmpmask(i,j) = 1;
            if mask(i,j) == 1    %deleted pixels
                    if(j+1 <= m && mask(i,j+1) == 0)
                        img(i,j,1) = img(i,j+1,1);
                        img(i,j,2) = img(i,j+1,2);
                        img(i,j,3) = img(i,j+1,3);
                        tmpmask(i,j) = 0;%repaired but not used during this loop
                        cnt = cnt - 1;
                    elseif(i+1 <= n && mask(i+1,j) == 0)
                        img(i,j,1) = img(i+1,j,1);
                        img(i,j,2) = img(i+1,j,2);
                        img(i,j,3) = img(i+1,j,3);
                        tmpmask(i,j) = 0;
                        cnt = cnt - 1;
                    elseif(i-1 >= 1 && mask(i-1,j) == 0)
                        img(i,j,1) = img(i-1,j,1);
                        img(i,j,2) = img(i-1,j,2);
                        img(i,j,3) = img(i-1,j,3);
                        tmpmask(i,j) = 0;
                        cnt = cnt - 1;
                    elseif(j-1 >= 1 && mask(i,j-1) == 0)
                        img(i,j,1) = img(i,j-1,1);
                        img(i,j,2) = img(i,j-1,2);
                        img(i,j,3) = img(i,j-1,3);
                        tmpmask(i,j) = 0;
                        cnt = cnt - 1;
                    elseif(i-1 >= 1 && j+1 <= m && mask(i-1,j+1) == 0)
                        img(i,j,1) = img(i-1,j+1,1);
                        img(i,j,2) = img(i-1,j+1,2);
                        img(i,j,3) = img(i-1,j+1,3);
                        tmpmask(i,j) = 0;
                        cnt = cnt - 1;
                    elseif(i+1 <= n && j+1 <= m && mask(i+1,j+1) == 0)
                        img(i,j,1) = img(i+1,j+1,1);
                        img(i,j,2) = img(i+1,j+1,2);
                        img(i,j,3) = img(i+1,j+1,3);
                        tmpmask(i,j) = 0;
                        cnt = cnt - 1;
                    elseif(i-1 >= 1 && j-1 >= m && mask(i-1,j-1) == 0)
                        img(i,j,1) = img(i-1,j-1,1);
                        img(i,j,2) = img(i-1,j-1,2);
                        img(i,j,3) = img(i-1,j-1,3);
                        tmpmask(i,j) = 0;
                        cnt = cnt - 1;
                    elseif(i+1 <= n && j-1 >= 1 && mask(i+1,j-1) == 0)
                        img(i,j,1) = img(i+1,j-1,1);
                        img(i,j,2) = img(i+1,j-1,2);
                        img(i,j,3) = img(i+1,j-1,3);
                        tmpmask(i,j) = 0;
                        cnt = cnt - 1;
                    end
            end
        end
    end
    mask = mask & tmpmask; %make the repaired pixels used the next loop
    if cnt <= 0 %Complete the repair
        break;
    end;
end
%figure;
%imshow(img);
imwrite(img, ['44result',int2str(amount),'0%.jpg']);
 end