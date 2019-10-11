function R = quaternion2RotMat(Q)
%quaternion2RotMat Converts a quaternion to the corresponding rotation
%matrix.
q0 = Q(1);
q = Q(2:end);
qhat = [0, -q(3), q(2); q(3) 0 -q(1); -q(2) q(1) 0];
R = (q0^2 - q'*q)*eye(3) + 2*q*q' - 2*q0*qhat;
end

