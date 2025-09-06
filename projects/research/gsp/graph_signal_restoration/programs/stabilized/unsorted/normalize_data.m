function normalized_data = normalize_data(data, range)

    % Get the minimum and maximum values of the input data and range
    min_data = min(data);
    max_data = max(data);
    min_range = range(1);
    max_range = range(2);

    % Set normalized data to 0.5 if the data is constant
    if max_data - min_data < 1e-12

        normalized_data = 0.5 * ones(size(data));

    % Normalize the data to [0, 1] if the data is not constant
    else 

        normalized_data = (data - min_data) / (max_data - min_data);

    end

    % Shift and scale the normalized data to the specified range
    normalized_data = min_range + normalized_data * (max_range - min_range);

end