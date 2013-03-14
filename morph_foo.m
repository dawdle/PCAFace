function [ morphBW ] = morph_foo( bwSkin )
%uses morphilogical operations on the thresholded image
%
[rows,cols] = size(bwSkin);
% %Apply fill for holes
filledBW=zeros(rows,cols);
filledBW = imfill(bwSkin,'holes');
morphBW = bwareaopen(filledBW,7500);
%Apply Erosion
%se2 = strel('disk',10);
%erodedBW=zeros(rows,cols);
%erodedBW = imerode(filledBW,se2);
%Apply Dilation
%se1 = strel('disk',8);
%dilateBW=zeros(rows,cols);
%dilateBW=imdilate(erodedBW,se1);
%multiply eroded image with skin segmented image to retain holes
%dilateBW = immultiply(dilateBW,bwSkin);
%Label skin regions
%morphBW=zeros(rows,cols);
%[morphBW,num] = bwlabel(dilateBW,8);



end

