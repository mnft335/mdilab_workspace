function grid_config_idx_initial_forward_weights_to_modify = factory_grid_config_idx_initial_forward_weights_to_modify(param, arg)

    switch param.type

        case "random"

            % Create a cell of parameter names
            grid_config_idx_initial_forward_weights_to_modify.parameter_name = {{"scaling_ratio"}, {"random_seed"}};

            % Create a cell of parameter ranges
            grid_config_idx_initial_forward_weights_to_modify.parameter_range = {param.scaling_ratio, param.random_seed};

            % Create the grid configuration name
            grid_config_idx_initial_forward_weights_to_modify.configuration_name = {"idx_initial_forward_weights_to_modify=" + param.type, ...
                                                                                    "scaling_ratio=" + string(param.scaling_ratio), ...
                                                                                    "random_seed=" + string(param.random_seed)};

        otherwise

            error("Invalid type for ""idx_initial_forward_weights_to_modify="": %s", param.type);

    end

end