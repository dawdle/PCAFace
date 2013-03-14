%This script is utilized for part 3 of the project. It starts with
%establishing the testing, training, and rejection sets. It proceeds with
%computing the average faces for each of the training classes. And lastly
%ends with populating the cross-correlation table with the maxes.

%read in the cropped images produced from part 2.
part2Images = [];
for iter = 1:140
    part2Images(:,:,iter) = im2double(imread(strcat('pupilCrop/',sprintf('%03d',iter),'.JPG')));
end

%number of students to use for test/train classes
% leave out last 3 students for rejection, so 30 pictures
testNtrain = (140-30);

% outputInfo = fopen('splits.txt','w');
% Storing indices of each class in a cell array
trainClass = cell(testNtrain/10,1);
testClass = cell(testNtrain/10,1);
i = 1; %index into classes
% Step from 1:size of csv by 10 to get the index of each student's firt pic
for ndx = 1:10:testNtrain
    IndexVector = ndx:ndx+9; %indexes of a single student's pictures
    PermVector = randperm(10); %randomly pick pics for 5 test & 5 train
    trainClass{i} = [IndexVector(PermVector(1:5))]; %assign to training
    testClass{i} = [IndexVector(PermVector(6:10))]; %assign to testing
    i = i+1; %increment index into classes
end

%creating average faces for each class' training set
averageFaces = zeros(128,128,11);
for classPic = 1:11
    %3D matrix to concat the imgs together into for averaging
    avrgingMtrx = zeros(128,128,5); 
    for iter = 1:5 
        pic2grab = trainClass{classPic}(iter); %get img index from cell
        avrgingMtrx(:,:,iter) = part2Images(:,:,pic2grab);
    end
    %average the faces of the class and create the average face
    averageFaces(:,:,classPic) = mean(avrgingMtrx,3);
end

%crosscorrelation to correlate the avrg faces with the images from training
xCorMax = zeros(11,5);%table for values of the max of the cross-correlation
for classPic = 1:11
    for iter = 1:5
        pic2grab = trainClass{classPic}(iter); 
        trainingImg = part2Images(:,:,pic2grab); %getting the test image
        % normalized cross-crosscorrelation
        C = normxcorr2(averageFaces(:,:,classPic),trainingImg);
        xCorMax(classPic,iter) = max(max(C));

    end

end


clearvars ndx info i IndexVector PermVector testNtrain