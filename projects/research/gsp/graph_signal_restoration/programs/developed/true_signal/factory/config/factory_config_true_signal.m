function config_true_signal = factory_config_true_signal(param, arg)

    switch param.type

        % Sample smooth signals on a graph
        case "smooth_sampling"

            % Create a function handle that generates smooth sampling coefficients
            config_smooth_sampling_coefficients = factory_config_smooth_sampling_coefficients(param.smooth_sampling_coefficients, arg);
            generate_smooth_sampling_coefficients = config_smooth_sampling_coefficients.generate_smooth_sampling_coefficients;

            % Create a function handle that generates a true signal
            config_true_signal.generate_true_signal = @(true_graph) create_true_signal(sample_smooth_signal(true_graph, generate_smooth_sampling_coefficients));

            % Create the configuration name
            config_true_signal.configuration_name = [{"true_signal=" + param.type}, ...
                                                     config_smooth_sampling_coefficients.configuration_name];

        otherwise

            error("Invalid type for ""true_signal"": %s", param.type);

    end

end