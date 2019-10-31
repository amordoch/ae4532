function [t, w, R] = rotMatTorqueResponse(J, tau, w0, Ri, tspan)
%rotMatTorqueResposne Calculates the time response of a rotation matrix to
%an input torque tau. Also ouputs the angular velocity.
%   INPUTS:
%       J (3x3): inertia matrix
%       tau (3x1): external torque
%       w0 (3x1): initial angular velocity
%       Ri (3x3): initial rotation matrix
%       tspan (1x2): time interval to integrate over
opts = odeset('RelTol', 1e-6, 'AbsTol', 1e-9);
% The slope is a 12x1 vector corresponding to [wdot; elements of Rdot]
dydx = @(t,x) [inv(J)*(tau - xprodmat(x(1:3))*J*x(1:3)); ...
    reshape(-xprodmat(x(1:3))*reshape(x(4:end), [3 3]), [9 1])];
[t, x] = ode45(dydx, tspan, [w0; reshape(Ri, [9 1])], opts);
w = x(:, 1:3);
% Return R as a cell array of matrices
R = {};
for i = 1:length(t)
    R = [R reshape(x(i, 4:end), [3 3])];
end
end

