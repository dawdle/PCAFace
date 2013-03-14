orig = csvread('Dbase/feat_loc.txt')
A = orig(:,2:end);
A
foo
subtractOrig = A-foo;
percentOrig = A./foo;
csvwrite('pupilCrop/subtraction.csv',subtractOrig)
percentOrig = A./float(foo);
percentOrig = A./double(foo);
percentOrig
csvwrite('pupilCrop/percent.csv',percentOrig)
ndx = [1:140]'
subtractOrig = [ndx subtractOrig]
percentOrig = [ndx percentOrig];
csvwrite('pupilCrop/subtraction.csv',subtractOrig)
csvwrite('pupilCrop/percent.csv',percentOrig)
subtractOrig
subtractOrig = subtractOrig(:,2:end);
subtractOrig
a = mean(subtractOrig(:,1))
b = mean(subtractOrig(:,2));
c = mean(subtractOrig(:,3));
d = mean(subtractOrig(:,4));
e = mean(subtractOrig(:,5));
f = mean(subtractOrig(:,6));
subtractOrig = [subtractOrig; 0 0 0 0 0 0; 0 0 0 0 0 0; a b c d e f];
subtractOrig
SUBS = subtractOrig;
subtractOrig = subtractOrig(:-2,:)
subtractOrig = subtractOrig(1:140,:)
a = std(subtractOrig(:,1)
a = std(subtractOrig(:,1))
b = std(subtractOrig(:,2));
c = std(subtractOrig(:,3));
d = std(subtractOrig(:,4));
e = std(subtractOrig(:,5));
f = std(subtractOrig(:,6));
foo = [SUBS;a b c d e f]
csvwrite('pupilCrop/subtraction.csv',SUBS)
SUBS = [[1:144]',SUBS]
[1:144]
[1:144]'
size(SUBS)
SUBS = [[1:143]',SUBS]
foo = [[1:144]' foo]
csvwrite('pupilCrop/subtraction.csv',foo)

foo = []
for i = 1:length(feat_loc)
foo = [foo; feat_loc{i}];
end
per = A./foo
percentOrig
percentOrig = percentOrig(:,2:end);
maxa = max(percentOrig(:,1))
maxb = max(percentOrig(:,2));
maxc = max(percentOrig(:,3));
maxd = max(percentOrig(:,4));
maxe = max(percentOrig(:,5));
maxf = max(percentOrig(:,6));
min
mina = min(percentOrig(:,2));
mina = min(percentOrig(:,1));
minb = min(percentOrig(:,2));
minc = min(percentOrig(:,3));
mind = min(percentOrig(:,4));
mine = min(percentOrig(:,5));
minf = min(percentOrig(:,6));
meana = mean(percentOrig(:,1));
meanb = mean(percentOrig(:,2));
meanc = mean(percentOrig(:,3));
meand = mean(percentOrig(:,4));
meane = mean(percentOrig(:,5));
meanf = mean(percentOrig(:,6));
stda = std(percentOrig(:,1));
stdb = std(percentOrig(:,2));
stdc = std(percentOrig(:,3));
stdd = std(percentOrig(:,4));
stde = std(percentOrig(:,5));
stdf = std(percentOrig(:,6));
foo = percentOrig;
foo = [foo; maxa maxb maxc maxd maxe maxf; mina minb minc mind mine minf; meana meanb meanc meand meane meanf; stda stdb stdc stdd stde stdf]
foo = [[1:144]', foo]
csvwrite('pupilCrop/percentage.csv',foo)