function [projs, lonmin, lonmax, latmin, latmax] = ReadNewProj(isplot)

if nargin==0; isplot = 1; end

data   = load('data/Appendix-III.dat');
id     = data(:,1);
lat    = data(:,2); lon    = data(:,3); [x, y] = latlon2xy(lat,lon);
lonmin = min(lon); lonmax = max(lon); latmin = min(lat); latmax = max(lat);

for i = 1:length(id)
    projs(i) = struct('lat',lat(i), 'lon',lon(i), 'x',x(i), 'y',y(i));
end

% -------------------------------------------------------------------------

if ~isplot; return; end

China('outline'); 
plot(lon, lat, '.b', 'markersize', 10)
China('4cities');
xmin = lonmin-(lonmax-lonmin)/5; xmax = lonmax+(lonmax-lonmin)/5;
ymin = latmin-(latmax-latmin)/5; ymax = latmax+(latmax-latmin)/5;
axis([xmin,xmax,ymin,ymax])