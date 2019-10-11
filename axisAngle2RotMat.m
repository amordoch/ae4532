function [R] = axisAngle2RotMat(axang)
%axisAngle2RotMat Converts an axis-angle rotation representation into the
%corresponding rotation matrix. Input angles in rad.
a = axang{1};
mu = axang{2};
if norm(a) ~= 1
    a = a/norm(a);
end
ahat = [0, -a(3), a(2); a(3) 0 -a(1); -a(2) a(1) 0];
R = eye(3) - ahat*sin(mu) + ahat^2*(1 - cos(mu));
end

