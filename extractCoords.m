load('allCells.mat')

outfolder = 'coords';

for c = 1:numel(cells);
    fname = [outfolder '/' cells(c).expt ' cell ' sprintf('%02d',cells(c).ID) '.txt'];
    fid = fopen(fname,'wt+');
    fprintf(fid,'t\tx\ty\n');
    for t=1:numel(cells(c).times)
        fprintf(fid,'%g\t%g\t%g\n',cells(c).times(t),cells(c).xSmooth(t),...
            cells(c).ySmooth(t));
    end
    fclose(fid);
end
    