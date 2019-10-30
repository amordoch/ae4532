function [t, w, R] = dynamicRotMat(J, tau, w0, Ri, tspan)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
opts = odeset('RelTol', 1e-6, 'AbsTol', 1e-6);
% The slope is a 12x1 vector corresponding to [wdot; elements of Rdot]
dydx = @(t,x) [inv(J)*(tau - xprodmat(x(1:3))*J*x(1:3)); ...
    reshape(-xprodmat(x(1:3))*reshape(x(4:end), [3 3]), [9 1])];
[t, x] = ode45(dydx, tspan, [w0; reshape(Ri, [9 1])]);
w = x(:, 1:3);
% Return R as a cell array of matrices
R = {};
for i = 1:length(t)
    R = [R reshape(x(i, 4:end), [3 3])];
end
end

