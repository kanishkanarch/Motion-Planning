function [route,numExpanded] = Astarmap (input_map, start_coords, target_coords)
% set up color map for display
% 1 - white - clear cell
% 2 - black - obstacle
% 3 - red = visited
% 4 - blue  - on list
% 5 - green - start
% 6 - yellow - destination

o_map = [1 1 1; ...
    0 0 0; ...
    1 0 0; ...
    0 0 1; ...
    0 1 0; ...
    1 1 0; ...
    0.5 0.5 0.5];

colormap(o_map);

[n_rows, n_cols] = size(input_map);

% map - a table that keeps track of the state of each grid cell
map = zeros(n_rows,n_cols);

map(~input_map) = 1;   % Mark free cells
map(input_map)  = 2;   % Mark obstacle cells

% Generate linear indices of start and target nodes
start_node = sub2ind(size(map), start_coords(1), start_coords(2));
target_node  = sub2ind(size(map), target_coords(1),  target_coords(2));

map(start_node) = 5;
map(target_node)  = 6;

% meshgrid will `replicate grid vectors' nrows and ncols to produce
% a full grid
% type `help meshgrid' in the Matlab command prompt for more information
parent = zeros(n_rows,n_cols);

% 
[X, Y] = meshgrid (1:n_cols, 1:n_rows);

destX = target_coords(1);
destY = target_coords(2);

% Evaluate Heuristic function, H, for each grid cell
% Manhattan distance
H = abs(X - destX) + abs(Y - destY);
H = H';
% Initialize cost arrays
f = Inf(n_rows,n_cols);
g = Inf(n_rows,n_cols);

g(start_node) = 0;
f(start_node) = H(start_node);

% keep track of the number of nodes that are expanded
numExpanded = 0;

% Main Loop

while true
    
    % Draw current map
    map(start_node) = 5;
    map(target_node) = 6;
    
    % make drawMapEveryTime = true if you want to see how the 
    % nodes are expanded on the grid. 
    if (true)
        image(1.5, 1.5, map);
        grid on;
        axis image;
        drawnow;
    end
    
    % Find the node with the minimum f value
    [min_f, current] = min(f(:));
    
    if ((current == target_node) || isinf(min_f))
        break;
    end;
    
    % Update input_map
    map(current) = 3;
    f(current) = Inf; % remove this node from further consideration
    
    % Compute row, column coordinates of current node
    [i, j] = ind2sub(size(f), current);
    
    % *********************************************************************
    % ALL YOUR CODE BETWEEN THESE LINES OF STARS
    % Visit all of the neighbors around the current node and update the entries in the map, f, g and parent arrays
    %

    [start_i, start_j] = ind2sub(size(map), start_node);


    % North cell
    g((i-1), j) =  abs(Y(start_i, start_j) - Y((i-1), j)) + abs(abs(X(start_i, start_j) - X(i, j)))
    f((i-1), j) = g((i-1), j) + H((i-1), j)
    f_min_i = i-1
    f_min_j = j
    if (map((i-1), j) == 1)
	    map((i-1), j) = 4 % visited but not gone yet
    end
    % South cell
    g((i+1), j) =  abs(Y(start_i, start_j) - Y((i+1), j)) + abs(abs(X(start_i, start_j) - X(i, j)))
    f((i+1), j) = g((i+1), j) + H((i+1), j)
    if f((i+1), j) < f(f_min_i, f_min_j)
	    f_min_i = i+1
	    f_min_j = j
    end
    if (map((i+1), j) == 1)
	    map((i+1), j) = 4 % visited but not gone yet
    end
    % West cell
    g(i, (j-1)) =  abs(Y(start_i, start_j) - Y(i, (j-1))) + abs(abs(X(start_i, start_j) - X(i, j)))
    f(i, (j-1)) = g(i, (j-1)) + H(i, (j-1))
    if f(i, (j-1)) < f(f_min_i, f_min_j)
	    f_min_i = i
	    f_min_j = j-1
    end
    if (map(i, (j-1)) == 1)
	    map(i, (j-1)) = 4 % visited but not gone yet
    end
    % East cell
    g(i, (j+1)) =  abs(Y(start_i, start_j) - Y(i, (j+1))) + abs(abs(X(start_i, start_j) - X(i, j)))
    f(i, (j+1)) = g(i, (j+1)) + H(i, (j+1))
    if f(i, (j+1)) < f(f_min_i, f_min_j)
	    f_min_i = i
	    f_min_j = j+1
    end
    if (map(i, (j+1)) == 1)
	    map(i, (j+1)) = 4 % visited but not gone yet
    end
    % Update the number of nodes expanded, aka literal brainfuck
    





    numExpanded = numExpanded + 1;
    
    %*********************************************************************
    
end

%% Construct route from start to dest by following the parent links
if (isinf(f(target_node)))
    route = [];
else
    route = [target_node];
    
    while (parent(route(1)) ~= 0)
        route = [parent(route(1)), route];
    end

    % Snippet of code used to visualize the map and the path
    for q = 2:length(route) - 1        
        map(route(q)) = 7;
        pause(0.1);
        image(1.5, 1.5, map);
        grid on;
        axis image;
    end
end

end
