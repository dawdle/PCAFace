% Reconstruction and Error for both Training and testing classes
% Builds tables for these error rates

[r c n] = size(Rotimages());
[j k] = size(evec);
%m = 33;

%Multiply our eigenvectors back into the whitened data then renormalize
eigvec = vecs_white * evec;
% eigvec = eigvec / norm(eigvec);
for i = 1:size(eigvec,2)
    %eigvec(:,i) = eigvec(:,i)/norm(eigvec(:,i));
    eigvec(:,i) = eigvec(:,i)/sqrt(sum(eigvec(:,i).^2));% / norm(eigvec);
end

%create table for error table
affineErrorTable = zeros(r*c,1, n-30);
affineError2Table = zeros(n-30,1);

affineReconImages = zeros(r,c,n);

% # of eigenvectors to keep
k=55;

foo = cell2mat(trainClass);
% Training class reconstruction and error
for i = 1:size(foo,1)
    for j = 1:size(foo,2)
        
        affineSample = reshape(Rotimages(:,:,foo(i,j)),r*c,1);
        
        %center:
        vecsample = affineSample - vec_avg;
        %projection using the first k eigvectors
        proj = eigvec(:,1:k)' * vecsample(:);
        %backprojection using k eigvectors, reconstruction
        bproj = eigvec(:,1:k) * proj(:);
        affineReconst = bproj + vec_avg(:);
        affineReconImages(:,:,foo(i,j)) = mat2gray(reshape(affineReconst,r,c));
        %error:
        affineE = (affineReconst - affineSample);
        %affineE2 = sum(affineE.*affineE);
        affineE2 = rms(affineE);
        
        %create error tables
        affineErrorTable(:,:,foo(i,j)) = affineE(:,:);
        affineError2Table(foo(i,j),1) = affineE2;
    end
end

% Test class reconstruction and error
foo = cell2mat(testClass);
for i = 1:size(foo,1)
    for j = 1:size(foo,2)
        
        affineSample = reshape(Rotimages(:,:,foo(i,j)),r*c,1);
        
        %center
        vecsample = affineSample - vec_avg;
        
        %projection using the first k eigvectors
        proj = eigvec(:,1:k)' * vecsample(:);
        %backprojection using k eigvectors, reconstruction
        bproj = eigvec(:,1:k) * proj(:);
        affineReconst = bproj + vec_avg(:);
        affineReconImages(:,:,foo(i,j)) = mat2gray(reshape(affineReconst,r,c));
        %error:
        affineE = (affineReconst - affineSample) / (128^2); % Per Pixel Error?
        %affineE2 = sum(affineE.*affineE);
        affineE2 = rms(affineE);
        
        %create error tables
        affineErrorTable(:,:,foo(i,j)) = affineE(:,:); %Euclidien distance
        affineError2Table(foo(i,j),1) = affineE2; %error per image
    end
end