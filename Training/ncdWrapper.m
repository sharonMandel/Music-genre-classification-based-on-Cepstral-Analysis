function [ dis ] = ncdWrapper( mat1, mat2 )
%UNTITLED Wrapper for the NCD function
%   mat1, mat2 - MFCC in double matrix 

n = NCD('lzma','best');
% %str1 = mat2str(mat1); %sprintf('%f', mat1);
% %str2 = mat2str(mat2); %sprintf('%f',mat2);
% rs1 = reshape(mat1,1,[]);
% rs2 = reshape(mat2,1,[]);
str1 = sprintf('%.3f',mat1);
str2 = sprintf('%.3f',mat2);
result = n.calculate(str1,str2);
dis = result(1,2);
% avgM1 = mean(mat1');
% avgM2 = mean(mat2');
% avgM1 = avgM1';
% avgM2 = avgM2';
% str1 = sprintf('%.5f',avgM1);
% str2 = sprintf('%.5f',avgM2);
% result = n.calculate(str1,str2);
% dis = result(1,2);
% dis = pdist2(avgM1,avgM2);
% dis = pdist2(rs1,rs2);
%  dis1 = pdist2(mat1,mat2);
%  dis2 = mean(dis1);
%  dis = mean(dis2);

end

