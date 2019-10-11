function [E_k, k] = kepler(M, e, tol)
%kepler Solves kepler's equation M = E - e*sin(E) for E, using Newton's
%method.
%   Inputs:
%       M: mean anomaly (rad)
%       e: eccentricity
%       tol: tolerance (default = 1e-6)
if nargin == 2
    tol = 1e-6;
end
f = @(E) E - e*sin(E) - M;
df = @(E) 1 - e*cos(E);
E_k = .1; % initial guess
k = 1;
while abs(f(E_k)) >= tol
    E_k = E_k - f(E_k) / df(E_k);
    k = k + 1;
    if k >= 500
        error('kepler:IterLimitHit', 'Iteration limit exceed.')
    end
end
end

