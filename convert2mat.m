%C:\Users\Abhinav\Documents\MATLAB\templates

myFolder = 'C:\Users\Abhinav\Documents\MATLAB\templates';
filePattern = fullfile(myFolder, '*.jpg');
jpegFiles = dir(filePattern);
% Process each jpeg file and store it in a cell array named imdata
for k = 1:length(jpegFiles )
   baseFileName = jpegFiles(k).name;
   fullFileName = fullfile(myFolder, baseFileName);
   imdata{k} =imread(fullFileName);
end
% save imdata to a mat file named jpgfile:
savefile = 'jpgfile.mat';
save(savefile, 'imdata')