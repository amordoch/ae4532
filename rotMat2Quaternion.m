function Q = rotMat2Quaternion(R)
%rotMat2Quaternion Converts a rotation matrix to a quaternion.
q0 = sqrt(trace(R)+1)/2;
if q0 ~= 0
    q = 1/(4*q0)*[R(2,3) - R(3,2); R(3,1) - R(1,3); R(1,2) - R(2,1)];
else
    % Solving for axis itself
    % Need to check if any of the axis components are 0
    a1 = sqrt((R(1,1)+1)/2); % can choose pos. or neg soln
    a2 = sqrt(R(2,2)/2 + 1/2);
    a3 = sqrt(R(3,3)/2 + 1/2);
    % What R expands to was derived in class
    if a1 ~= 0
        q = [a1; R(1,2)/(2*a1); R(1,3)/(2*a1)];
    elseif a2 ~= 0
        q = [R(1,2)/(2*a2); a2; R(1,3)/(2*a2)];
    elseif a3 ~= 0
        q = [R(1,3)/(2*a3); R(2,3)/(2*a3); a3];
    end    
end
Q = [q0; q];
end

