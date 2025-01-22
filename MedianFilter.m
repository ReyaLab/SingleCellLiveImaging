function MedianFilter(inputfolder,outputfolder,filenames,filtersize,numFrames)

parfor j = 1:numFrames
    medfiltered = MedFilterRead(fullfile(inputfolder,filenames{j}),filtersize);
    imwrite(medfiltered,fullfile(outputfolder,filenames{j}))
end