function flybyplot(planet, rp, finf, vinf)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
pl = solarSystemConstants(planet);
mu = pl.mu;
Rpl = pl.R; % planet radius
% Generate 100 points b/w -finf and finf
% (careful, b/c numbers explode at finf)
f = linspace(-finf, finf, 100);
% We'll need these:
e = 1 + rp*vinf^2/mu;
a = -mu/2 / (vinf^2/2);
% And then, use the orbit eqn (normalize by planet radii)
r = a*(1-e^2) ./ (1 + e*cos(f)) / Rpl;
x_orb = r.*cos(f);
y_orb = r.*sin(f);
% Now, plot the planet radius and the orbit
theta = linspace(0, 2*pi, 100);
x_pl = cos(theta);
y_pl = sin(theta);
plot(x_pl, y_pl, x_orb, y_orb);
title('Flyby Plot')
units = sprintf('(%s radii)', [upper(planet(1)) planet(2:end)]);
ylabel(['Y Distance ' units]);
xlabel(['X Distance ' units]);
axis equal
xlim([-6 6])
end

