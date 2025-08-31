function config_forward_weight_noise = factory_config_forward_weight_noise(param, arg)

    switch param.type

        % Sample forward weight noise from the Gaussian distribution
        case "gaussian"

            % Create a function handle that generates noise for the forward weights
            random_stream = create_random_stream(param.random_seed, "generate_forward_weight_noise:gaussian");
            config_forward_weight_noise.generate_forward_weight_noise = @(true_forward_weights) param.std_dev * sample_gaussian(random_stream, [numel(true_forward_weights), 1]);

            % Create the configuration name
            config_forward_weight_noise.configuration_name = {"forward_weight_noise=" + param.type, ...
                                                              "std_dev=" + string(param.std_dev), ...
                                                              "random_seed=" + string(param.random_seed)};

        otherwise

            error("Invalid type for ""forward_weight_noise"": %s", param.type);
            
    end

end