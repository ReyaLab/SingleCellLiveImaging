% run cKitPosLinNeg
clear all
close all

%% specify these parameters
% folder names
inputfolder = 'C:\Users\tklee.WIN\research\reya_image_analysis_2010\cKitPos LinNeg\greenred';
outputfolder = 'C:\Users\tklee.WIN\research\reya_image_analysis_2010\cKitPos LinNeg\output';

% pattern for particle images
filebase = '*ch01.tif';

% pattern for reference background image
refbase = '*ch00.tif';

% osteo labeled
osteofile = 'C:\Users\tklee.WIN\research\reya_image_analysis_2010\cKitPos LinNeg\Lin-_cKit_8gfp_110408_osteo.tiff';

% vascular labeled
vascularfile = 'C:\Users\tklee.WIN\research\reya_image_analysis_2010\cKitPos LinNeg\Lin-_cKit_8gfp_110408_vessels.tiff';

% outputfilename
outputbase = 'cKitPosLinNeg';

% number of images to analyze
numFrames = 10;

% image parameters
pixelsize = .757;
timestep = 10.48;

% tracking parameters
memory = 100;
min_good_length = 10;
suppress_msgs = 1;
dimension = 2;
max_dist_travel = 25;

% segmentation parameters
filtersize = 5;
threshlevel = 6;
min_size = 10;

refthreshlevel = 20;
smoothsize = 2;

% image display parameters
imlimits = [0 10];

 
%% load into parameters struct (no need to edit)
fileinfo.inputfolder = inputfolder;
fileinfo.filebase = filebase;
fileinfo.outputfolder = outputfolder;
fileinfo.refbase = refbase;
fileinfo.numFrames = numFrames;
fileinfo.outputbase = outputbase;
fileinfo.osteofile = osteofile;
fileinfo.vascularfile = vascularfile;
fileinfo.pixelsize = pixelsize;
fileinfo.timestep = timestep;

param.mem = memory;
param.good = min_good_length;
param.quiet = suppress_msgs;
param.dim = dimension;
param.dist = max_dist_travel;

param.filtersize = filtersize;
param.threshlevel = threshlevel;
param.min_size = min_size;
param.refthreshlevel = refthreshlevel;
param.smoothsize = smoothsize;
param.imlimits = imlimits;

% %% parallel computing
% matlabpool(4)

%% run the code
trackCells(fileinfo,param)

% %% parallel cmoputing
% matlabpool close

