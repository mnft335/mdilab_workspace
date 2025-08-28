function grid_config_true_signal = factory_grid_config_true_signal(param, arg)

    switch param.type

        case "smooth_sampling"

            % Get the grid configuration for the smooth sampling coefficients
            grid_config_smooth_sampling_coefficients = factory_grid_config_smooth_sampling_coefficients(param.smooth_sampling_coefficients, arg);

            % Create a cell of parameter names
            grid_config_true_signal.parameter_name = cellfun(@(z) [{"smooth_sampling_coefficients"}, z], grid_config_smooth_sampling_coefficients.parameter_name, 'UniformOutput', false);

            % Create a cell of parameter ranges
            grid_config_true_signal.parameter_range = grid_config_smooth_sampling_coefficients.parameter_range;

            % Create the grid configuration name
            grid_config_true_signal.configuration_name = [{"true_signal=" + string(param.type)}, ...
                                                          grid_config_smooth_sampling_coefficients.configuration_name];

        otherwise

            error("Invalid type for ""true_signal"": %s", param.type);

    end

end