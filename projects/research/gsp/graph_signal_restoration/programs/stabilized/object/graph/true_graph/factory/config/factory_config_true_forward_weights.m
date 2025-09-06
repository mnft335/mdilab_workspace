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

        case "binary"

            % Create a function handle that generates indices of the forward weights to scale
            config_idx_initial_forward_weights_to_modify = factory_config_idx_initial_forward_weights_to_modify(param.idx_to_modify, arg);
            generate_idx_initial_forward_weights_to_modify = config_idx_initial_forward_weights_to_modify.generate_idx_initial_forward_weights_to_modify;

            % Create a function handle that generates true forward weights
            scale_weights = @(initial_forward_weights_to_modify) initial_forward_weights_to_modify * param.scaling_factor;
            config_true_forward_weights.generate_true_forward_weights = @(initial_forward_weights) apply_partial_elements(initial_forward_weights, generate_idx_initial_forward_weights_to_modify(initial_forward_weights), scale_weights);

            % Create the configuration name
            config_true_forward_weights.configuration_name = [{"true_forward_weights=" + param.type}, ...
                                                              config_idx_initial_forward_weights_to_modify.configuration_name];

        otherwise

            error("Invalid type for ""true_forward_weights"": %s", param.type);
    end

end