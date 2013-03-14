% Image Loading / Cropping / Resizing Script
info = csvread('Dbase/feat_loc.txt');

M = size(info,1);

% Cell array where we store all resized images
images = [];

for r = 1:M
    % Load the image in - imread(strcat(sprintf('%03d',3,'.JPG'));
    img = im2double(imread(strcat('Dbase/',sprintf('%03d',r),'.JPG')));
    
    % Identify Feature Location
    [lefti_r, lefti_c, righti_r, righti_c, ...
        mouth_r, mouth_c] = extractFeatures(info,r);
    
    % Extract feature * 30 percent (10% wasn't getting enough info)
    R = (mouth_r - max(lefti_r,righti_r));
    C = (righti_c - lefti_c);
    foo = round(R*.3);
    bar = round(C*.3);
    
    face = img(lefti_r-foo:mouth_r+foo, ...
        lefti_c-bar:righti_c+bar);
    
    % Resize with imresize(face,[128 128])
    face = imresize(face,[128 128]);
    
    % Store in image cell array
    images(:,:,r) = face;
    imwrite(face,sprintf('reconCropped/%03d.jpg',r),'jpg');
end

clearvars C M R bar face foo img info left* mouth* right* r 