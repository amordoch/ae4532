function [xfer] = idealInterplanetaryTransfer(src, dest, rp1, rp2)
%idealInterplanetaryTransfer Calculate the magnitude of the delta V 
%requirement for an interplanetary Hohmann transfer, assuming no 
%inclination difference and circular orbits.
%   INPUTS:
%       src: source body
%       dest: destination body
%       rp1: radius of initial parking orbit
%       rp2: radius of final parking orbit
%   OUTPUTS:
%       xfer: struct with fields
%           dV: overall delta V (m/s)
%           dV_1: departure delta V (m/s)
%           dV_2: arrival delta V (m/s)
%           f_inf: ejection angle (deg)
%           phaseAngle: phase angle (deg)
%           T_syn: synodic period (years)
%           dt: transfer time (days)

% NOTATION: 1 = src, 2 = dest
% Get constants for source, destination, and sun
src = [upper(src(1)) lower(src(2:end))];
dest = [upper(dest(1)) lower(dest(2:end))];
CONSTS = solarSystemConstants(src, dest, 'Sun');
mu_1 = CONSTS.(src).mu;
a_1 = CONSTS.(src).a;
mu_2 = CONSTS.(dest).mu;
a_2 = CONSTS.(dest).a;
mu_sun = CONSTS.Sun.mu;
% Calculate the Hohmann transfer semi-major axis:
a_t = (a_1 + a_2)/2;
% Velocities at infinity w.r.t. the bodies is the velocity difference b/w
% the body's and xfer peri/apoapsis velocity
Vinf_1 = abs( sqrt(2*mu_sun/a_1 - mu_sun/a_t) - sqrt(mu_sun/a_1) );
Vinf_2 = abs( sqrt(mu_sun/a_2) - sqrt(2*mu_sun/a_2 - mu_sun/a_t) );
% Then, delta V is the difference b/w the escape trajectory periapsis
% velocity and the parking orbit velocity
xfer.dV_1 = sqrt(Vinf_1^2 + 2*mu_1/rp1) - sqrt(mu_1/rp1);
xfer.dV_2 = sqrt(Vinf_2^2 + 2*mu_2/rp2) - sqrt(mu_2/rp2);
xfer.dV = xfer.dV_1 + xfer.dV_2;
% Ejection angle (to prograde for outer bodies, retrograde for inner)
e_1 = 1 + rp1*Vinf_1^2/mu_1;
xfer.f_inf = acosd(-1/e_1);
% Phase angle: use xfer true anomaly change - mean motion * transfer time
n1 = sqrt(mu_sun/a_1^3);
n2 = sqrt(mu_sun/a_2^3);
dt = pi*sqrt(a_t^3/mu_sun);
xfer.phaseAngle = rad2deg(pi - n2*dt);
xfer.dt = dt/86400;
% Synodic period, by definition
xfer.T_syn = 2*pi/abs(n1 - n2) / (365.242190402*86400);
end

