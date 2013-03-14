% Error table - non-affine
[rowE colE] = size(affineErrorTable);
[rowE2 colE2] = size(affineError2Table);
classTrainError = cell(11,1);
classTestError = cell(11,1);

% Training Error
for classPic = 1:11
    err = zeros(5,1);
    %for each of a class' test images, add to class cell
    for iter = 1:5
        %get error's index from cell
        err(iter) = affineError2Table(trainClass{classPic}(iter));%/(128^2);
    end
    %average the faces of the class and create the average face
    classTrainError{classPic} = err;
end

%writing csv
fid = fopen('trainAffineError.csv','wt');
%print error for each test image in each class
fprintf(fid, 'class,image1,image2,image3,image4,image5\n');
for i=1:size(classTrainError,1)
    fprintf(fid, '%d,%d,%d,%d,%d,%d\n',i, classTrainError{i,:});
end
%print avrg error per class
fprintf(fid, '\n');
for i = 1:11
fprintf(fid, 'class %d mean,%d\n', i,(sum(classTrainError{i,:})/5));
end
fprintf(fid, '\n');
fprintf(fid,'Sum Total of Train Error,%d', sum(cell2mat(classTrainError)));
fprintf(fid,'\n');
fprintf(fid,'Mean Total of Train Error,%d', mean(cell2mat(classTrainError)));
fprintf(fid,'\n');
fprintf(fid,'Std of Train Error,%d\n',std(cell2mat(classTrainError)));
fprintf(fid,'\n');


% Which images of each class were training / testing
fprintf(fid,'Affine Training Class Indices\n');
tempTrainClass = cell2mat(trainClass);
for i = 1:size(tempTrainClass,1)
    fprintf(fid,'%d,%d,%d,%d,%d\n',tempTrainClass(i,:));
end
fprintf(fid,'\n');



% Test Error
for classPic = 1:11
    err = zeros(5,1);
    %for each of a class' test images, add to class cell
    for iter = 1:5
        %get error's index from cell
        err(iter) = affineError2Table(testClass{classPic}(iter));%/(128^2);
    end
    %average the faces of the class and create the average face
    classTestError{classPic} = err;
end

%writing csv
fid = fopen('testAffineError.csv','wt');
%print error for each test image in each class
fprintf(fid, 'class,image1,image2,image3,image4,image5\n');
for i=1:size(classTestError,1)
    fprintf(fid, '%d,%d,%d,%d,%d,%d\n', i,classTestError{i,:});
end
%print avrg error per class
fprintf(fid, '\n');
for i = 1:11
fprintf(fid, 'class %d mean,%d\n', i, (sum(classTestError{i,:})/5));
end
fprintf(fid, '\n');
fprintf(fid,'Sum Total of Testing Error,%d', sum(cell2mat(classTestError)));
fprintf(fid,'\n');
fprintf(fid,'Mean Total of Testing Error,%d', mean(cell2mat(classTestError)));
fprintf(fid,'\n');
fprintf(fid,'Std of Testing Error,%d\n',std(cell2mat(classTestError)));
fprintf(fid,'\n');

affineTestErr = cell2mat(classTestError);
affineTrainErr = cell2mat(classTrainError);

fprintf(fid,'Affine Test Class Indices\n');
tempTestClass = cell2mat(testClass);
for i = 1:size(tempTestClass,1)
    fprintf(fid,'%d,%d,%d,%d,%d\n',tempTestClass(i,:));
end
