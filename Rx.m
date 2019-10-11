function R = Rx(th)
%Rx returns a rotation matrix representing a rotation of theta deg. through
%the x axis. Input should be in rad.
R = [1 0 0; 0 cos(th) sin(th); 0 -sin(th) cos(th)];
end

