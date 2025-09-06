function color_matrix = map_vector_to_color(vector, color_map)

    % Specify the number of colors
    num_colors = size(color_map, 1);

    % Normalize the vector to the range [0, 1]
    normalized_data = normalize_data(vector, [0, 1]);

    % Map the normalized values to the colormap
    idx_color = 1 + floor(normalized_data * (num_colors - 1));
    color_matrix = color_map(idx_color, :);

end