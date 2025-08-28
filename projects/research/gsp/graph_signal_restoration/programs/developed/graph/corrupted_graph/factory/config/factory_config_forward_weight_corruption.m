function config_forward_weight_corruption = factory_config_forward_weight_corruption(param, arg)

    switch param.type

        % Corrupt with additive noise
        case "additive"

            % Get a function handle that generates indices of the forward weights to corrupt
            config_idx_forward_weights_to_corrupt = factory_config_idx_forward_weights_to_corrupt(param.idx_to_corrupt, arg);
            generate_idx_forward_weights_to_corrupt = config_idx_forward_weights_to_corrupt.generate_idx_forward_weights_to_corrupt;

            % Get a function handle that generates noise for the forward weights
            config_forward_weight_noise = factory_config_forward_weight_noise(param.noise, arg);
            generate_forward_weight_noise = config_forward_weight_noise.generate_forward_weight_noise;

            % Create a function handle that adds noise to the forward weights on the selected indices
            corrupt_forward_weights = @(forward_weights_to_corrupt) add_forward_weight_noise(forward_weights_to_corrupt, generate_forward_weight_noise);
            config_forward_weight_corruption.generate_corrupted_forward_weights = @(true_forward_weights) apply_partial_data(true_forward_weights, generate_idx_forward_weights_to_corrupt(true_forward_weights), corrupt_forward_weights);

            % Create the configuration name
            config_forward_weight_corruption.configuration_name = [{"forward_weight_corruption=" + param.type}, ...
                                                                    config_idx_forward_weights_to_corrupt.configuration_name, ...
                                                                    config_forward_weight_noise.configuration_name];

        otherwise

            error("Invalid type for ""forward_weight_corruption"": %s", param.type);

    end