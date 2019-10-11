function [time, r, v] = nsolve2bp(mu, r0, v0, opts)
%nsolve2body Uses ode45 to numerically solve the 2-body problem. Default
%solution tolerance is 1e-10.
%   Inputs:
%       r0: initial position
%       v0: initial velocity
%       opts: ODE options object, generated with odeset()

% Equation of motion in state space:
% [r'; r''] = [r'; -mu/r^3 r]
dydt = @(t, y) [y(4:end); -mu/norm(y(1:3))^3 * y(1:3)];
% Solve with ode45
if nargin == 3
    tol = 1e-10;
    opts = odeset('RelTol',tol,'AbsTol',tol);
end
[time, state] = ode45(dydt, [0 30000], [r0'; v0'], opts);
r = state(:, 1:3);
v = state(:, 4:end);
end

