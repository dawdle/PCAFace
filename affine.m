% Image Loading / Cropping / Resizing Script
info = csvread('Dbase/feat_loc.txt');

M = size(info,1);

% Cell array where we store all resized images
Rotimages = zeros(128,128,M);

%http://www.mathworks.com/matlabcentral/newsreader/view_thread/130081

% New Feature Locations
featLocAffine = zeros(M,6);

for r = 1:M
    % Load the image in - imread(strcat(sprintf('%03d',3,'.JPG'));
    img = im2double(imread(strcat('Dbase/',sprintf('%03d',r),'.JPG')));
    
    [row, col, depth] = size(img);
    centerRow = row/2; centerCol = col/2;
    
    [lefti_r, lefti_c, righti_r, righti_c, ...
        mouth_r, mouth_c] = extractFeatures(info,r);
    
    eyeDiffCol = lefti_c - centerCol;
    eyeDiffRow = lefti_r - centerRow; 
    
    %a^2 + b^2 = c^2
    a = righti_c - lefti_c;
    b = righti_r - lefti_r; % if negative left eye below right eye
    c = sqrt(a^2 + b^2);
    
    %angle difference between left and right eye in degrees
    angleDeg = asind(b/c);
    
    % Rotate
    xform = [cosd(angleDeg) sind(angleDeg) 0;...
         -sind(angleDeg) cosd(angleDeg) 0;...
         0 0 1];
    translate1 = [ 1 0 0;
                0 1 0;
              -lefti_r -lefti_c 1];
    translate2 = [ 1 0 0;
                0 1 0;
              lefti_r lefti_c 1];
    rotate_xform = translate1*xform*translate2;
          
    
    %recenter img here on left eye
    T1 = maketform('affine',rotate_xform);
    R3 = makeresampler('cubic','fill');
    M1 = tformarray(img,T1,R3,[1 2],[1 2],[row col],[],0);
    imwrite(M1,sprintf('affinePre/%03d.jpg',r),'jpg');
    
    
    % Save new features
    lefts = imtransform([lefti_r,lefti_c],T1);
    rights = imtransform([righti_r,righti_c],T1);
    mouf = imtransform([mouth_r,mouth_c],T1);
    
    % Store features for analysis
    featLocAffine(r,1) = round(lefts(1,1));
    featLocAffine(r,2) = round(lefts(1,2));
    featLocAffine(r,3) = round(rights(1,1));
    featLocAffine(r,4) = round(rights(1,2));
    featLocAffine(r,5) = round(mouf(1,1));
    featLocAffine(r,6) = round(mouf(1,2));
    
    % Set extraction features
    lefti_r = round(lefts(1,1));
    lefti_c = round(lefts(1,2));
    righti_r = round(rights(1,1));
    righti_c = round(rights(1,2));
    mouth_r = round(mouf(1,1));
    mouth_c = round(mouf(1,2));
    
    % Resize rotated images - similar to cropImgs.m
     % Extract feature * 30 percent (10% wasn't getting enough info)
    R = (mouth_r - max(lefti_r,righti_r));
    C = (righti_c - lefti_c);
    foo = round(R*.3);
    bar = round(C*.3);
    
    face = img(lefti_r-foo:mouth_r+foo, ...
        lefti_c-bar:righti_c+bar);
    
    % Resize with imresize(face,[128 128])
    face = imresize(face,[128 128]);
    imwrite(face,sprintf('affineCropped/%03d.jpg',r),'jpg');
    % Save new images
    Rotimages(:,:,r) = face;
end

csvwrite('affineFeatures.csv',featLocAffine);
    