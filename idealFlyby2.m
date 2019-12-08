function [rp, dv, etc] = idealFlyby2(planet, vi, vf)
%idealFlyby2 Calculates various information about a planetary flyby given the
%inbound and outbound velocity using patched conics.  
% Assumes that the planet is in a circular orbit and that the approach is
% tangential to the planet's orbit. 
%   INPUTS:
%       planet (char): name of planet
%       vi (double): inbound velocity magntiude
%       vf (double): outbound velocity magnitude
%   OUTPUTS:
%       rp (double): radius of periapsis at planet
%       dv (double): magntiude of delta v
%       etc (struct): struct containing delta, f_inf, local orbit
%           eccentricity, and velocity at escape (v_infty)
warning("Caution: function not validated for flybys where the s/c is "...
    + "initially travelling faster than the planet.")
pl = solarSystemConstants(planet);
sun = solarSystemConstants('sun');
% Calculate vinf w.r.t. planet
vpl = sqrt(sun.mu / pl.a);
vinf = vi - vpl;
% Now, calculate delta from given vf (law of cosines):
if vinf < 0
    delta = acos((vinf^2 + vpl^2 - vf^2)/(2*vpl*-vinf));
else
    delta = -acos((vinf^2 + vpl^2 - vf^2)/(2*vpl*vinf)) + pi;
end
% Calculate the rest of the flyby orbit params
e = csc(delta/2);
finf = delta/2 + pi/2;
rp = -pl.mu/vinf^2*(1 - e);
% For delta v, rotate vinf by delta and add to initial velocity
dv = (vi + Rz(delta)'*(vinf*[1 0 0]')) - vi*[1 0 0]';
dv = norm(dv);
% Extra info
etc.finf = finf;
etc.delta = delta;
etc.e = e;
etc.vinf = norm(vinf);
end

