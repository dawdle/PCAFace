% Reconstruction and Error

[r c n] = size(images());
[j k] = size(evec);
%m = 33;

%Multiply our eigenvectors back into the whitened data then renormalize
eigvec = vecs_white * evec;
% eigvec = eigvec / norm(eigvec);

% Per vector normalization
for i = 1:size(eigvec,2)
    eigvec(:,i) = eigvec(:,i)/sqrt(sum(eigvec(:,i).^2));% / norm(eigvec);
end

%create table for error table
errorTable = zeros(r*c,1, n-30);
error2Table = zeros(n-30,1);

reconstImages = zeros(r,c,n);

% # of eigenvectors to keep
k=10;
foo = cell2mat(trainClass);
% foo is the matrix of indices into our training images
for i = 1:size(foo,1)
    for j = 1:size(foo,2)
        
        sample = reshape(images(:,:,foo(i,j)),r*c,1);
        
        %center:
        vecsample = sample - vec_avg;
        %projection using the first k eigvectors
        proj = eigvec(:,1:k)' * vecsample(:);
        %backprojection using k eigvectors, reconstruction
        bproj = eigvec(:,1:k) * proj(:);
        reconst = bproj + vec_avg(:);
        reconstImages(:,:,foo(i,j)) = mat2gray(reshape(reconst,r,c));
        %error:
        e = (reconst - sample);
        %e2 = sum(e.*e);
        e2 = rms(e);
        %create error tables
        errorTable(:,:,foo(i,j)) = e(:,:);
        error2Table(foo(i,j),1) = e2;
    end
end

% Test class reconstruction and error
foo = cell2mat(testClass);
for i = 1:size(foo,1)
    for j = 1:size(foo,2)
        
        sample = reshape(images(:,:,foo(i,j)),r*c,1);
        
        %center
        vecsample = sample - vec_avg;
        
        %projection using the first k eigvectors
        proj = eigvec(:,1:k)' * vecsample(:);
        %backprojection using k eigvectors, reconstruction
        bproj = eigvec(:,1:k) * proj(:);
        reconst = bproj + vec_avg(:);
        reconstImages(:,:,foo(i,j)) = mat2gray(reshape(reconst,r,c));
        %error:
        e = (reconst - sample);
        %e2 = sum(e.*e);
        e2 = rms(e);
        %create error tables
        errorTable(:,:,foo(i,j)) = e(:,:);
        error2Table(foo(i,j),1) = e2;
    end
end