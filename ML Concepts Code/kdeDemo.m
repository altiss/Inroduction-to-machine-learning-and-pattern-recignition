function out = kdeDemo(in)
close all,
out = NaN;

N = 100; 
s = 0.05; % kernel width parameter
x = rand(1,N); % data samples
xGrid = linspace(-1,2,1001); % evaluate KDE at these points
kx = kernel(xGrid,x,s);
pKDE = mean(kx,2)';

figure(1),
plot(xGrid,pKDE,'.'), axis equal,

function kx = kernel(xGrid,x,s)
pD = pdist2(xGrid',x','euclidean');
kx = exp(-(pD/s).^2)/sqrt(2*pi*s^2);