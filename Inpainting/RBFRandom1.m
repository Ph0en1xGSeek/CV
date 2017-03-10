close all;
clear all;
clc;
for num=1:1
%     figure;
%     imshow(img);
    for amount=1:9 %9 levels of pixels delete
        img=imread([int2str(num),int2str(num),'.jpg']);

        [n,m]=size(img);
        m = m/3;
        mask = zeros(n,m);
        for i=1:n
            for j = 1:m %delete the pixels randomly
                x = randi(10);
                if x <= amount
                    mask(i,j) = 1;
                    img(i,j,1)=255;
                    img(i,j,2)=255;
                    img(i,j,3)=255;
                end;
            end;
        end;

%         figure;
%         imshow(mask);
        imwrite(img, ['./径向基随机结果1/',int2str(num),int2str(num),'scribble',int2str(amount),'0%.jpg']);
%        img = double(img); % use uint8 wiil speed up the algorithm
        for i=1:50:n
            i
            for j=1:50:m
                left=i;
                right=min(i+49,n);
                up = j;
                bottom = min(j+49, m);% the boundary of blocks
                mk = (bottom-up+1) * (right-left+1);
                ma = zeros(mk,1);
                A = zeros(mk,mk);
                B1 = zeros(mk,1);
                B2 = zeros(mk,1);
                B3 = zeros(mk,1);
                ms = 0;
                for a=left:right %find the good pixels to build the linear system
                    for b=up:bottom
                        if mask(a,b) == 0
                            ms = ms + 1;
                            B1(ms,1) = img(a,b,1);
                            B2(ms,1) = img(a,b,2);
                            B3(ms,1) = img(a,b,3);
                            mx = 0;
                            for aa=left:right
                                for bb=up:bottom
                                    if mask(aa, bb) == 0
                                        mx = mx + 1;
                                        A(ms,mx) = sqrt(1 + ((a-aa)*(a-aa) + (b-bb)*(b-bb))*4);
                                    end;
                                end;
                            end;

                        end;
                    end;
                end;
                if ms <= 1 || ms == mk % cannot build the linear system
                    continue;
                end;
                A = A(1:ms,1:ms);
                B1 = B1(1:ms,1);
                B2 = B2(1:ms,1);
                B3 = B3(1:ms,1);
                X1 = A\B1;
                X2 = A\B2;
                X3 = A\B3; % solve the linear system
                for aa=left:right
                    for bb=up:bottom
                        if mask(aa, bb) == 1
                            cnt = 0;
                            for ii=left:right
                                for jj=up:bottom
                                    if mask(ii,jj) == 0
                                        cnt = cnt+1;
                                        ma(cnt,1) = (aa-ii)*(aa-ii) + (bb-jj)*(bb-jj);
                                    end;
                                end;
                            end;
                            ma = ma(1:cnt,1);
                            img1 = 0;
                            img2 = 0;
                            img3 = 0;
                            for a=1:ms
                                img1 = img1 + X1(a,1) * sqrt(1 + (ma(a,1))*4);
                                img2 = img2 + X2(a,1) * sqrt(1 + (ma(a,1))*4);
                                img3 = img3 + X3(a,1) * sqrt(1 + (ma(a,1))*4);
                            end;
                            img(aa,bb,1) = img1;
                            img(aa,bb,2) = img2;
                            img(aa,bb,3) = img3;
                        end;
                    end;
                end;

            end;
        end;
       %img = uint8(img);
%         figure;
%         imshow(img);
        imwrite(img, ['./径向基随机结果1/50-',int2str(num),int2str(num),'result',int2str(amount),'0%.jpg']);
    end;
end;