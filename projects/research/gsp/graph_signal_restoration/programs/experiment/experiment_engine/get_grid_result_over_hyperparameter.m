function grid_result = get_grid_result_over_hyperparameter(grid_param_skeleton, num_points, mode_grid_run, arg)

    % Create hyperparameter values of the specified amount in (0, 1)
    range_hyperparameter = linspace(0, 1, num_points + 2);
    range_hyperparameter = range_hyperparameter(2:end-1);

    % Get the grid result over the hyperparameter
    grid_param_collection = setfield(grid_param_skeleton, "optimization", "coefficient_l1", range_hyperparameter);
    grid_result = get_grid_result(grid_param_collection, mode_grid_run, arg);

end