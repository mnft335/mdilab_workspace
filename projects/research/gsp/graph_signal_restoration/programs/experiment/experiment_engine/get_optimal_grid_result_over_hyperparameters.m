function optimal_grid_result = get_optimal_grid_result_over_hyperparameters(grid_param, mode_grid_run, parameter_names, arg)

    % Get the grid result
    grid_result = get_grid_result(grid_param, mode_grid_run, arg);

    % Compute NMSE for each case
    nmse_over_hyperparameter = compute_nmse_from_result(grid_result.result);

    % Find dimensions of hyperparameters
    dimension_hyperparameter = arrayfun(@(parameter_name) find_parameter_dimension(grid_result.grid_config_collection, parameter_name), parameter_names);

    % Get the indices of optimal hyperparameters
    [~, optimal_hyperparameter_indices] = min(nmse_over_hyperparameter, [], dimension_hyperparameter, 'linear');

    % Compute the size of the optimal hyperparameter subscript
    size_sub_optimal_hyperparameter = size(grid_result.result);
    size_sub_optimal_hyperparameter(dimension_hyperparameter) = 1;

    % Convert linear indices to subscripts
    sub_optimal_hyperparameter = cell(1, numel(ndims(grid_result.result)));
    [sub_optimal_hyperparameter{:}] = ind2sub(size_sub_optimal_hyperparameter, optimal_hyperparameter_indices);

    % Extract the optimal grid result over hyperparameters
    optimal_grid_result = setfield(grid_result, "result", grid_result.result(sub_optimal_hyperparameter{:}));
    optimal_grid_result.sub_optimal_hyperparameter = sub_optimal_hyperparameter;
    clear("grid_result");

end