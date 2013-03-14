function suppressedHM = neighborhoodSuppression( HM, n )
%neighborhoodSuppression Supresses peaks in a nxn neighborhood
%   n should be odd.

% Center of our suppression neighborhood
halfN = floor(n/2);
[M,N] = size(HM);
% We don't want to modify the parameters and induce side effects
foo = HM;
suppressedHM = zeros(M,N); % Output matrix

% Took me too long to realize we can just pad with a builtin function
foo = padarray(foo,[4 4]);

% Convolution style - start with the center of our neighborhood 
% in the top left image pixel (not the padding)
for r = halfN+1:M+halfN 
    for c = halfN+1:N+halfN 
        % Extract a neighborhood sized matrix from our image
        bar = foo(r-halfN:r+halfN, c-halfN:c+halfN);
        % First check - our r,c pixel is at least the largest pixel in the 
        % neighborhood
        if foo(r,c) == max(max(bar))
            % Suppress equivalent maximums - i.e. for all maximums in the 
            % neighborhood that are not the first one, set them to 0
            count = 0;
            for i = r-halfN:r+halfN
                for j = c-halfN:c+halfN
                    % Skip first pixel
                    if foo(i,j) == max(max(bar)) & count == 0
                        count = count + 1;
                    else
                    % Suppress other maximums
                        foo(i,j) = 0;
                    end
                end
            % Because we have found a max, place it in our output matrix
            suppressedHM(r-halfN, c-halfN) = foo(r,c);
        end
    end
end

end