function grid_config_forward_weight_noise = factory_grid_config_forward_weight_noise(param, arg)

    % Create a cell of parameter names
    grid_config_forward_weight_noise.parameter_name = {{"std_dev"}, {"random_seed"}};

    % Create a cell of parameter ranges
    grid_config_forward_weight_noise.parameter_range = {param.std_dev, param.random_seed};

    % Create the grid configuration name
    grid_config_forward_weight_noise.configuration_name = {"forward_weight_noise=" + string(param.type)};

end