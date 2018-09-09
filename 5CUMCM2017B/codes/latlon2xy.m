function [x,y] = latlon2xy(lat, lon, lonlimit)
% Project Latitude and Longitude to x-y coordinates 
% ww2.mathworks.cn/help/map/project-coordinates-without-map-axes.html
%

if nargin==0
    data = load('data/Appendix-I.dat'); 
    lat = data(:,2);lon = data(:,3); 
end

if nargin<3
    lonlimit = [112.4, 114.6];
end

mstruct = defaultm('sinusoid');
mstruct.maplonlimit = lonlimit; %[112.4, 114.6];

mstruct.geoid = referenceEllipsoid('grs80','kilometers');
mstruct = defaultm(mstruct);
[x,y] = mfwdtran(mstruct,lat,lon);

if nargin==0
    subplot(1,2,1); plot(lon,lat,'o'); xlabel(   'lon'); ylabel(   'lat');
    subplot(1,2,2); plot(  x,  y,'o'); xlabel('x (km)'); ylabel('y (km)');
end