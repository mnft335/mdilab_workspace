function param_collection_on_grid = create_param_collection_on_grid(grid_config, index_grid, idx_on_grid)
    
    % Create a "param" structure for a specific index in the grid
    param_collection_on_grid = grid_config.param_template;

    for i = 1:numel(grid_config.parameter_name)

        % Parameter to assign
        parameter = grid_config.parameter_range{i}(index_grid{i}(idx_on_grid));

        % Assign the value
        param_collection_on_grid = setfield(param_collection_on_grid, grid_config.parameter_name{i}{:}, parameter);

    end

end