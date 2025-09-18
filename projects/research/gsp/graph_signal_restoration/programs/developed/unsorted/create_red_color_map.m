function color_map = create_red_color_map(num_colors)

    % Create a linear ramp from 1 to 0 for the specified number of colors
    ramp = linspace(1, 0, num_colors)';

    % Create a red color map ramping intensity from white to red
    color_map = [ones(num_colors, 1), ramp, ramp];

end