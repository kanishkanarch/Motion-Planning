% TestScript

% small map
map = false(10);

% obstacle
map (1:6, 6) = true;

start_coords = [6, 2];
target_coords  = [8, 9];

close all;

[route_without_diagonal, numExpanded_without_diagonal] = Astarmap_without_diagonal(map, start_coords, target_coords);

[route_with_diagonal, numExpanded_with_diagonal] = Astarmap_with_diagonal(map, start_coords, target_coords);