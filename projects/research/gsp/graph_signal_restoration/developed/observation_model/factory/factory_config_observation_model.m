function config_observation_model = factory_config_observation_model(param, arg)

    switch param.type

        case "inpainting"

            % Create a function handle that generates a signal mask
            random_stream = get_random_stream(param.random_seed_signal_mask, "generate_idx_signal_to_mask");
            idx_signal_to_mask = @(num_nodes) sample_random_indices(random_stream, num_nodes, int64(num_nodes * param.masking_ratio));
            generate_signal_mask = @(num_nodes) apply_partial_data(ones(num_nodes, 1), idx_signal_to_mask(num_nodes), @(z) 0);

            % Create a function handle that generates signal noise
            random_stream = get_random_stream(param.random_seed_signal_noise, "generate_signal_noise");
            generate_signal_noise = @(size) param.std_dev * sample_gaussian(random_stream, size);

            % Create a function handle that generates the observation model of an inpainting problem
            config_observation_model.generate_observation_model = @(graph) generate_observation_model_inpainting(generate_signal_mask(graph.N), generate_signal_noise);

            % Create the configuration name
            config_observation_model.configuration_name = {"observation_model=" + param.type, ...
                                                           "masking_ratio=" + string(param.masking_ratio), ...
                                                           "random_seed_signal_mask=" + string(param.random_seed_signal_mask), ...
                                                           "std_dev=" + string(param.std_dev), ...
                                                           "random_seed_signal_noise=" + string(param.random_seed_signal_noise)};

        otherwise

            error("Invalid type for ""observation_model"": %s", param.type);

    end

end