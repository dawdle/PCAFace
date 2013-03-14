% Image Loading / Cropping / Resizing Script
% info = csvread('Dbase/feat_loc.txt');

% M = size(info,1);
M = 140; % Magic number!

% Cell array where we store all resized images
images = [];
feat_loc = cell(140,1);
for i = 1:length(picColPeaks)
    % Checking for a potential pupil in neighborhood
    % If we don't find one we default cut
    % Default location - LI(185,220) RI(318,220)
    potLC = picRowPeaks{i};
    potRC = picRowPeaks{i};
    potR = picColPeaks{i};
    
    % Neighborhood Cols - LI - 128 - 256
    potLC = potLC(potLC < 256);
    potLC = potLC(potLC > 128);
    foo = length(potLC);
    if foo == 0
        leftIC = 185;
    elseif foo == 1
        leftIC = potLC(1);
    else 
        leftIC = round(mean(potLC));
    end
    
    % Right Eye - 256 - 384
    potRC = potRC(potRC < 384);
    potRC = potRC(potRC > 296);
    foo = length(potRC);
    if foo == 0
        rightIC = 318;
    elseif foo == 1
        rightIC = potRC(1);
    else 
        rightIC = round(mean(potRC));
    end
    
    % Neightborhood Cols - 100 - 270
    % I Cols tend to be very near
    potR = potR(potR < 270);
    potR = potR(potR > 100);
    foo = length(potR);
    if foo == 0
        IR = 220;
    elseif foo == 1
        IR = potR(1);
    else
        IR = round(mean(potR));
    end
    
    % MC = half distance between eyes - usually correct
    MC = round((leftIC + rightIC) / 2);
    % MR = distance between eyes added to eye col (avg 131)
    % off by perspectives but reasonable
    MR = round((rightIC - leftIC) + IR);
    feat_loc{i} = [IR leftIC IR rightIC MR MC];
end

    
for r = 1:M
    % Load the image in - imread(strcat(sprintf('%03d',3,'.JPG'));
    img = im2double(imread(strcat('Dbase/',sprintf('%03d',r),'.JPG')));
    
    % Identify Feature Location - I cols tend to be the same
    bar = feat_loc{r};
    lefti_r = bar(1);
    righti_r = bar(3);
    lefti_c = bar(2);
    righti_c = bar(4);
    mouth_c = bar(5);
    mouth_r = bar(4);
    
    % Extract feature * 30 percent (10% wasn't getting enough info)
    R = (mouth_r - max(lefti_r,righti_r));
    C = (righti_c - lefti_c);
    foo = round(R*.3);
    bar = round(C*.3);
    
    face = img(lefti_r-foo:mouth_r+foo, ...
        lefti_c-bar:righti_c+bar);
    
    % Resize with imresize(face,[128 128])
    face = imresize(face,[128 128]);
    
    % Print images to pupilCropped Directory
    imwrite(face,strcat('pupilCrop/',sprintf('%03d',r),'.jpg'),'jpg');
end

clearvars C M R bar face foo img info left* mouth* right* r 