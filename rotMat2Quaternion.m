function Q = rotMat2Quaternion(R)
%rotMat2Quaternion Converts a rotation matrix to a quaternion.
q0 = sqrt(trace(R)+1)/2;
if q0 ~= 0
    q = 1/(4*q0)*[R(2,3) - R(3,2); R(3,1) - R(1,3); R(1,2) - R(2,1)];
else
    q = [sqrt((R(1,1) + 1)/2); R(1,2)/(2*q1); R(1,3)/(2*q1)];
end
Q = [q0; q];
end

