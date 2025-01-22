%% excel file

outputfolder = 'C:\Users\tklee.WIN\research\reya_image_analysis_2010\output';
excelfile = 'MWC Reya Data Extraction.xlsx';

%% fix lin pos
sheetName = 'Lin Pos 101007'
[num,txt,raw] = xlsread(fullfile(outputfolder,excelfile),sheetName);

times = num(:,1);
frames = (1:length(times))';
numCells = (size(num,2)-1)/6;
% arrange data back into int_tracks_osteovascular

int_tracks_raw = cell(numCells,1);
for j = 1:numCells
    int_tracks_raw{j} = num(:,2+6*(j-1):7+6*(j-1));
end
int_tracks_osteovascular = cell(numCells,1);
hasGaps = false(numCells,1);
for j = 1:numCells
    goodValues = ~isnan(int_tracks_raw{j}(:,1));
    first = min(find(goodValues));
    last = max(find(goodValues));
    int_tracks_osteovascular{j} = [frames(first:last),times(first:last),int_tracks_raw{j}(first:last,:)];
    hasGaps(j) = sum(isnan(int_tracks_osteovascular{j}(:,end)))>0;
end

osteofile = 'C:\Users\tklee.WIN\research\reya_image_analysis_2010\annotations\cleaned annotations\101007 VeCad Lin+ Osteo.tif';
vascularfile = 'C:\Users\tklee.WIN\research\reya_image_analysis_2010\annotations\cleaned annotations\101007 VeCad Lin+ Vessels.tif';
pixelsize = .7215;
timestep = 10.24;

for j = find(hasGaps)'
    trackarray = int_tracks_osteovascular{j};
    newtrackarray = GetDistOsteoVascularFix(trackarray,pixelsize,timestep,osteofile,vascularfile);
    int_tracks_osteovascular{j} = newtrackarray;
end

save(fullfile(outputfolder,[sheetName, ' final']),'int_tracks_osteovascular')

%% fix Exports Lin neg GFP 2
sheetName = 'Exports Lin neg GFP 2';
[num,txt,raw] = xlsread(fullfile(outputfolder,excelfile),sheetName);


times = num(:,1);
frames = (1:length(times))';
numCells = (size(num,2)-1)/6;
% arrange data back into int_tracks_osteovascular

int_tracks_raw = cell(numCells,1);
int_tracks_osteovascular = cell(numCells,1);
for j = 1:numCells
    int_tracks_raw{j} = num(:,2+6*(j-1):7+6*(j-1));
end
hasGaps = false(numCells,1);
for j = 1:numCells
    goodValues = ~isnan(int_tracks_raw{j}(:,1));
    first = min(find(goodValues));
    last = max(find(goodValues));
    int_tracks_osteovascular{j} = [frames(first:last),times(first:last),int_tracks_raw{j}(first:last,:)];
    hasGaps(j) = sum(isnan(int_tracks_osteovascular{j}(:,end)))>0;
end

osteofile = 'C:\Users\tklee.WIN\research\reya_image_analysis_2010\annotations\cleaned annotations\090207 Normal Lin- Osteo.tif';
vascularfile = 'C:\Users\tklee.WIN\research\reya_image_analysis_2010\annotations\cleaned annotations\090207 Normal Lin- Vessels.tif';
pixelsize = .775;
timestep = 10.36;

for j = find(hasGaps)'
    trackarray = int_tracks_osteovascular{j};
    newtrackarray = GetDistOsteoVascularFix(trackarray,pixelsize,timestep,osteofile,vascularfile);
    int_tracks_osteovascular{j} = newtrackarray;
end


save(fullfile(outputfolder,[sheetName, ' final']),'int_tracks_osteovascular')

%% fix osteo 650
sheetName = 'Osteosense 650 TPs 100927';
[num,txt,raw] = xlsread(fullfile(outputfolder,excelfile),sheetName);


times = num(:,1);
frames = (1:length(times))';
numCells = (size(num,2)-1)/6;
% arrange data back into int_tracks_osteovascular

int_tracks_raw = cell(numCells,1);
int_tracks_osteovascular = cell(numCells,1);
for j = 1:numCells
    int_tracks_raw{j} = num(:,2+6*(j-1):7+6*(j-1));
end
hasGaps = false(numCells,1);
for j = 1:numCells
    goodValues = ~isnan(int_tracks_raw{j}(:,1));
    first = min(find(goodValues));
    last = max(find(goodValues));
    int_tracks_osteovascular{j} = [frames(first:last),times(first:last),int_tracks_raw{j}(first:last,:)];
    hasGaps(j) = sum(isnan(int_tracks_osteovascular{j}(:,end)))>0;
end

osteofile = 'C:\Users\tklee.WIN\research\reya_image_analysis_2010\annotations\cleaned annotations\100927 Osteosense Lin- 650TPs Osteo.tif';
vascularfile = 'C:\Users\tklee.WIN\research\reya_image_analysis_2010\annotations\cleaned annotations\100927 Osteosense Lin- 650TPs Vessels.tif';
pixelsize = 1.443;
timestep = 10.24;

for j = find(hasGaps)'
    trackarray = int_tracks_osteovascular{j};
    newtrackarray = GetDistOsteoVascularFix(trackarray,pixelsize,timestep,osteofile,vascularfile);
    int_tracks_osteovascular{j} = newtrackarray;
end


save(fullfile(outputfolder,[sheetName, ' final']),'int_tracks_osteovascular')

%% F480 1
sheetName = 'F480 1 100910'
[num,txt,raw] = xlsread(fullfile(outputfolder,excelfile),sheetName);

times = num(:,1);
frames = (1:length(times))';
numCells = (size(num,2)-1)/6;
% arrange data back into int_tracks_osteovascular

int_tracks_raw = cell(numCells,1);
for j = 1:numCells
    int_tracks_raw{j} = num(:,2+6*(j-1):7+6*(j-1));
end
int_tracks_osteovascular = cell(numCells,1);
for j = 1:numCells
    goodValues = ~isnan(int_tracks_raw{j}(:,1));
    first = min(find(goodValues));
    last = max(find(goodValues));
    int_tracks_osteovascular{j} = [frames(first:last),times(first:last),int_tracks_raw{j}(first:last,:)];
end
save(fullfile(outputfolder,[sheetName, ' final']),'int_tracks_osteovascular')


%% F480 2
sheetName = 'F480 2'
[num,txt,raw] = xlsread(fullfile(outputfolder,excelfile),sheetName);

times = num(:,1);
frames = (1:length(times))';
numCells = (size(num,2)-1)/6;
% arrange data back into int_tracks_osteovascular

int_tracks_raw = cell(numCells,1);
for j = 1:numCells
    int_tracks_raw{j} = num(:,2+6*(j-1):7+6*(j-1));
end
int_tracks_osteovascular = cell(numCells,1);
for j = 1:numCells
    goodValues = ~isnan(int_tracks_raw{j}(:,1));
    first = min(find(goodValues));
    last = max(find(goodValues));
    int_tracks_osteovascular{j} = [frames(first:last),times(first:last),int_tracks_raw{j}(first:last,:)];
end
save(fullfile(outputfolder,[sheetName, ' final']),'int_tracks_osteovascular')


%% Osteosense Exports
sheetName = 'Osteosense Exports'
[num,txt,raw] = xlsread(fullfile(outputfolder,excelfile),sheetName);

times = num(:,1);
frames = (1:length(times))';
numCells = (size(num,2)-1)/6;
% arrange data back into int_tracks_osteovascular

int_tracks_raw = cell(numCells,1);
for j = 1:numCells
    int_tracks_raw{j} = num(:,2+6*(j-1):7+6*(j-1));
end
int_tracks_osteovascular = cell(numCells,1);
for j = 1:numCells
    goodValues = ~isnan(int_tracks_raw{j}(:,1));
    first = min(find(goodValues));
    last = max(find(goodValues));
    int_tracks_osteovascular{j} = [frames(first:last),times(first:last),int_tracks_raw{j}(first:last,:)];
end
save(fullfile(outputfolder,[sheetName, ' final']),'int_tracks_osteovascular')


%% VE Cadherin Exports
sheetName = 'VE Cadherin Exports'
[num,txt,raw] = xlsread(fullfile(outputfolder,excelfile),sheetName);

times = num(:,1);
frames = (1:length(times))';
numCells = (size(num,2)-1)/6;
% arrange data back into int_tracks_osteovascular

int_tracks_raw = cell(numCells,1);
for j = 1:numCells
    int_tracks_raw{j} = num(:,2+6*(j-1):7+6*(j-1));
end
int_tracks_osteovascular = cell(numCells,1);
for j = 1:numCells
    goodValues = ~isnan(int_tracks_raw{j}(:,1));
    first = min(find(goodValues));
    last = max(find(goodValues));
    int_tracks_osteovascular{j} = [frames(first:last),times(first:last),int_tracks_raw{j}(first:last,:)];
end
save(fullfile(outputfolder,[sheetName, ' final']),'int_tracks_osteovascular')

%% Orig Long Full
sheetName = 'Orig Long Full'
[num,txt,raw] = xlsread(fullfile(outputfolder,excelfile),sheetName);

times = num(:,1);
frames = (1:length(times))';
numCells = (size(num,2)-1)/6;
% arrange data back into int_tracks_osteovascular

int_tracks_raw = cell(numCells,1);
for j = 1:numCells
    int_tracks_raw{j} = num(:,2+6*(j-1):7+6*(j-1));
end
int_tracks_osteovascular = cell(numCells,1);
for j = 1:numCells
    goodValues = ~isnan(int_tracks_raw{j}(:,1));
    first = min(find(goodValues));
    last = max(find(goodValues));
    int_tracks_osteovascular{j} = [frames(first:last),times(first:last),int_tracks_raw{j}(first:last,:)];
end
save(fullfile(outputfolder,[sheetName, ' final']),'int_tracks_osteovascular')

%% VEcad 100917
sheetName = 'VEcad 100917'
[num,txt,raw] = xlsread(fullfile(outputfolder,excelfile),sheetName);

times = num(:,1);
frames = (1:length(times))';
numCells = (size(num,2)-1)/6;
% arrange data back into int_tracks_osteovascular

int_tracks_raw = cell(numCells,1);
for j = 1:numCells
    int_tracks_raw{j} = num(:,2+6*(j-1):7+6*(j-1));
end
int_tracks_osteovascular = cell(numCells,1);
for j = 1:numCells
    goodValues = ~isnan(int_tracks_raw{j}(:,1));
    first = min(find(goodValues));
    last = max(find(goodValues));
    int_tracks_osteovascular{j} = [frames(first:last),times(first:last),int_tracks_raw{j}(first:last,:)];
end
save(fullfile(outputfolder,[sheetName, ' final']),'int_tracks_osteovascular')