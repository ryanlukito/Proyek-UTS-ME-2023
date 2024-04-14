% Define the size of the grid
grid_size_x = 18;
grid_size_y = 18;

% Initialize the stream vector field
stream_vector_field_x = zeros(grid_size_x, grid_size_y);
stream_vector_field_y = zeros(grid_size_x, grid_size_y);

% Field direction for every layer in x-coordinate
air = 3;
skin = 75/964;
fat = 15/26;
muscle = 75/1376;

% Define the strengths and directions for each quadrant
quadrant_strengths = [1, 1, 1, 1]; % Strengths for each quadrant
quadrant_directions = [air, 6; skin, 6; fat, 6; muscle, 6]; % Directions for each quadrant

% Divide the grid into quadrants and assign stream vectors accordingly
for i = 1:grid_size_x
    for j = 1:grid_size_y
        % Determine quadrant based on position
        if i >= 0 && j < grid_size_y / 2
            quadrant = 1; % Quadrant 1 Left Side(Air)
        elseif i > 2 * grid_size_x / 3 && j > grid_size_y / 2
            quadrant = 2; % Quadrant 2 Right-Top Side(Skin)
        elseif i > grid_size_x / 3 && i <= 2 * grid_size_x / 3 && j > grid_size_y / 2
            quadrant = 3; % Quadrant 3 Right-Middle Side(Fat)
        elseif i <= grid_size_x / 3 && j > grid_size_y / 2
            quadrant = 4; % Quadrant 4 Right-Bottom Side(Muscle)
        else
            continue;
        end
        stream_vector_field_x(i, j) = quadrant_strengths(quadrant) * quadrant_directions(quadrant, 1);
        stream_vector_field_y(i, j) = quadrant_strengths(quadrant) * quadrant_directions(quadrant, 2);
    end
end

% Plot the stream vector field
quiver(stream_vector_field_x, stream_vector_field_y);
xlabel('X');
ylabel('Y');
title('Segmented Stream Vector Field');
xticks(linspace(0, grid_size_x, 3));
yticks(linspace(0, grid_size_y, 3))
