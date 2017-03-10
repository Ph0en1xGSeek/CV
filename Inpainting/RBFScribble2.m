close all;
clear all;
clc;

img=imread('44scribble2.jpg');
maskimg=imread('44mask2.jpg');
figure;
imshow(img);
%img = double(img);
[n,m]=size(img);
m = m/3;

for i = 1:n
    for j = 1:m
        if maskimg(i,j,1) < 250 || maskimg(i,j,2) < 250 || maskimg(i,j,3) < 250
            mask(i,j) = 0;% Scan the mask
        else
            mask(i,j) = 1;
        end;
    end;
end;
figure;
imshow(mask);
for i=1:50:n
    i
    for j=1:50:m
        left=i;
        right=min(i+49,n);
        up = j;
        bottom = min(j+49, m); % the boundary of the blocks
        mk = (bottom-up+1) * (right-left+1);
        ma = zeros(mk,1);
        A = zeros(mk,mk);
        B1 = zeros(mk,1);
        B2 = zeros(mk,1);
        B3 = zeros(mk,1);
        ms = 0;
        for a=left:right
            for b=up:bottom
                if mask(a,b) == 1
                    ms = ms + 1;
                    B1(ms,1) = img(a,b,1);
                    B2(ms,1) = img(a,b,2);
                    B3(ms,1) = img(a,b,3); % build the linear system
                    mx = 0;
                    for aa=left:right
                        for bb=up:bottom
                            if mask(aa, bb) == 1
                                mx = mx + 1;
                                A(ms,mx) = 1/sqrt(1 + ((a-aa)*(a-aa) + (b-bb)*(b-bb))/9); % RBF
                            end;
                        end;
                    end;
  
                end;
            end;
        end;
        if ms <= 1 || ms == mk
            continue;
        end;
        A = A(1:ms,1:ms);
        B1 = B1(1:ms,1);
        B2 = B2(1:ms,1);
        B3 = B3(1:ms,1);
        X1 = zeros(ms,1);
        X2 = zeros(ms,1);
        X3 = zeros(ms,1);
        X1 = A\B1;
        X2 = A\B2;
        X3 = A\B3; % Solve the linear system
        for aa=left:right
            for bb=up:bottom
                if mask(aa, bb) == 0
                    cnt = 0;
                    for ii=left:right
                        for jj=up:bottom
                            if mask(ii,jj) == 1
                                cnt = cnt+1;
                                ma(cnt,1) = (aa-ii)*(aa-ii) + (bb-jj)*(bb-jj);
                            end;
                        end;
                    end;
                    ma = ma(1:ms,1);
                    img1 = 0.0;
                    img2 = 0.0;
                    img3 = 0.0;
                    for a=1:ms
                        img1 = img1 + X1(a,1) * 1/sqrt(1 + (ma(a,1))/9);
                        img2 = img2 + X2(a,1) * 1/sqrt(1 + (ma(a,1))/9);
                        img3 = img3 + X3(a,1) * 1/sqrt(1 + (ma(a,1))/9);
                    end;
                    img(aa,bb,1) = round(img1);
                    img(aa,bb,2) = round(img2);
                    img(aa,bb,3) = round(img3);
                end;
            end;
        end;
        
    end;
end;
%img = uint8(img);
figure;
imshow(img);
imwrite(img, '44result2.jpg')