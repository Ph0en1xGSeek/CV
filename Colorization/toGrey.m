in_name = '33.jpg';
out_name = '33Grey.bmp'
img = imread(in_name);
img = rgb2gray(img);
imwrite(img, out_name);