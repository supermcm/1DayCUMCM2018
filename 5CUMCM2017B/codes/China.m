function data = China(type, isplot)
% PLOTCHINA
% h = PLOTCHINA draw the map of China, and return the 

if nargin==0; type ='4cities'; end
if nargin<=1; isplot = 1;      end

switch type
    case {0,'outline'}; 
        load('data/china.mat'); 
        data = [];
        if ~isplot; return; end
        plot(province.long, province.lat, 'color', [0.7,0.7,0.7])
        hold on
        plot(border.long  , border.lat  , 'color', [0.5,0.5,0.5], 'linewidth', 1.5);
        % plot a NaN route, and global the handle h.
        h = plot(NaN, NaN, 'b-', 'linewidth', 1);
        xlabel('Longitude'); ylabel('Latitude')
        
    case {1,'4cities'}
        lat = [113.2600  114.0600  113.7500  113.1200];
        lon = [ 23.1300   22.5400   23.0200   23.0200];
        name= {'Guangzhou','Shenzhen', 'Dongguan', 'Foshan'};
        [x, y] = latlon2xy(lat, lon);
        for i = 1:length(name)
           data(i) = struct('name',name{i}, 'lat', lat(i), 'lon', lon(i),...
                             'x', x(i), 'y', y(i)); 
        end
        
        if ~isplot; return; end 
        mark = {'ro', 'rx', 'r+','r<'};
        for i = 1:4
            h(i) = plot(lat(i),lon(i),mark{i},'markersize',8,'linewidth',2);hold on
        end
        legend(h, name);
end



