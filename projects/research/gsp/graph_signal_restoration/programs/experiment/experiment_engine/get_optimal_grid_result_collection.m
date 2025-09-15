function optimal_grid_result_collection = get_optimal_grid_result_collection(grid_param_skeleton, mode_grid_run, arg)

    % Get the result for GLR
    grid_param_collection = setfield(grid_param_skeleton, "optimization", "type", "glr");
    optimal_grid_result_collection.glr = get_grid_result(grid_param_collection, mode_grid_run, arg);

    % Get the result for gtv
    grid_param_collection = setfield(grid_param_skeleton, "optimization", "type", "gtv");
    optimal_grid_result_collection.gtv = get_grid_result(grid_param_collection, mode_grid_run, arg);

    % Get the optimal result over the hyperparameter for proposed methods
    optimal_grid_result_collection_proposal = get_optimal_grid_result_collection_proposal(grid_param_skeleton, mode_grid_run, arg);

    % Get the field names of the proposed methods
    field_names = fieldnames(optimal_grid_result_collection_proposal);

    % Assign the results of each proposed method to the result struct
    for i = 1:numel(field_names)

        optimal_grid_result_collection.(field_names{i}) = optimal_grid_result_collection_proposal.(field_names{i});

    end

end