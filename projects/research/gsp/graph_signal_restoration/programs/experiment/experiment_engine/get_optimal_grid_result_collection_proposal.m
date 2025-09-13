function optimal_grid_result_collection = get_optimal_grid_result_collection_proposal(grid_param_skeleton, num_points, mode_grid_run, arg)

    % Create a list of proposed method names to iterate over
    list_proposal = ["proposal_1", "proposal_2", "proposal_3", "proposal_4"];

    % Preallocate the result collection
    optimal_grid_result_collection = cell(1, numel(list_proposal));

    % Get the optimal result for each method
    for i = 1:numel(list_proposal)

        grid_param_collection = setfield(grid_param_skeleton, "optimization", "type", list_proposal(i));
        optimal_grid_result_collection{i} = get_optimal_grid_result_over_hyperparameter(grid_param_collection, num_points, mode_grid_run, arg);

    end

    % Convert the result collection to a struct array
    optimal_grid_result_collection = cell2struct(optimal_grid_result_collection, list_proposal, 2);

end