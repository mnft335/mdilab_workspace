function grid_config_forward_weight_corruption = factory_grid_config_forward_weight_corruption(param, arg)

    switch param.type

        case "additive"

            % Create a grid configuration for indices of forward weights to corrupt
            grid_config_idx_forward_weights_to_corrupt = factory_grid_config_idx_forward_weights_to_corrupt(param.idx_to_corrupt, arg);

            % Create a grid configuration for forward weight noise
            grid_config_forward_weight_noise = factory_grid_config_forward_weight_noise(param.noise, arg);

            % Create a cell of parameter names
            parameter_name_idx_forward_weights_to_corrupt = cellfun(@(z) [{"idx_to_corrupt"}, z], grid_config_idx_forward_weights_to_corrupt.parameter_name, 'UniformOutput', false);
            parameter_name_forward_weight_noise = cellfun(@(z) [{"noise"}, z], grid_config_forward_weight_noise.parameter_name, 'UniformOutput', false);
            grid_config_forward_weight_corruption.parameter_name = [parameter_name_idx_forward_weights_to_corrupt, parameter_name_forward_weight_noise];

            % Create a cell of parameter ranges
            grid_config_forward_weight_corruption.parameter_range = [grid_config_idx_forward_weights_to_corrupt.parameter_range, grid_config_forward_weight_noise.parameter_range];

            % Create the grid configuration name
            grid_config_forward_weight_corruption.configuration_name = [{"forward_weight_corruption=" + param.type}, ...
                                                                        grid_config_idx_forward_weights_to_corrupt.configuration_name, ...
                                                                        grid_config_forward_weight_noise.configuration_name];

        otherwise

            error("Invalid type for ""forward_weight_corruption"": %s", param.type);

    end

end