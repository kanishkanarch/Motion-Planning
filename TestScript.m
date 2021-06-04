% TestScript

% small map
map = false(10);

% obstacle
map (1:6, 6) = true;

start_coords = [6, 2];
target_coords  = [8, 9];

close all;

[route, numExpanded] = Astarmap(map, start_coords, target_coords);