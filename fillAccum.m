function [ HM ] = fillAccum( cellBW )
%fillAccum is a function to build and fill the Hough accumulator matrix

[y,x] = find(cellBW); % find the location of all 1's x and y coordinates
[m,n] = size(cellBW); % obtain the size of the image
totalpix = length(x); % find the total number of 1's
%HM = zeros(m*n*11,1);
HM = zeros(n,m); %preallocate the Hough matrix for increased effeciency.
radius = 1:10; %would be used for finding an unknown radius
r = 11; % set radius to 11 pixels. Obtained hand measuring multiple cells

%From 1 to total number of pixels with a 1 as the index for x and y
for indx = 1:totalpix
    prevA = .1; % variables for holding previous a and b values
    prevB = .1; % initialize to .1 because a&b will always be whole numbers 
    for t = 0:359 % rotate 360 degrees in steps of 1 degree
        radians = t*pi/180;
        a = round(x(indx) - r*cos(radians)); 
        b = round(y(indx) - r*sin(radians));
        %if a&b are greater than 0, within the range of the matrix, and
        %dont equal the previous a&b; increment the value at that point
        if a > 0 && a < n && b > 0 && b < m && (a ~= prevA || b ~= prevB)
        HM(a,b) = HM(a,b) + 1;
        prevA = a; prevB = b; %set previous a&b to current
        end
    end
end

