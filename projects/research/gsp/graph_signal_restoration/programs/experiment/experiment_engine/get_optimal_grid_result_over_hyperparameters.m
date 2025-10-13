function optimal_grid_result = get_optimal_grid_result_over_hyperparameters(grid_param, mode_grid_run, parameter_names, arg)

    % Get the grid result
    grid_result = get_grid_result(grid_param, mode_grid_run, arg);

    % Compute NMSE for each case
    nmse_over_hyperparameter = compute_nmse_from_result(grid_result.result);

    % Find the indices of hyperparameters that give the optimal result
    dimension_hyperparameter = arrayfun(@(parameter_name) find_parameter_dimension(grid_result.grid_config_collection, parameter_name), parameter_names);
    [~, idx_optimal_hyperparameter] = min(nmse_over_hyperparameter, [], dimension_hyperparameter);

    % Extract the optimal result
    optimal_result = extract_elements(grid_result.result, idx_optimal_hyperparameter, dimension_hyperparameter);
    optimal_grid_result = setfield(grid_result, "result", optimal_result);
    optimal_grid_result.idx_optimal_hyperparameter = idx_optimal_hyperparameter;

end