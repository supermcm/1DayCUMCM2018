function bd = projbd(phi)
% ELLIPSEPROJBD Boundary of ellipse projection
%
% zhou lvwen: zhou.lv.wen@gmail.com
% September 18, 2017

if nargin ==0; phi = 0:180; end

a = 15; b = 40;
d = 0.2768;
xc0 = -33.5*d; yc0 = 20*d;    % rotation center on square pallet

% pallet
xb0 = 50*[-1 -1  1  1 -1] - xc0;
yb0 = 50*[-1  1  1 -1 -1] - yc0;
hb = fill(xb0, yb0, [0.9 0.9 0.9]); hold on

% ellipse
t = [0:pi/36:2*pi]';
xe0 = a*cos(t) - xc0;
ye0 = b*sin(t) - yc0;
he = fill(xe0, ye0, [1,0.8,0.8]);

% circle
xo0 = 4*cos(t) + 45 - xc0;
yo0 = 4*sin(t) - yc0;
ho = fill(xo0, yo0, [0.8,0.8,1]);

% boundary
xemin = -xc0 - a; xemax = -xc0 + a; yemin = -yc0 - b; yemax = -yc0 + b;
hd = plot([xemin xemax; xemin xemax], [-90;90],'r--', ...
          [-90;90], [yemin yemax; yemin yemax],'r--')
set(gca,'xtick',[-90,xemin,xemax,90], 'ytick',[-90,yemin,yemax,90]);

hc = plot(-xc0,-yc0,'+r','markersize',15);
plot(0,0,'.b','markersize',15)
axis image; axis([-90 90 -90 90])

for deg = phi
    [xb, yb] = rotxyd(xb0,yb0, 0,0, deg); set(hb,'xdata',xb, 'ydata', yb);
    [xe, ye] = rotxyd(xe0,ye0, 0,0, deg); set(he,'xdata',xe, 'ydata', ye);
    [xo, yo] = rotxyd(xo0,yo0, 0,0, deg); set(ho,'xdata',xo, 'ydata', yo);
    [xc, yc] = rotxyd(xc0,yc0, 0,0, deg); set(hc,'xdata',-xc, 'ydata', -yc);
    xemax =  sqrt(  (a*cosd(-deg))^2 + (b*sind(-deg))^2) - xc;
    xemin = -sqrt(  (a*cosd(-deg))^2 + (b*sind(-deg))^2) - xc;
    yemax =  sqrt(  (a*sind(-deg))^2 + (b*cosd(-deg))^2) - yc;
    yemin = -sqrt(  (a*sind(-deg))^2 + (b*cosd(-deg))^2) - yc;
    set(hd(1), 'xdata', [xemin,xemin], 'ydata', [-90,90])
    set(hd(2), 'xdata', [xemax,xemax], 'ydata', [-90,90])
    set(hd(3), 'ydata', [yemin,yemin], 'xdata', [-90,90])
    set(hd(4), 'ydata', [yemax,yemax], 'xdata', [-90,90])
    set(gca,'xtick',[-90,xemin,xemax,90], 'ytick',[-90,yemin,yemax,90]);
    drawnow
end

% -------------------------------------------------------------------------

function [x, y] = rotxyd(x0, y0, xc, yc, deg)
x = (x0-xc)*cosd(-deg) - (y0-yc)*sind(-deg); 
y = (x0-xc)*sind(-deg) + (y0-yc)*cosd(-deg);