function config_corrupted_graph = factory_config_corrupted_graph(param, arg)

    switch param.type

        % Corrupt true graph weights
        case "corrupt"

            % Create a function handle that generates corrupted forward weights
            config_forward_weight_corruption = factory_config_forward_weight_corruption(param.forward_weight_corruption, arg);
            generate_corrupted_forward_weights = config_forward_weight_corruption.generate_corrupted_forward_weights;

            % Create a function handle that generates a corrupted graph
            config_corrupted_graph.generate_corrupted_graph = @(true_graph) generate_new_graph(true_graph.W, generate_corrupted_forward_weights);

            % Create the configuration name
            config_corrupted_graph.configuration_name = [{"corrupted_graph=" + param.type}, ...
                                                         config_forward_weight_corruption.configuration_name];

        % Set all weights to 1
        case "all1"

            % Create a function handle that generates forward weights of all 1
            generate_corrupted_forward_weights = @(forward_weights) ones(numel(forward_weights), 1);

            % Create a function handle that generates a corrupted graph
            config_corrupted_graph.generate_corrupted_graph = @(true_graph) generate_new_graph(true_graph.W, generate_corrupted_forward_weights);

            % Create the configuration name
            config_corrupted_graph.configuration_name = [{"corrupted_graph=" + param.type}];

        otherwise

                error("Invalid type for ""corrupted_graph"": %s", param.type);

    end

end