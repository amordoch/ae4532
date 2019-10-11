function [info] = solarSystemConstants(varargin)
%solarSystemConstants Returns mass, radius, and standard gravitational
%parameter for bodies in the solar system.
AU = 149597870.700; % km 
% Load planet data
data = jsondecode(fileread('planetdata.json'));
% Index out only the requested bodies
if nargin == 0
    info = rmfield(data, 'Units');
else
    info = [];
    bodies = fieldnames(data);
    for i = 1:length(varargin)
        body = bodies{strcmpi(varargin{i}, bodies)};
        info.(body) = data.(body);
    end
end
% Convert semi-major axes to km
bodies = fieldnames(info);
for i = 1:length(bodies)
    body = bodies{i};
    if strcmp(body, 'Sun')
        continue
    end
    info.(body).a = info.(body).a*AU;
end
% For one body, open up struct for convienence
if length(bodies) == 1
    info = info.(bodies{1});
end
end

