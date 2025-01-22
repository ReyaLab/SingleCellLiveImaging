function outputimage = MedFilterRead(inputname, medfiltsize)

inputimage = imread(inputname);
outputimage = medfilt2(inputimage,medfiltsize*ones(1,2),'symmetric');
