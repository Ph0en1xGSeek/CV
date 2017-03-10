close all;
clear all;
clc;

img=imread('44scribble1.jpg');
maskimg=imread('44mask1.jpg');
figure;
imshow(img);
img = double(img);
[n,m]=size(img);
m = m/3;
cnt = 0;

for i = 1:n
    for j = 1:m
        if maskimg(i,j,1) < 250 || maskimg(i,j,2) < 250 || maskimg(i,j,3) < 250
            mask(i,j) = 0;%Scan the mask
        else
            mask(i,j) = 1;
        end;
    end;
end;
figure;
imshow(mask);
cnt = sum(sum(mask(:,:)));
mk = 121;

for k=1:50  %ID until complete the repair
    cnt
    for i=1:n
        for j=1:m
            if mask(i,j) ~= 1
                ma = zeros(mk,1);
                A = zeros(mk,mk);
                B1 = zeros(mk,1);
                B2 = zeros(mk,1);
                B3 = zeros(mk,1);
                ms = 0;
                for a=i-5:i+5
                    for b=j-5:j+5
                        if(a <= n && a >= 1 && b <= m && b >= 1)
                            if(mask(a,b) == 1)
                                ms = ms + 1;
                                B1(ms,1) = img(a,b,1);
                                B2(ms,1) = img(a,b,2);
                                B3(ms,1) = img(a,b,3);
                                ma(ms,1) = (a-i)*(a-i) + (b-j)*(b-j);
                                mx = 0;
                                for a1=i-5:i+5
                                    for b1=j-5:j+5
                                        if(a1 <= n && a1 >= 1 && b1 <= m && b1 >= 1)
                                            if(mask(a1,b1) == 1)
                                                mx = mx + 1;
                                                A(ms,mx) = sqrt(1 + ((a-a1)*(a-a1) + (b-b1)*(b-b1))/9);
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                if(ms > 1)
                    A = A(1:ms,1:ms);
                    B1 = B1(1:ms,1);
                    B2 = B2(1:ms,1);
                    B3 = B3(1:ms,1);
                    ma = ma(1:ms,1);
                    X1 = A\B1;
                    X2 = A\B2;
                    X3 = A\B3;  % solve the linear system
                    img(i,j,1) = 0;
                    img(i,j,2) = 0;
                    img(i,j,3) = 0;
                    for a=1:ms
                        img(i,j,1) = img(i,j,1) + X1(a,1) * sqrt(1 + (ma(a,1))/9);
                        img(i,j,2) = img(i,j,2) + X2(a,1) * sqrt(1 + (ma(a,1))/9);
                        img(i,j,3) = img(i,j,3) + X3(a,1) * sqrt(1 + (ma(a,1))/9);
                    end
                    mask(i,j) = 1;
                    cnt = cnt - 1;
                end;
            end
        end
    end
    if(cnt == 0)
        break;
    end

end

img = uint8(img);
figure;
imshow(img);
imwrite(img, '44result1.jpg')