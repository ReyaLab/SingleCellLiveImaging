outputfolder = '/Users/tklee/Desktop/reya lab/reya_image_analysis/code/';

Lin = load(fullfile(outputfolder,'allCells.mat'));


for j=1:numel(Lin.cells);
    Lin.cells(j).vascularContactFreq = sum(Lin.cells(j).vascularContact)/length(Lin.cells(j).vascularContact);
    Lin.cells(j).vascularContactDuration = sum(Lin.cells(j).vascularContact);
    Lin.cells(j).osteoContactFreq = sum(Lin.cells(j).osteoContact)/length(Lin.cells(j).osteoContact);
    Lin.cells(j).osteoContactDuration = sum(Lin.cells(j).osteoContact);
    Lin.cells(j).vascularProximalFreq = sum(Lin.cells(j).vascularProximal)/length(Lin.cells(j).vascularProximal);
    Lin.cells(j).vascularProximalDuration = sum(Lin.cells(j).vascularProximal);
    Lin.cells(j).osteoProximalFreq = sum(Lin.cells(j).osteoProximal)/length(Lin.cells(j).osteoProximal);
    Lin.cells(j).osteoProximalDuration = sum(Lin.cells(j).osteoProximal);    
end
LinPos = Lin.cells([Lin.cells.lineage]==1);
LinNeg = Lin.cells([Lin.cells.lineage]==-1);


KLS = load(fullfile(outputfolder,'allCellsKLS.mat'));

for j=1:numel(KLS.cells);
    KLS.cells(j).vascularContactFreq = sum(KLS.cells(j).vascularContact)/length(KLS.cells(j).vascularContact);
    KLS.cells(j).vascularContactDuration = sum(KLS.cells(j).vascularContact);
    KLS.cells(j).osteoContactFreq = sum(KLS.cells(j).osteoContact)/length(KLS.cells(j).osteoContact);
    KLS.cells(j).osteoContactDuration = sum(KLS.cells(j).osteoContact);
    KLS.cells(j).vascularProximalFreq = sum(KLS.cells(j).vascularProximal)/length(KLS.cells(j).vascularProximal);
    KLS.cells(j).vascularProximalDuration = sum(KLS.cells(j).vascularProximal);
    KLS.cells(j).osteoProximalFreq = sum(KLS.cells(j).osteoProximal)/length(KLS.cells(j).osteoProximal);
    KLS.cells(j).osteoProximalDuration = sum(KLS.cells(j).osteoProximal);    
end

KLS = [KLS.cells];

%%
fid = fopen('figure5stats.txt','w');

fprintf(fid,'Celltype\tNiche\tClassification\tMean\tStdDev\tStdErr\tNumCells\n')

% LinPos

fprintf(fid,'%s\t%s\t%s\t%0.4f\t%0.4f\t%0.4f\t%g\n', ...
    'LinPos', ...
    'Vascular', ...
    'Contact', ...
    mean([LinPos.vascularContactFreq]),...
    std([LinPos.vascularContactFreq]),...
    std([LinPos.vascularContactFreq])/sqrt(numel(LinPos)),...
    numel(LinPos));

fprintf(fid,'%s\t%s\t%s\t%0.4f\t%0.4f\t%0.4f\t%g\n', ...
    'LinPos', ...
    'Endosteal', ...
    'Contact', ...
    mean([LinPos.osteoContactFreq]),...
    std([LinPos.osteoContactFreq]),...
    std([LinPos.osteoContactFreq])/sqrt(numel(LinPos)),...
    numel(LinPos));
fprintf(fid,'%s\t%s\t%s\t%0.4f\t%0.4f\t%0.4f\t%g\n', ...
    'LinPos', ...
    'Vascular', ...
    'Proximal', ...
    mean([LinPos.vascularProximalFreq]),...
    std([LinPos.vascularProximalFreq]),...
    std([LinPos.vascularProximalFreq])/sqrt(numel(LinPos)),...
    numel(LinPos));

fprintf(fid,'%s\t%s\t%s\t%0.4f\t%0.4f\t%0.4f\t%g\n', ...
    'LinPos', ...
    'Endosteal', ...
    'Proximal', ...
    mean([LinPos.osteoProximalFreq]),...
    std([LinPos.osteoProximalFreq]),...
    std([LinPos.osteoProximalFreq])/sqrt(numel(LinPos)),...
    numel(LinPos));
    
% Lin Neg

fprintf(fid,'%s\t%s\t%s\t%0.4f\t%0.4f\t%0.4f\t%g\n', ...
    'LinNeg', ...
    'Vascular', ...
    'Contact', ...
    mean([LinNeg.vascularContactFreq]),...
    std([LinNeg.vascularContactFreq]),...
    std([LinNeg.vascularContactFreq])/sqrt(numel(LinNeg)),...
    numel(LinNeg));

fprintf(fid,'%s\t%s\t%s\t%0.4f\t%0.4f\t%0.4f\t%g\n', ...
    'LinNeg', ...
    'Endosteal', ...
    'Contact', ...
    mean([LinNeg.osteoContactFreq]),...
    std([LinNeg.osteoContactFreq]),...
    std([LinNeg.osteoContactFreq])/sqrt(numel(LinNeg)),...
    numel(LinNeg));

fprintf(fid,'%s\t%s\t%s\t%0.4f\t%0.4f\t%0.4f\t%g\n', ...
    'LinNeg', ...
    'Vascular', ...
    'Proximal', ...
    mean([LinNeg.vascularProximalFreq]),...
    std([LinNeg.vascularProximalFreq]),...
    std([LinNeg.vascularProximalFreq])/sqrt(numel(LinNeg)),...
    numel(LinNeg));

fprintf(fid,'%s\t%s\t%s\t%0.4f\t%0.4f\t%0.4f\t%g\n', ...
    'LinNeg', ...
    'Endosteal', ...
    'Proximal', ...
    mean([LinNeg.osteoProximalFreq]),...
    std([LinNeg.osteoProximalFreq]),...
    std([LinNeg.osteoProximalFreq])/sqrt(numel(LinNeg)),...
    numel(LinNeg));

% KLS


fprintf(fid,'%s\t%s\t%s\t%0.4f\t%0.4f\t%0.4f\t%g\n', ...
    'KLS', ...
    'Vascular', ...
    'Contact', ...
    mean([KLS.vascularContactFreq]),...
    std([KLS.vascularContactFreq]),...
    std([KLS.vascularContactFreq])/sqrt(numel(KLS)),...
    numel(KLS));

fprintf(fid,'%s\t%s\t%s\t%0.4f\t%0.4f\t%0.4f\t%g\n', ...
    'KLS', ...
    'Endosteal', ...
    'Contact', ...
    mean([KLS.osteoContactFreq]),...
    std([KLS.osteoContactFreq]),...
    std([KLS.osteoContactFreq])/sqrt(numel(KLS)),...
    numel(KLS));

fprintf(fid,'%s\t%s\t%s\t%0.4f\t%0.4f\t%0.4f\t%g\n', ...
    'KLS', ...
    'Vascular', ...
    'Proximal', ...
    mean([KLS.vascularProximalFreq]),...
    std([KLS.vascularProximalFreq]),...
    std([KLS.vascularProximalFreq])/sqrt(numel(KLS)),...
    numel(KLS));

fprintf(fid,'%s\t%s\t%s\t%0.4f\t%0.4f\t%0.4f\t%g\n', ...
    'KLS', ...
    'Endosteal', ...
    'Proximal', ...
    mean([KLS.osteoProximalFreq]),...
    std([KLS.osteoProximalFreq]),...
    std([KLS.osteoProximalFreq])/sqrt(numel(KLS)),...
    numel(KLS));
    
fclose(fid)
    
