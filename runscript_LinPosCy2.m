
clear all
close all

%% specify these parameters
% folder names
inputfolder = 'C:\Users\tklee.WIN\research\reya_image_analysis_2010\injury movies\Lin_pos_Cy_2\Lin pos Cy 2';
outputfolder = 'C:\Users\tklee.WIN\research\reya_image_analysis_2010\injury movies\output\Lin pos Cy 2';

% inputfolder = 'C:\Users\tklee\Documents\research\reya_image_analysis\Exports Lin neg GFP 2\';
% outputfolder = 'C:\Users\tklee\Documents\research\reya_image_analysis\ouputLinNegGFP';

% pattern for particle images
filebase = '*ch00.tif';

% pattern for reference background image
refbase = '*ch01.tif';

% osteo labeled
osteofile = 'C:\Users\tklee.WIN\research\reya_image_analysis_2010\injury movies\Annotations\Lin pos Cy 2 osteo.tif';

% vascular labeled
vascularfile = 'C:\Users\tklee.WIN\research\reya_image_analysis_2010\injury movies\Annotations\Lin pos Cy 2 vascular.tif';

% outputfilename
outputbase = 'LinPosCy2';

% number of images to analyze
numFrames = 960;

% image parameters
pixelsize = .72;
timestep = 5.628;

% tracking parameters
memory = 100;
min_good_length = 10;
suppress_msgs = 1;
dimension = 2;
max_dist_travel = 20;

% segmentation parameters
filtersize = 10;
threshlevel = 12;
min_size = 5;

refthreshlevel = 20;
smoothsize = 2;

% image display parameters
imlimits = [0 50];

 
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

