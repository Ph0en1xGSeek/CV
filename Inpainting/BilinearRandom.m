close all;
clear all;
clc;

img = imread('44.jpg');
[n,m]=size(img);
 m = m/3;
for amount = 1:9
    amount
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

%figure;
%imshow(img);
imwrite(img, ['44scribble',int2str(amount),'0%.jpg']);
cnt = sum(sum(mask(:,:)));
img = double(img);
for k=1:50  %ID until all repaired or 50 loops
    cnt
    for i=1:n
        for j=1:m
            tmpmask(i,j) = 1;
            if mask(i,j) == 1    %broken pixels
                img(i,j,1) = 0;
                img(i,j,2) = 0;
                img(i,j,3) = 0;
                count = 0;
                if(i+1 <= n && (j+1 <= m && mask(i+1,j+1) == 0))
                    img(i,j,1) = img(i,j,1) + img(i+1,j+1,1);
                    img(i,j,2) = img(i,j,2) + img(i+1,j+1,2);
                    img(i,j,3) = img(i,j,3) + img(i+1,j+1,3);
                    count = count + 1;
                end
                if(i+1 <= n && (j-1 >= 1 && mask(i+1,j-1) == 0))
                    img(i,j,1) = img(i,j,1) + img(i+1,j-1,1);
                    img(i,j,2) = img(i,j,2) + img(i+1,j-1,2);
                    img(i,j,3) = img(i,j,3) + img(i+1,j-1,3);
                    count = count + 1;
                end
                if(i-1 >= 1 && (j+1 <= m && mask(i-1,j+1) == 0))
                    img(i,j,1) = img(i,j,1) + img(i-1,j+1,1);
                    img(i,j,2) = img(i,j,2) + img(i-1,j+1,2);
                    img(i,j,3) = img(i,j,3) + img(i-1,j+1,3);
                    count = count + 1;
                end
                if(i-1 >= 1 && (j-1 >= m && mask(i-1,j-1) == 0))
                    img(i,j,1) = img(i,j,1) + img(i-1,j-1,1);
                    img(i,j,2) = img(i,j,2) + img(i-1,j-1,2);
                    img(i,j,3) = img(i,j,3) + img(i-1,j-1,3);
                    count = count + 1;
                end
                if count ~= 0
                    tmpmask(i,j) = 0;%pixels which are repaired this loop will not be used this loop
                    img(i,j,1) = img(i,j,1) / count;
                    img(i,j,2) = img(i,j,2) / count;
                    img(i,j,3) = img(i,j,3) / count;
                    cnt = cnt - 1;
                end;
            end
        end
    end
    mask = mask & tmpmask;%pixels which are repaired this loop will be used the next loop
    if cnt <= 0 %if complete the repair
        break;
    end;
end
img = uint8(img);
%figure;
%imshow(img);
imwrite(img, ['44result',int2str(amount),'0%.jpg']);
end;