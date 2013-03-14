% Vectorize!!

[r c n] = size(Rotimages());

% create a matrix containing the trainingClasses indecies
foo = cell2mat(trainClass);
[M N] = size(foo);
vecs = zeros(r*c,M*N);
count = 0;
for i = 1:M
    for j = 1:N
        count = count + 1;
        datavec = reshape(Rotimages(:,:,foo(i,j)),r*c,1);
        %datavec = (datavec - mean(datavec) ) / std(datavec); %normalize
        vecs(:,count) = datavec;
    end
end

vec_avg = mean(vecs,2); % mean of each row
bigVecAvg = repmat(vec_avg,1,M*N);
vecs_white = vecs - bigVecAvg; % whiten

clearvars bigVecAvg datavec c i n r vecs
% 
% vec_avg = [mean(vecs')]'; % mean of each row
% bigVecAvg = repmat(vec_avg,1,n); % Replicating the vec_avg to 
% vecs_white = vecs - bigVecAvg; % whiten
% 
% clearvars bigVecAvg datavec c i n r vecs