% Reconstruction and Error for both Rejection Classes
% Builds tables for these error rates


% Rejection class reconstruction and error

% Create error tables
affineRejectImages = zeros(128,128,30);
affineRejectErrorTable = zeros(r*c,1,30);
affineRejectError2Table = zeros(30,1);
for i = 111:140
    rejectionSample = reshape(Rotimages(:,:,i),r*c,1);
    
    %center:
    vecsample = rejectionSample - vec_avg;
    %projection using the first k eigvectors
    proj = eigvec(:,1:k)' * vecsample(:);
    %backprojection using k eigvectors, reconstruction
    bproj = eigvec(:,1:k) * proj(:);
    affineRejection = bproj + vec_avg(:);
    affineRejectImages(:,:,i) = mat2gray(reshape(affineRejection,r,c));
    %error:
    affineRejE = (affineRejection - rejectionSample);
    %affineRejE2 = sum(affineRejE.*affineRejE);
    affineRejE2 = rms(affineRejE);
    
    %create error tables
    affineRejectErrorTable(:,:,i-110) = affineRejE(:,:);
    affineRejectError2Table(i-110,1) = affineRejE2;
end

% Error table - non-affine
[rowE colE] = size(affineRejectErrorTable);
[rowE2 colE2] = size(affineRejectError2Table);
classRejectError = cell(3,1);

% Rejection Error
for classPic = 1:3
    err = zeros(10,1);
    %for each of a class' test images, add to class cell
    for iter = 1:10
        %get error's index from cell
        % Testing per pixel error
        err(iter) = affineRejectError2Table(((classPic-1)*10)+iter);%/(128^2);
    end
    %average the faces of the class and create the average face
    classRejectError{classPic} = err;
end

%writing csv
fid = fopen('rejectAffineError.csv','wt');
%print error for each reject image in each class
fprintf(fid, 'class,image1,image2,image3,image4,image5\n');
for i=1:size(classRejectError,1)
    fprintf(fid, '%d,%d,%d,%d,%d,%d\n',i, classRejectError{i,:}(1:5));
end
fprintf(fid,'\n');
fprintf(fid,'\n');
fprintf(fid, 'class,image6,image7,image8,image9,image10\n');
for i=1:size(classRejectError,1)
    fprintf(fid, '%d,%d,%d,%d,%d,%d\n',i, classRejectError{i,:}(6:10));
end


%print avrg error per class
fprintf(fid, '\n');
for i = 1:3
fprintf(fid, 'class %d mean,%d\n', i,(sum(classRejectError{i,:})/10));
end
fprintf(fid, '\n');
fprintf(fid,'Sum Total of Rejection Error,%d\n', sum(cell2mat(classRejectError)));
fprintf(fid,'\n');
fprintf(fid,'Mean of Total Rejection Error,%d\n',mean(cell2mat(classRejectError)));
fprintf(fid,'\n');
fprintf(fid,'Std of Rejection Error,%d\n',std(cell2mat(classRejectError)));
fprintf(fid,'\n');
% Which images of each class were training / testing / rejecting
fprintf(fid,'Affine Rejection Class Indices\n');
fprintf(fid,'111-140\n');