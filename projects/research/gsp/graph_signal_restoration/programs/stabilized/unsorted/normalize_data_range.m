function processed_data = normalize_data_range(data, original_range, new_range)

    % Get the minimum and maximum values of the specified range
    min_range = original_range(1);
    max_range = original_range(2);

    % Clip the data to the original range just in case
    clipped_data = clip(data, min_range, max_range);

    % Shift and scale the data range
    processed_data = new_range(1) + (clipped_data - min_range) / (max_range - min_range) * (new_range(2) - new_range(1));

end