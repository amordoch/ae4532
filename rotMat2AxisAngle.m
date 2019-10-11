function [axang] = rotMat2AxisAngle(R)
%rotMat2AxisAngle Converts a rotation matrix to its axis-angle
%representation. Output angles in radians.
mu = acos((trace(R) - 1)/2);
a = 1/(2*sin(mu))*[R(2,3) - R(3,2); R(3,1) - R(1,3); R(1,2) - R(2,1)];
axang = {a, mu};
end

