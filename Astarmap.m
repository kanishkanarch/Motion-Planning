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

    % 1 - white - clear cell
    % 2 - black - obstacle
    % 3 - red = visited
    % 4 - blue  - on list
    % 5 - green - start
    % 6 - yellow - destination

    [start_i, start_j] = ind2sub(size(map), start_node);
    f
    g 
    map
    % North cell
    n_i = i-1
    n_j = j
    if map(n_i, n_j) == 1
	    map(n_i, n_j) = 4
	    g(n_i, n_j) = g(current) + 1
	    f(n_i, n_j) = g(n_i, n_j) + H(n_i, n_j)
	    parent(n_i, n_j) = current
    end
    if (((map(n_i, n_j) == 4) || (map(n_i, n_j) == 3)) && (g(n_i, n_j) > (g(i, j)+1))) || (map(n_i, n_j) == 6)
	    g(n_i, n_j) = g(i, j) + 1
	    f(n_i, n_j) = g(n_i, n_j) + H(n_i, n_j)
	    parent(n_i, n_j) = current
    end
    current_temp = sub2ind(size(f), n_i, n_j)
    current_temp
    % South cell
    n_i = i+1
    n_j = j
    if map(n_i, n_j) == 1
	    map(n_i, n_j) = 4
	    g(n_i, n_j) = g(current) + 1
	    f(n_i, n_j) = g(n_i, n_j) + H(n_i, n_j)
	    parent(n_i, n_j) = current
    end
    if (((map(n_i, n_j) == 4) || (map(n_i, n_j) == 3)) && (g(n_i, n_j) > (g(i, j)+1))) || (map(n_i, n_j) == 6)
	    g(n_i, n_j) = g(i, j) + 1
	    f(n_i, n_j) = g(n_i, n_j) + H(n_i, n_j)
	    parent(n_i, n_j) = current
    end
    if (f(n_i, n_j) < f(current_temp))
	    current_temp = sub2ind(size(f), n_i, n_j)
    end

 
    % West cell
    n_i = i
    n_j = j-1
    if map(n_i, n_j) == 1
	    map(n_i, n_j) = 4
	    g(n_i, n_j) = g(current) + 1
	    f(n_i, n_j) = g(n_i, n_j) + H(n_i, n_j)
	    parent(n_i, n_j) = current
    end
    if (((map(n_i, n_j) == 4) || (map(n_i, n_j) == 3)) && (g(n_i, n_j) > (g(i, j)+1))) || (map(n_i, n_j) == 6)
	    g(n_i, n_j) = g(i, j) + 1
	    f(n_i, n_j) = g(n_i, n_j) + H(n_i, n_j)
	    parent(n_i, n_j) = current
    end
    if (f(n_i, n_j) < f(current_temp))
	    current_temp = sub2ind(size(f), n_i, n_j)
    end


    % East cell
    n_i = i
    n_j = j+1
    if map(n_i, n_j) == 1
	    map(n_i, n_j) = 4
	    g(n_i, n_j) = g(current) + 1
	    f(n_i, n_j) = g(n_i, n_j) + H(n_i, n_j)
	    parent(n_i, n_j) = current
    end
    if (((map(n_i, n_j) == 4) || (map(n_i, n_j) == 3)) && (g(n_i, n_j) > (g(i, j)+1))) || (map(n_i, n_j) == 6)
	    g(n_i, n_j) = g(i, j) + 1
	    f(n_i, n_j) = g(n_i, n_j) + H(n_i, n_j)
	    parent(n_i, n_j) = current
    end
    if (f(n_i, n_j) < f(current_temp))
	    current_temp = sub2ind(size(f), n_i, n_j)
    end

    % Updating the current node
    map(current_temp) = 3

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
