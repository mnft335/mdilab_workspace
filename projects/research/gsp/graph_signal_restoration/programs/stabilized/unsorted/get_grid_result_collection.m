function grid_result_collection = get_grid_result_collection(grid_run_schedule)

    % Preallocate a cell array to store the grid results
    grid_result_collection = cell(1, numel(grid_run_schedule));

    for i = 1:numel(grid_run_schedule)

        % Get the grid result for the current configuration
        grid_result_collection{i} = get_grid_result_over_object(grid_run_schedule{i}.grid_param, grid_run_schedule{i}.mode, grid_run_schedule{i}.arg);

    end

end