function [r,v] = getStateVectors(mu, a, e, i, O, w, f)
%getStateVectors Calculates orbital state vectors from the 6 classical
%orbital elements.
%   INPUT: the elements in the order a, e, i, long. AN, arg. of periapsis, 
%       and f. Input angles should be in RADIANS.

% To start, get r and v in perifocal coordinates
r = a*(1-e^2) / (1 + e*cos(f)) * [cos(f); sin(f); 0];
v = sqrt(mu / (a*(1-e^2))) * [-sin(f); e + cos(f); 0];
% Rotate r and v vectors into i, j, k frame
R3 = [cos(w) sin(w) 0; -sin(w) cos(w) 0; 0 0 1];
R2 = [1 0 0; 0 cos(i) sin(i); 0 -sin(i) cos(i)];
R1 = [cos(O) sin(O) 0; -sin(O) cos(O) 0; 0 0 1];
rotMat = (R3*R2*R1)^-1;
r = rotMat*r;
v = rotMat*v;
end

