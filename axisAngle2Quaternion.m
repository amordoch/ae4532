function Q = axisAngle2Quaternion(axang)
%axisAngle2Quaternion Get the quaternion corresponding to an axis-angle
%rotation representation. 
%   axang: axis-angle formatted as {a, mu}, where a is a column vector.
Q = [cos(axang{2}/2); axang{1}*sin(axang{2}/2)];
end

