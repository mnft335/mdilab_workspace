function grid_config_true_forward_weights = factory_grid_config_true_forward_weights(param, arg)

    switch param.type

        case "gaussian"

            % Create a cell of parameter names
            grid_config_true_forward_weights.parameter_name = {{"random_seed"}};

            % Create a cell of parameter ranges
            grid_config_true_forward_weights.parameter_range = {param.random_seed};

            % Create the grid configuration name
            grid_config_true_forward_weights.configuration_name = {"true_forward_weights=" + string(param.type)};

        otherwise

            error("Invalid type for ""true_forward_weights"": %s", param.type);

    end

end