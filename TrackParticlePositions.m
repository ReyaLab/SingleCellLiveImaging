function TrackParticlePositions(positionmatfile,trackmatfile,param,...
    pixelsize,timestep)

load(positionmatfile)
tr = track(positions,param.dist,param);

numtracks = length(unique(tr(:,4)));
tracklengths = zeros(numtracks,1);
for j=1:numtracks
    tracklengths(j) = sum(tr(:,4)==j);
end

% rearrange into a more understandable format
tracks = cell(numtracks,1);
for j = 1:numtracks
    tracks{j} = tr(tr(:,4)==j,1:3);
end

% interpolate between points for tracking and calculate approx velocities
% also fix the time scaling
int_tracks = cell(numtracks,1);
int_tr = [];
for j = 1:numtracks
    x = tracks{j}(:,1);
    y = tracks{j}(:,2);
    t = tracks{j}(:,3);
    ti = t(1):t(end);
    ti = ti';
    xi = interp1(t,x,ti);
    yi = interp1(t,y,ti);
    ti = ti; % ugly, need to fix later
    vi = pixelsize*sqrt(diff(xi).^2+diff(yi).^2)./diff(ti)/timestep;
    vi = cat(1,vi,[0]);
    di = pixelsize*sqrt((xi-xi(1)).^2+(yi-yi(1)).^2);
    int_tracks{j} = [xi,yi,timestep*ti,di,vi];
    int_tr = cat(1,int_tr,[xi,yi,ti,j*ones(length(xi),1),di,vi]);
end

save(trackmatfile,'tr','tracks','int_tr','int_tracks')