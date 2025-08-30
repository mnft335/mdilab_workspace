function grid_config_forward_weights_to_corrupt = factory_grid_config_idx_forward_weights_to_corrupt(param, arg)

    switch param.type

        case "random"

            % Create a cell of parameter names
            grid_config_forward_weights_to_corrupt.parameter_name = {{"corruption_ratio"}, {"random_seed"}};

            % Create a cell of parameter ranges
            grid_config_forward_weights_to_corrupt.parameter_range = {param.corruption_ratio, param.random_seed};

            % Create the grid configuration name
            grid_config_forward_weights_to_corrupt.configuration_name = {"idx_forward_weights_to_corrupt=" + param.type};

        otherwise

            error("Invalid type for ""idx_forward_weights_to_corrupt"": %s", param.type);

    end

end