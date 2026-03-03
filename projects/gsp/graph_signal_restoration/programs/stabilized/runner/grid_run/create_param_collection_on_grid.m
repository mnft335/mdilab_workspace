% Create a "param" structure for a specific index in the grid
function param_collection_on_grid = create_param_collection_on_grid(grid_config, index_grid, idx_on_grid)
    
    % Initialize the output with the template
    param_collection_on_grid = grid_config.param_template;

    % Loop over each parameter to assign the corresponding value
    for i = 1:numel(grid_config.parameter_name)

        % Extract the index for the current parameter from the index grid
        idx_parameter = index_grid{i}(idx_on_grid);

        % Extract the parameter value from the parameter range
        parameter = grid_config.parameter_range{i}(idx_parameter);

        % Set the parameter in the output structure
        param_collection_on_grid = setfield(param_collection_on_grid, grid_config.parameter_name{i}{:}, parameter);

    end

end