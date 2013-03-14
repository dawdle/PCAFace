% Splitting up Database

info = featLocAffine;

%number of students to use for test/train classes
% leave out last 3 students for rejection, so 30 pictures
testNtrain = (size(info,1)-30);

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

clearvars ndx info i IndexVector PermVector testNtrain