function result = get_result_on_grid(grid_config_collection, index_grid, idx_on_grid, arg)

    % Create a "param" struct for this iteration
    param_collection = create_param_collection_on_grid(grid_config_collection, index_grid, idx_on_grid);

    % Call the single runner
    result = get_result(param_collection, arg);

end