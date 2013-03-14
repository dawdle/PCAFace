function [ images ] = getDbase()
%gets all the fane images
%get list of all files from directory
file = dir('Dbase');
%remove the non-image files
file = file(4:143);
%get the number of files
NF = length(file);
%create a cell matrix to hold images
images=cell(NF,1);
%iterate through list reading files
for k = 1:NF
images{k} = imread(fullfile('Dbase', file(k).name));
end


end

