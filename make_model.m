function [ rmean, bmean, rbcov ] = make_model(img)
%fits sample skin samples into gaussian model 
%get cromatic values from skin sample
[cr, cb] = get_crcb(img);
%compute the statstics of sample values
rmean = mean(cr);
bmean = mean(cb);
rbcov = cov(cr,cb);
%TODO: remove everthing under this line!!!
%The concept of linear transformation of random variables is applied
%In this case, random variables Cr and Cb are jointly Gaussian
%Write joint distribution function
jointchart = zeros(256);
for r = 0:255
    for b = 0:255
        x = [(r - rmean);(b - bmean)];
        jointchart(r+1,b+1) = [power(2*pi*power(det(rbcov),0.5),-1)]*exp(-0.5* x'*inv(rbcov)* x);
    end
end
%plot 2D histogram
%subplot(4,3,1);
%plot_hist(cr,cb)
%title('2D Chromatic Histogram Model')
%plot joint distribution function
%subplot(4,3,2);
%surf(jointchart)
%title('Gaussian Model')
end

