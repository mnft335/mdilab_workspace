function optimal_grid_result = get_optimal_grid_result_over_hyperparameter(grid_param_skeleton, num_points, mode_grid_run, arg)

    % Get the grid result over the hyperparameter
    grid_result_over_hyperparameter = get_grid_result_over_hyperparameter(grid_param_skeleton, num_points, mode_grid_run, arg);

    % Compute NMSE over the hyperparameter
    nmse_over_hyperparameter = compute_nmse_from_result(grid_result_over_hyperparameter.result);

    % Find the optimal result
    dimension_coefficient_l1 = find_parameter_dimension(grid_result_over_hyperparameter.grid_config_collection, "optimization.coefficient_l1");
    [~, idx_optimal_result] = min(nmse_over_hyperparameter, [], dimension_coefficient_l1);
    
    % Extract all results at the optimal index
    optimal_result = extract_result_at_index(grid_result_over_hyperparameter.result, idx_optimal_result, dimension_coefficient_l1);
    optimal_grid_result = setfield(grid_result_over_hyperparameter, "result", optimal_result);
end

function extracted_result = extract_result_at_index(result, idx, dimension)
    % Create index cell array
    idx_cell = repmat({':'}, ndims(result), 1);
    idx_cell{dimension} = idx;
    
    % Extract the results
    extracted_result = result(idx_cell{:});
end