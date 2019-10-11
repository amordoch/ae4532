function [th1,th2, th3] = rotMat2EulerAngles(R, seq)
%rotMat2EulerAngles Convert given Euler angles to the respective rotation
%matrix.
%   INPUTS:
%       R: rotation matrix
%       seq: rotation sequence (default: zxz)
if nargin == 1
    seq = 'zxz';
end
try
    [th1, th2, th3] = feval(seq, R);
catch ME
    if strcmp(ME.identifier, 'MATLAB:UndefinedFunction')
        error('rotMat2EulerAngles:badSequence', 'Rotation sequence specification is incorrect.')
    else
        rethrow(ME)
    end
end    
end

function [th1, th2, th3] = zxz(R)
% First, calculate theta2 (choose positive answer)
th2 = acos(R(3,3));
if th2 == 0
    % Singularity!
    th1 = NaN;
    th3 = NaN;
    return
end
% Next, find theta1 and 3:
if th2 >  0
    th1 = atan2(R(3,1), -R(3,2));
else
    th1 = atan2(-R(3,1), R(3,2));
end
if th2 > 0
    th3 = atan2(R(1,3), R(2,3));
else
    th3 = atan2(-R(1,3), -R(2,3));
end
end

function [th1, th2, th3] = xyz(R)
th2 = asin(R(3,1)); 
if cos(th2) == 0
    % Singularity
    th1 = NaN;
    th3 = NaN;
else
    th1 = atan2(-R(3,2)/cos(th2), R(3,3)/cos(th2));
    th3 = atan2(-R(2,1)/cos(th2), R(1,1)/cos(th2));
end
end
