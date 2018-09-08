proj = load('data/2.dat');
proj = [zeros(200,180); proj; zeros(200,180)];
img = iradon(proj,[0:179]);
bw = im2bw(img,0.2);
[L,W] = size(bw);
imagesc(bw); axis image


ellipses = regionprops(bw, 'MajorAxisLength', 'MinorAxisLength', ...
                           'Orientation', 'Centroid', 'area');
hold on

phi = linspace(0,2*pi,50);
cosphi = cos(phi);
sinphi = sin(phi);

for k = 1:length(ellipses)
    xbar = ellipses(k).Centroid(1);
    ybar = ellipses(k).Centroid(2);

    a = ellipses(k).MajorAxisLength/2;
    b = ellipses(k).MinorAxisLength/2;

    theta = ellipses(k).Orientation;
    
    R = [ cosd(theta)   sind(theta)
         -sind(theta)   cosd(theta)];

    xy = [a*cosphi; b*sinphi];
    xy = R*xy;

    x = xy(1,:) + xbar;
    y = xy(2,:) + ybar;

    plot(xbar,ybar, 'ok', x,y,'r','LineWidth',2);
end

xc = W/2; yc = L/2;
xo = ellipses(1).Centroid(1); yo = ellipses(1).Centroid(2);
plot(xc, yc,'xw');
d = 80/ellipses(1).MajorAxisLength;
c = [xc, yc] - ellipses(1).Centroid;
t = - (pi - ellipses(1).Orientation/180*pi);
dx = (cos(t)*c(1) - sin(t)*c(2))*d;
dy = (sin(t)*c(1) + cos(t)*c(2))*d;

xb0 = 50*[-1 -1  1  1 -1]/d + xo;
yb0 = 50*[-1  1  1 -1 -1]/d + yo;

[xb, yb] = rotxyd(xb0, yb0, xo, yo, ellipses(1).Orientation)

plot(xb,yb,'r')

% -------------------------------------------------------------------------

function [x, y] = rotxyd(x0, y0, xc, yc, deg)
x = (x0-xc)*cosd(-deg) - (y0-yc)*sind(-deg) + xc; 
y = (x0-xc)*sind(-deg) + (y0-yc)*cosd(-deg) + yc;
end