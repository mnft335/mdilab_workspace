function config_idx_initial_forward_weights_to_modify = factory_config_idx_initial_forward_weights_to_modify(param, arg)

    switch param.type

        case "random"

            % Create a function handle that generates indices of the forward weights scale
            random_stream = create_random_stream(param.random_seed, "generate_idx_initial_forward_weights_to_modify");
            config_idx_initial_forward_weights_to_modify.generate_idx_initial_forward_weights_to_modify = @(initial_forward_weights) sample_random_indices(random_stream, numel(initial_forward_weights), int64(numel(initial_forward_weights) * param.scaling_ratio));

            % Create the configuration name
            config_idx_initial_forward_weights_to_modify.configuration_name = {"idx_initial_forward_weights_to_modify=" + param.type, ...
                                                                              "scaling_ratio=" + string(param.scaling_ratio), ...
                                                                              "random_seed=" + string(param.random_seed)};

        otherwise

            error("Invalid type for ""idx_initial_forward_weights_to_modify"": %s", param.type);
    end

end