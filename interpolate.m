function interpolated_points = interpolate(points, points_per_unit, wrap_around)
    % Initialize empty arrays for interpolated coordinates
    x_interp = [];
    y_interp = [];
    
    % Number of points in the input matrix
    num_points = size(points, 2);
    
    % Loop through each pair of consecutive points
    for i = 1:num_points
        % Get current and next point (handle wrap-around case)
        x1 = points(1, i);
        y1 = points(2, i);
        
        if i < num_points
            x2 = points(1, i + 1);
            y2 = points(2, i + 1);
        elseif wrap_around
            x2 = points(1, 1);
            y2 = points(2, 1);
        else
            break;
        end
        
        % Compute Euclidean distance between the two points
        dist = sqrt((x2 - x1)^2 + (y2 - y1)^2);
        
        % Determine number of interpolation points based on the distance
        num_interp = round(points_per_unit * dist);
        
        % Linearly interpolate between the two points
        x_segment = linspace(x1, x2, num_interp);
        y_segment = linspace(y1, y2, num_interp);
        
        % Append to the interpolation arrays (excluding duplicate points)
        if isempty(x_interp)
            x_interp = x_segment;
            y_interp = y_segment;
        else
            x_interp = [x_interp, x_segment(2:end)];
            y_interp = [y_interp, y_segment(2:end)];
        end
    end
    
    % Store results in a matrix
    
    interpolated_points = [x_interp; y_interp];
%     if wrap_around
%         interpolated_points(:, end) = [];
%     end
    
end
