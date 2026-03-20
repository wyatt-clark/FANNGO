

% if meanvv, stdvv are empty, normalizes data by columns
% and returns mean and std values
% else uses meanvv, stdvv to rescale data

function [meanv,stdv,datanew]=normalize(data,meanvv,stdvv)

a=size(data);

if isempty(meanvv)
   meanv=mean(data);
   stdv=std(data);
   
   q=find(stdv<0.000000001);
   stdv(q)=1000;
else
   meanv=meanvv;
   stdv=stdvv;
end



big_mean = repmat(meanv,a(1),1);
data = data - big_mean; clear big_mean;
big_std = repmat(stdv,a(1),1);
datanew = data ./ big_std; clear big_std x;
return;