function grid_config_forward_weights_to_corrupt = factory_grid_config_idx_forward_weights_to_corrupt(param, arg)

    % Create a cell of parameter names
    grid_config_forward_weights_to_corrupt.parameter_name = {{"corruption_ratio"}, {"random_seed"}};

    % Create a cell of parameter ranges
    grid_config_forward_weights_to_corrupt.parameter_range = {param.corruption_ratio, param.random_seed};

    % Create the grid configuration name
    grid_config_forward_weights_to_corrupt.configuration_name = {"forward_weights_to_corrupt=" + string(param.type)};

end