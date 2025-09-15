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

        case "all"

            % Create a function handle that returns all indices of the forward weights to corrupt
            config_idx_forward_weights_to_corrupt.generate_idx_forward_weights_to_corrupt = @(forward_weights) 1:numel(forward_weights);

            % Create the configuration name
            config_idx_forward_weights_to_corrupt.configuration_name = {"idx_forward_weights_to_corrupt=" + param.type};

        case "specify"

            % Define a list of cuts
            cuts.("middle_left") = [119, 120, 121, 122];
            cuts.("top_center") = [113];
            cuts.("middle_center") = [79, 187];
            cuts.("bottom_right") = [81, 98, 158];
            cuts.("middle_right") = [86, 155, 189, 193, 194, 195, 196];
            cuts.("middle_left_top_center") = [119, 120, 121, 122, 113];
            cuts.("all") = [79, 81, 86, 98, 113, 119, 120, 121, 122, 155, 158, 187, 189, 193, 194, 195, 196];

            % Create a function handle that returns the specified indices of the forward weights to corrupt
            config_idx_forward_weights_to_corrupt.generate_idx_forward_weights_to_corrupt = @(forward_weights) cuts.(param.cut_name);

            % Create the configuration name
            config_idx_forward_weights_to_corrupt.configuration_name = {"idx_forward_weights_to_corrupt=" + param.type, ...
                                                                        "cut_name=" + param.cut_name};
                                                                        
        otherwise

            error("Invalid type for ""idx_forward_weights_to_corrupt"": %s", param.type);

    end