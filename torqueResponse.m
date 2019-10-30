function [t, w] = torqueResponse(J, tau, w0, tspan)
%torqueResponse Calculates the angular velocity response of a rigid body
%with MOI matrix J to a torque tau (3x1). 
%
%   INPUTS:
%       J (3x3): MOI matrix
%       tau (3x1): a function f(t) or vector giving the external torque
%       w0: initial angular velocity
%       tspan: range of times to integrate over, i.e. [0 5]

if ~isnumeric(tau)
    M = tau;
    tau = @(t) feval(M, t);
end
% Define cross product mat
w_hat = @(w) [0 -w(3) w(2); w(3) 0 -w(1); -w(2) w(1) 0];
% EOM
dydx = @(t, w) inv(J)*(tau - w_hat(w)*J*w);
% Integrate
[t, w] = ode45(dydx, tspan, w0);
end