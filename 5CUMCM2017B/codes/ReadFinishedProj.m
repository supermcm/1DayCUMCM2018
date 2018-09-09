function [projs, lonmin,lonmax,latmin,latmax] = ReadFinishedProj(isplot)

if nargin==0; isplot = 1; end
data   = load('data/Appendix-I.dat');

id     = data(:,1); 
lat    = data(:,2);  lon    = data(:,3);  [x, y] = latlon2xy(lat,lon);


price  = data(:,4);  status = logical(data(:,5));

lonmin = min(lon); lonmax = max(lon); latmin = min(lat); latmax = max(lat);

for i = 1:length(id)
    projs(i) = struct('lat',lat(i), 'lon',lon(i), 'x',x(i), 'y',y(i), ...
                      'price',price(i), 'status',status(i));
end

% -------------------------------------------------------------------------

if ~isplot; return; end

figure('position',[200,200,1600,500])

subplot(1,2,1)
China('outline'); hold on
plot([lonmin lonmax lonmax lonmin lonmin], ...
     [latmin latmin latmax latmax latmin],'r')
axis([70 140 15 55]);

subplot(1,2,2)
China('outline'); hold on
scatter(lon,lat,(status+0.5)*20,price,'filled')
colorbar;
plot([lonmin lonmax lonmax lonmin lonmin], ...
     [latmin latmin latmax latmax latmin],'r')
China('4cities');
xmin = lonmin-(lonmax-lonmin)/20; xmax = lonmax+(lonmax-lonmin)/20;
ymin = latmin-(latmax-latmin)/20; ymax = latmax+(latmax-latmin)/20;
axis([xmin, xmax, ymin, ymax])