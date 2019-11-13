function [t, w, Q] = quaternionTorqueResponse(J, tau, w0, Q0, tspan)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
opts = odeset('RelTol', 1e-6, 'AbsTol', 1e-9);
% The slope is [wdot; Qdot]
dydx = @(t,x) [inv(J)*(tau - xprodmat(x(1:3))*J*x(1:3));
               -1/2*x(1:3)' * x(5:end);
               1/2*(x(1:3)*x(4) - xprodmat(x(1:3))*x(5:end))];
[t, x] = ode45(dydx, tspan, [w0; Q0], opts);
w = x(:, 1:3);
Q = x(:, 4:end);
end

