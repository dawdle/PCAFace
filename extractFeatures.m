function [ lefti_r,lefti_c,righti_r,righti_c,mouth_r,mouth_c ] = ... 
    extractFeatures( csvMatrix, ndx )
%extractFeatures Utility func to pull feature locations from CSV matrix
%   returns feature info for given csvMatrix from row = ndx
lefti_r = csvMatrix(ndx,2);
lefti_c = csvMatrix(ndx,3);
righti_r = csvMatrix(ndx,4);
righti_c = csvMatrix(ndx,5);
mouth_r = csvMatrix(ndx,6);
mouth_c = csvMatrix(ndx,7);

end