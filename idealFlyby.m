function [vo, dv, etc] = idealFlyby(planet, vi, rp)
%idealFlyby Calculates various information about a planetary flyby given the
%inbound velocity and the periapsis radius using patched conics.  
% Assumes that the planet is in a circular orbit and that the approach is
% tangential to the planet's orbit. 
%   INPUTS:
%       planet (char): name of planet
%       vi (double): inbound velocity magntiude
%       rp (double): periapsis radius
%   OUTPUTS:
%       vo (double): outbound velocity magntiude
%       dv (double): magntiude of delta v
%       etc (struct): struct containing delta, f_inf, local orbit
%           eccentricity, and velocity at escape (v_infty)
pl = solarSystemConstants(planet);
sun = solarSystemConstants('sun');
% Calculate vinf w.r.t. planet
% Assume we travel in the x direction - equivelently, could choose any
% direction, but since everything is tangential, you could always rotate
% into a coordinate system where the velocities are in the x direction.
vpl = sqrt(sun.mu / pl.a)*[1 0 0]';
vinf = vi*[1 0 0]' - vpl;
% Now, calculate delta from given rp: 
e = 1 + rp*norm(vinf)^2/pl.mu;
delta = 2*asin(1/e);
finf = delta/2 + pi/2;
% Rotate vinf by delta:
% Transpose is rqd here b/c we want to rotate the vector, not the axes.
vinf_out = Rz(delta)' * vinf;
% Find outbound velocity
vo = vpl + vinf_out;
% Delta v
dv = vo - vi;
vo = norm(vo);
dv = norm(dv);
% Extra info
etc.finf = finf;
etc.delta = delta;
etc.e = e;
etc.vinf = norm(vinf);
end

