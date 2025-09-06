function grid_config_true_forward_weights = factory_grid_config_true_forward_weights(param, arg)

    switch param.type

        case "gaussian"

            % Create a cell of parameter names
            grid_config_true_forward_weights.parameter_name = {{"random_seed"}};

            % Create a cell of parameter ranges
            grid_config_true_forward_weights.parameter_range = {param.random_seed};

            % Create the grid configuration name
            grid_config_true_forward_weights.configuration_name = {"true_forward_weights=" + param.type};

        case "binary"

            % Get the grid configuration for indices of the initial forward weights to scale
            grid_config_idx_initial_forward_weights_to_modify = factory_grid_config_idx_initial_forward_weights_to_modify(param.idx_to_modify, arg);

            % Create a cell of parameter names
            parameter_name_idx_initial_forward_weights_to_modify = cellfun(@(z) [{"idx_to_modify"}, z], grid_config_idx_initial_forward_weights_to_modify.parameter_name, 'UniformOutput', false);
            grid_config_true_forward_weights.parameter_name = [{{"scaling_factor"}}, ...
                                                               parameter_name_idx_initial_forward_weights_to_modify];

            % Create a cell of parameter ranges
            grid_config_true_forward_weights.parameter_range = [{param.scaling_factor}, ...
                                                                grid_config_idx_initial_forward_weights_to_modify.parameter_range];

            % Create a cell of configuration names
            grid_config_true_forward_weights.configuration_name = [{"true_forward_weights=" + param.type}, ...
                                                                   grid_config_idx_initial_forward_weights_to_modify.configuration_name];

        otherwise

            error("Invalid type for ""true_forward_weights"": %s", param.type);

    end

end