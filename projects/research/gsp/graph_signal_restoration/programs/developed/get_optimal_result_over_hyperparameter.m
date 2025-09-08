function optimal_result = get_optimal_result_over_hyperparameter(grid_param_skeleton, num_points, mode_grid_run, arg)

    % Get the grid result over the hyperparameter
    grid_result_over_hyperparameter = get_grid_result_over_hyperparameter(grid_param_skeleton, num_points, mode_grid_run, arg);

    % Compute NMSE over the hyperparameter
    nmse_over_hyperparameter = compute_nmse_from_result(grid_result_over_hyperparameter.result);

    % Find the optimal result
    dimension_coefficient_l1 = find_parameter_dimension(grid_result_over_hyperparameter.grid_config_collection, "optimization.coefficient_l1");
    [~, optimal_index] = min(nmse_over_hyperparameter, [], dimension_coefficient_l1);
    optimal_result = grid_result_over_hyperparameter.result(optimal_index);

end