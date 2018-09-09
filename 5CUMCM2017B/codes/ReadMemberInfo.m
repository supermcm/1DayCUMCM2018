function mbrs = ReadMemberInfo(isplot)

if nargin==0; isplot = 1; end

data   = load('data/Appendix-II.dat');
id     = data(:,1);
lat    = data(:,2); lon    = data(:,3); [x, y] = latlon2xy(lat,lon);
quota  = data(:,4); time   = data(:,5); credit = data(:,6);

for i = 1:length(id)
    mbrs(i) = struct('lat',lat(i), 'lon',lon(i), 'x',x(i), 'y',y(i), ...
                     'quota',quota(i), 'time',time(i), 'credit',credit);
end

% -------------------------------------------------------------------------

if ~isplot; return; end

China('outline');
[~, lonmin1, lonmax1, latmin1, latmax1] = ReadFinishedProj(0);
[~, lonmin2, lonmax2, latmin2, latmax2] = ReadNewProj(0);

lonmin = min(lonmin1, lonmin2); lonmax = max(lonmax1, lonmax2);
latmin = min(latmin1, latmin2); latmax = max(latmax1, latmax2);

scatter(lon,lat,500*quota/max(quota),credit,'filled'); colorbar

plot([lonmin lonmax lonmax lonmin lonmin], ...
     [latmin latmin latmax latmax latmin],'r')
 
China('4cities');

xmin = lonmin-(lonmax-lonmin)/5; xmax = lonmax+(lonmax-lonmin)/5;
ymin = latmin-(latmax-latmin)/5; ymax = latmax+(latmax-latmin)/5;
axis([xmin,xmax,ymin,ymax])