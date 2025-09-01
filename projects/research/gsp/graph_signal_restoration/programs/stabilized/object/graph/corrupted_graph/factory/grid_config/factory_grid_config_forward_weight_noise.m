function grid_config_forward_weight_noise = factory_grid_config_forward_weight_noise(param, arg)

    switch param.type

        case "gaussian"

            % Create a cell of parameter names
            grid_config_forward_weight_noise.parameter_name = {{"std_dev"}, {"random_seed"}};

            % Create a cell of parameter ranges
            grid_config_forward_weight_noise.parameter_range = {param.std_dev, param.random_seed};

            % Create the grid configuration name
            grid_config_forward_weight_noise.configuration_name = {"forward_weight_noise=" + param.type};

        otherwise

            error("Invalid type for ""forward_weight_noise"": %s", param.type);

    end

end