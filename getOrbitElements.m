function [elements] = getOrbitElements(mu, r, v)
%getOrbitElements Calculate classical orbital elements from position and
%velocity. Returned angles are in RADIANS.

% Angular momentum
h = cross(r, v);
% Eccentricity
evec = 1/mu * (cross(v, h) - mu*r/norm(r));
e = norm(evec);
% Inclination
i = acos(dot([0; 0; 1], h) / norm(h));
% Semimajor Axis
ep = 1/2*norm(v)^2 - mu/norm(r);
a = -mu/(2*ep);
% Longitude of the Ascending Node
n = cross([0; 0; 1], h);
n = n/norm(n);
if i == 0 % n = 0 vector
    LongAN = 0;
else
    % n = cos(Om)i + sin(Om)j
    % No ambiguity with atan2
    LongAN = atan2(n(2), n(1));
end
% Argument of Periapsis
if e == 0
    % circular orbit
    ArgPe = 0;
elseif i == 0 && e ~= 0
    % Equatorial elliptical orbit
    ArgPe = acos(dot(evec, [1; 0; 0])/e);    
else
    ArgPe = acos(dot(n, evec)/e);
end
% Check if periapsis is below the equator
if dot(evec, [0 0 1]) < 0
    ArgPe = 2*pi - ArgPe;
end
% True Anomaly
if e == 0
    f = NaN;
else
    f = acos(dot(evec,r)/e/norm(r));
    % f > pi for dot(r, v) < 0
    if dot(r, v) < 0
        f = 2*pi - f;
    end
end
% Return
elements = struct('h', h, 'n', n, 'e', e, 'a', a, 'i', i, 'LongAN', LongAN, ... 
    'ArgPe', ArgPe, 'f', f);
end

