function ThresholdSmoothRefImage(inputfolder,outputfolder,filenames,threshlevel,smoothsize,numFrames);

for j = 1:numFrames
    im = imread(fullfile(inputfolder,filenames{j}));
    bwimage = im>threshlevel;
%     clearedimage = bwareaopen(bwimage,2);
    closedimage = imopen(bwimage,strel('disk',smoothsize));
    imwrite(closedimage,fullfile(outputfolder,filenames{j}),'tif');
end