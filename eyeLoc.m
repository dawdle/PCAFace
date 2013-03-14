clear
peaksPer = zeros(140,1);
picRowPeaks = cell(140,1);
picColPeaks = cell(140,1);

%load imgs
for i = 1:140
    threshImg = im2double(imread(['thresholded/bw' num2str(i) '.jpg']));
    origImg = im2double(imread(strcat('Dbase/',sprintf('%03d',i),'.JPG')));
    origNew = rgb2gray(origImg);
    origNew = (origNew .* threshImg);
    enhanced = edgeEnhance(origNew);
    houghMat = fillAccum(enhanced);
    
    intensityThresh = 25;
    [peaksPer(i) picRowPeaks{i} picColPeaks{i}] = plotCenters(houghMat,enhanced, intensityThresh);
end

% for i = 1:140
% img = rgb2gray(imread(strcat('Dbase/',sprintf('%03d',i),'.JPG')));
% imshow(img); hold on;
% for j = 1:length(picColPeaks{i})
% col = picColPeaks{i}(j);
% row = picRowPeaks{i}(j);
% plot(row,col,'or')
% end
% print('-djpeg',sprintf('%03d.jpg',i))
% end