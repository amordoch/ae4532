function [t, w, th] = eulerAngleTorqueResponse(seq, J, tau, w0, th0, tspan)
%eulerAngleTorqueResponse Calculates the response of angular velocity and euler
%angles to a given external torque.
%   INPUTS:
%       seq (char): euler angle sequence (xyz, zxz)
%       J (3x3): MOI matrix
%       tau (3x1): external torque
%       w0 (3x1): initial angular velocity
%       th (3x1): initial euler angles
%       tspan: time interval
try
    % Get the function which gives us thdot = f(w, th)
    thdot = feval(seq);
catch ME
    if strcmp(ME.identifier, 'MATLAB:UndefinedFunction')
        error('rotMat2EulerAngles:badSequence', 'Rotation sequence specification is incorrect.')
    else
        rethrow(ME)
    end
end   
% Now use ode45 to solve
opts = odeset('RelTol', 1e-6, 'AbsTol', 1e-9);
dydx = @(t,x) [inv(J)*(tau - xprodmat(x(1:3))*J*x(1:3));
               thdot(x(1:3), x(4:end))];
[t, x] = ode45(dydx, tspan, [w0; th0], opts);
% Separate out w and the euler angles
w = x(:, 1:3);
th = x(:, 4:end);
end

function thdot = zxz()
% Derived in class
thdot = @(w, th) csc(th(2))...
    *[sin(th(3)) cos(th(3)) 0; 
      sin(th(2))*cos(th(3)) -sin(th(2))*sin(th(3)) 0;
      -cos(th(2))*sin(th(3)) -cos(th(2))*cos(th(3)) sin(th(2))]*w;                               
end

function thdot = xyz()
% Derived in HW5 problem 1
thdot = @(w, th) [cos(th(3))*sec(th(2)) -sec(th(2))*sin(th(3)) 0;
                  sin(th(3)) cos(th(3)) 0;
                  -cos(th(3))*tan(th(2)) sin(th(3))*tan(th(2)) 1]*w;
end