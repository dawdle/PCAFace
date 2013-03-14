function [ cr,cb ] = get_crcb(img)
%get crominance values of an input image
%convert from RGB into YCbCr
imgYCbCr = rgb2ycbcr(img);
%create a filter matrix
filtermat = 1/9 * ones(3);
%get Cr & Cb values
cr = imgYCbCr(:,:,3);
cb = imgYCbCr(:,:,2);
%apply filter to crominance values
cr = filter2(filtermat, cr);
cb = filter2(filtermat, cb);
%convert into vector
cr = reshape(cr, 1, prod(size(cr)));
cb = reshape(cb, 1, prod(size(cb)));
end

