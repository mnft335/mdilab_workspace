function plot_restoration_error_over_method(single_param_skeleton, num_points, mode_grid_run, arg)

    % Get the optimal results 
    optimal_result_collection = get_optimal_grid_result_collection(single_param_skeleton, num_points, mode_grid_run, arg);

    % Plot the restoration error for each method
    arrayfun(@(result) plot_restoration_error(result), optimal_result_collection);

end