function config_idx_forward_weights_to_corrupt = factory_config_idx_forward_weights_to_corrupt(param, arg)

    switch param.type

        % Randomly select forward weight indices to corrupt
        case "random"

            % Create a function handle that generates indices of the forward weights to corrupt
            random_stream = create_random_stream(param.random_seed, "generate_idx_forward_weights_to_corrupt");
            config_idx_forward_weights_to_corrupt.generate_idx_forward_weights_to_corrupt = @(forward_weights) sample_random_indices(random_stream, numel(forward_weights), int64(numel(forward_weights) * param.corruption_ratio));

            % Create the configuration name
            config_idx_forward_weights_to_corrupt.configuration_name = {"idx_forward_weights_to_corrupt=" + param.type, ...
                                                                        "corruption_ratio=" + string(param.corruption_ratio), ...
                                                                        "random_seed=" + string(param.random_seed)};

        case "specify"

            % Create a function handle that returns the specified indices of the forward weights to corrupt
            config_idx_forward_weights_to_corrupt.generate_idx_forward_weights_to_corrupt = @(forward_weights) param.idx;

            % Create the configuration name
            config_idx_forward_weights_to_corrupt.configuration_name = {"idx_forward_weights_to_corrupt=" + param.type, ...
                                                                        "idx=" + convert_list_to_string(param.idx)};
                                                                        
        otherwise

            error("Invalid type for ""idx_forward_weights_to_corrupt"": %s", param.type);

    end