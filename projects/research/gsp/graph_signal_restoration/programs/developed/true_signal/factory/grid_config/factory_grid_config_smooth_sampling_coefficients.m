function grid_config_smooth_sampling_coefficients = factory_grid_config_smooth_sampling_coefficients(param, arg)

    % Create a cell of parameter names
    grid_config_smooth_sampling_coefficients.parameter_name = {{"std_dev"}, {"sampling_ratio"}, {"random_seed"}};

    % Create a cell of parameter ranges
    grid_config_smooth_sampling_coefficients.parameter_range = {param.std_dev, param.sampling_ratio, param.random_seed};

    % Create the grid configuration name
    grid_config_smooth_sampling_coefficients.configuration_name = {"smooth_sampling_coefficients=" + string(param.type)};

end