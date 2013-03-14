function [ numPeaks rowCord colCord ] = plotCenters( HM, BW, intensityThresh)
%plotCenters takes a Hough matrix and plots the centers on top of the image
%and return the number of centers found.
%   This function take a 2d hough matrix with a radius already determined.
%   Before it plots the centers, it finds the peaks in neighborhoods around
%   centers of the cells and thresholds to remove low probablility and some
%   duplicate centers

[x,y] = size(HM); % get dimensions of the Hough matrix

%create a zeros matrix for holding the new Hough matrix 
peaks = zeros(x,y);

% Max area suppression on the Hough Matrix using neighborhoodSupression 
% with a nieghborhood of size 9 pixels
peaks = neighborhoodSuppression(HM,9);
 
%nnz(peaks) %number of nonzero entries in the matrix used for testing
rowCord = [];
colCord = [];
numPeaks = 0; 
intensityThresh = 0;
plotCount = 0;
maxIntensity = max(max(peaks));
%since there must be at least two centers for the eyes' coordinates, loop
%until we have at least two cents. Starting with the highest intensity per
%hough matrix and decrementing by 1 on each iteration.
    while plotCount < 2        
        numMax = sum(sum(peaks == maxIntensity)); %number of centers
        plotCount = plotCount + numMax; %total number of centers found
        [r c] = find(peaks == maxIntensity); %coords of centers
        for row = 1:length(r)
            rowCord = [rowCord r(row)];
            colCord = [colCord c(row)];
            numPeaks = numPeaks + 1;
        end
        maxIntensity = maxIntensity - 1;
        intensityThresh = maxIntensity; 
    end

end

