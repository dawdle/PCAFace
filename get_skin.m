function [ skin ] = get_skin(img, rmean, bmean, rbcov)
%get skin from original image
%convert rgb into YCrCb
imgYCbCr = rgb2ycbcr(img);
%get size of original image
[rows, cols, rgb] = size(img);
%create a skin matrix
skin = zeros(rows, cols);
for i=1:rows
    for j=1:cols
        %get crominance values for each pixel in original image
        cr = double(imgYCbCr(i,j,3));
        cb = double(imgYCbCr(i,j,2));
        %compute if this is a skin pixel by its difference in skin space
        DIFS = [(cr-rmean); (cb-bmean)];
        skin(i,j) = [power(2*pi*power(det(rbcov),0.5),-1)]*exp(-0.5* DIFS'*inv(rbcov)* DIFS);
    end
end
%filter the results
filtermat = 1/9*ones(3);
skin = filter2(filtermat, skin);
%normalize all values in regard to the highest value
skin = skin./max(max(skin));
%TESTING: delete all lines after this one!
%show skin likelyhood grayscale image
%subplot(4,3,3);
%imshow(img, [0 1])
%title('Original RGB Image')
%subplot(4,3,4);
%imshow(skin, [0 1])
%title('Identified as Skin')



end

