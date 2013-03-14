% Image Loading / Cropping / Resizing Script
info = csvread('Dbase/feat_loc.txt');

M = size(info,1);

% Cell array where we store all resized images
Rotimages = [];

%http://www.mathworks.com/matlabcentral/newsreader/view_thread/130081

for r = 1:M
    % Load the image in - imread(strcat(sprintf('%03d',3,'.JPG'));
    img = imread(strcat('Dbase/',sprintf('%03d',r),'.JPG'));
    
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
    imwrite(M1,sprintf('Crop/%d',r),'jpg');
end
    