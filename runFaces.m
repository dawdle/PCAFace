function runFaces()
%Test part 2 task 1
images = getDbase();
imskin = imread('skin.jpg');
[rmean, bmean, rbcov] = make_model(imskin);
for i=1:length(images);
skin = get_skin(images{i}, rmean, bmean, rbcov);
%[bwskin, opt] = skin2bw(skin);
bwskin = roicolor(skin,mean(mean(skin)),1);
%f = imspecial('laplacian')
morphbw = morph_foo(bwskin);
imwrite(morphbw, ['bw' num2str(i) '.jpg'],'jpg');



end

