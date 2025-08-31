function config_true_forward_weights = factory_config_true_forward_weights(param, arg)

    switch param.type

        % Sample true forward weights from the Gaussian distribution
        case "gaussian"

            % Create a function handle that generates true forward weights
            random_stream = create_random_stream(param.random_seed, "generate_true_forward_weights:gaussian");
            config_true_forward_weights.generate_true_forward_weights = @(initial_forward_weights) sample_gaussian(random_stream, [numel(initial_forward_weights), 1]);

            % Create the configuration name
            config_true_forward_weights.configuration_name = {"true_forward_weights=" + param.type, ...
                                                              "random_seed=" + string(param.random_seed)};

        otherwise

            error("Invalid type for ""true_forward_weights"": %s", param.type);
    end

end