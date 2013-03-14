[rowE colE] = size(errorTable);
[rowE2 colE2] = size(error2Table);
classTrainError = cell(11,1);
classTestError = cell(11,1);

% Training Error
for classPic = 1:11
    err = zeros(5,1);
    %for each of a class' test images, add to class cell
    for iter = 1:5
        %get error's index from cell
        % Testing per pixel error
        err(iter) = error2Table(trainClass{classPic}(iter));%/(128^2);
    end
    %average the faces of the class and create the average face
    classTrainError{classPic} = err;
end

% Testing Error
for classPic = 1:11
    err = zeros(5,1);
    %for each of a class' test images, add to class cell
    for iter = 1:5
        %get error's index from cell
        % Testing per pixel error
        err(iter) = error2Table(testClass{classPic}(iter));%/(128^2);
    end
    %average the faces of the class and create the average face
    classTestError{classPic} = err;
end


%writing Training csv
fid = fopen('trainError.csv','wt');
%print error for each train image in each class
fprintf(fid, 'class,image1,image2,image3,image4,image5\n');
for i=1:size(classTrainError,1)
    fprintf(fid, '%d,%d,%d,%d,%d,%d\n',i, classTrainError{i,:});
end
%print avrg error per class
fprintf(fid, '\n');
for i = 1:11
fprintf(fid, 'class %d mean,%d\n',i, (sum(classTrainError{i,:})/5));
end
fprintf(fid,'\n');
fprintf(fid,'Sum Total of Training Error,%d', sum(cell2mat(classTrainError)));
fprintf(fid,'\n');
fprintf(fid,'Mean Total of Training Error,%d', mean(cell2mat(classTrainError)));
fprintf(fid,'\n');
fprintf(fid,'Std of Training Error,%d\n',std(cell2mat(classTrainError)));
fprintf(fid,'\n');
fprintf(fid,'Training Class Indices\n');
tempTrainClass = cell2mat(trainClass);
for i = 1:size(tempTrainClass,1)
    fprintf(fid,'%d,%d,%d,%d,%d\n',tempTrainClass(i,:));
end


%writing Testing csv
fid = fopen('testError.csv','wt');
%print error for each test image in each class
fprintf(fid, 'class,image1,image2,image3,image4,image5\n');
for i=1:size(classTestError,1)
    fprintf(fid, '%d,%d,%d,%d,%d,%d\n',i, classTestError{i,:});
end
%print avrg error per class
fprintf(fid, '\n');
for i = 1:11
fprintf(fid, 'class %d mean,%d\n',i, (sum(classTestError{i,:})/5));
end
fprintf(fid,'\n');


fprintf(fid,'Sum Total of Testing Error,%d', sum(cell2mat(classTestError)));
fprintf(fid,'\n');
fprintf(fid,'Mean Total of Testing Error,%d', mean(cell2mat(classTestError)));
fprintf(fid,'\n');
fprintf(fid,'Std of Testing Error,%d\n',std(cell2mat(classTestError)));
fprintf(fid,'\n');

% Which images of each class were training / testing
fprintf(fid,'\n');
fprintf(fid,'Testing Class Indices\n');
tempTestClass = cell2mat(testClass);
for i = 1:size(tempTestClass,1)
    fprintf(fid,'%d,%d,%d,%d,%d\n',tempTestClass(i,:));
end


% For debugging
testErr = cell2mat(classTestError);
trainErr = cell2mat(classTrainError);
