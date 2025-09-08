function optimal_result_collection = get_optimal_result_collection(grid_param_skeleton, num_points, mode_grid_run, arg)

    % Get the result for GLR
    grid_param_collection = setfield(grid_param_skeleton, "optimization", "type", "glr");
    optimal_result_collection.glr = get_grid_result(grid_param_collection, mode_grid_run, arg);

    % Get the result for gtv
    grid_param_collection = setfield(grid_param_skeleton, "optimization", "type", "gtv");
    optimal_result_collection.gtv = get_grid_result(grid_param_collection, mode_grid_run, arg);

    % Get the optimal result over the hyperparameter for proposed methods
    optimal_result_collection.proposal = get_optimal_result_collection_over_hyperparameter(grid_param_skeleton, num_points, mode_grid_run, arg);

end