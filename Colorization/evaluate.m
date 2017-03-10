clc;
imge = cell(3,4);
imge{1,1} = imread('./结果/11result1.bmp');
imge{1,2} = imread('./结果/11result2.bmp');
imge{1,3} = imread('./结果/11result3.bmp');
imge{1,4} = imread('./结果/11result.bmp');
imge{2,1} = imread('./结果/22result1.bmp');
imge{2,2} = imread('./结果/22result2.bmp');
imge{2,3} = imread('./结果/22result3.bmp');
imge{2,4} = imread('./结果/22result.bmp');
imge{3,1} = imread('./结果/33result1.bmp');
imge{3,2} = imread('./结果/33result2.bmp');
imge{3,3} = imread('./结果/33result3.bmp');
imge{3,4} = imread('./结果/33result.bmp');
for a = 1:3
    if a == 1
        img = imread('./结果/11.bmp');
    elseif a == 2
        img = imread('./结果/22.bmp');
    elseif a == 3
        img = imread('./结果/33.bmp');
    end;
    for b = 1:4
        [row, col, c, d] = size(imge{a,b});
        img = img(1:row,1:col,1:3,1);
        result = 0;
        result2 = 0;
        for i = 1:row
            for j = 1:col
                for k = 1:3
                    result = double(abs((img(i,j,k) - imge{a,b}(i,j,k)))) + result;
                    result2 = double((img(i,j,k) - imge{a,b}(i,j,k))^2) + result2;
                end;
            end;
        end;
        arr(a,b) = result / (row*col);
        arr2(a,b) = result2 / (row*col);
    end;
end;