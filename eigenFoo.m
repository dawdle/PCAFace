% Whiten ++
% testInfo = [];
%Convert the contents of a testClass cell array into a single matrix
% foo = cell2mat(testClass(1));
% for i = 1:size(foo,2)
%     testInfo = [testInfo vecs_white(:,foo(i))];
% end

cov = vecs_white' * vecs_white;
[evec, eval] = eig(cov);

%so IDK where this should go exactly. Ask Manuel. I put it in Reconstruct
%computing eigenvectors of real covariance matrix, since we changed it.
%eigvec = testInfo * evec;
% Do we also need to do this for eval? 

eval = diag(eval); %isolate values along diag
[eval,indx] = sort(eval,'descend'); %sort values
evec = evec(:,indx); %sort vectors in decending order