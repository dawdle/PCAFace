function [ bwImage ] = edgeEnhance( img )
%edgeEnhance takes an RGB 'img' and outputs BW img with the edges enhanced
%   I first isolate the upper portion of the image of the face by removing
%   the information in the areas that we weren't interested in. Second we
%   threshold the image to remove the black backround and isolate the eyes
%   I then go on to use a laplacian filter to enhance the edges to increase
%   our chances of locating the eyes circular outline.

face = im2double(img); %convert input img to double
[x,y,z] = size(face); %get size of image
cellR = zeros(x,y,1); %allocate matrix to hold red portion of image
cellR(:,:) = face(:,:,1); % save the red spectrum of the cell image

%only look at the top part of the picture for eyes by zeroing ll values
%below row 270
blankZeros = zeros(512,512);
blankOnes = ones(512,512);
blankZeros(1:270,:) = blankZeros(1:270,:) + blankOnes(1:270,:);
cellR(:,:) = cellR .* blankZeros;

%Here I threshold the image's intensity values to only include values
%between .15(which is the top end of the dark values in the images that 
%weren't in the face) and .3 which is the top end of the dark end of the 
%eyes. We did this to reduce the amount of the face included to accentuate 
%the eyes
filteredImage = roicolor(cellR,0.15,0.3);

%After trying a couple of different edge detections such as sobel and
%canny, I had the most success with the laplacian filter with an ALPHA=0.2
H1 = fspecial('laplacian',.2);
bwImage = imfilter(filteredImage,H1);

%imshow(bwImage);
end
