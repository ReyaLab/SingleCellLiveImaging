% run Osteo
clear all
close all

%% specify these parameters
% folder names
% inputfolder = 'C:\Users\tklee.WIN\research\reya_image_analysis_2010\VEcad 100917';
% outputfolder = 'C:\Users\tklee.WIN\research\reya_image_analysis_2010\output\VEcad 100917';

inputfolder = '/Users/tklee/image_data_temp/KLS Area 3/input';
outputfolder = '/Users/tklee/image_data_temp/KLS Area 3/output';

% pattern for particle images
filebase = '*ch01.tif';

% pattern for reference background image
refbase = '*ch00.tif';

% osteo labeled
osteofile = '/Users/tklee/image_data_temp/KLS Area 3/KLS_area3_osteo.tif';

% vascular labeled
vascularfile = '/Users/tklee/image_data_temp/KLS Area 3/KLS_area3_vasc.tif';

% outputfilename
outputbase = 'KLS_area3';

% number of images to analyze
numFrames = 693;

% image parameters
pixelsize = 0.72;
timestep = 10.38;

% tracking parameters
memory = 100;
min_good_length = 50;
suppress_msgs = 1;
dimension = 2;
max_dist_travel = 20;

% segmentation parameters
filtersize = 10;
threshlevel = 17;
min_size = 10;

refthreshlevel = 20;
smoothsize = 2;

% image display parameters
imlimits = [16 45];

 
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

