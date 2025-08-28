function config_true_graph = factory_config_true_graph(param, arg)

    switch param.type

        case "generate"

            % Get an adjacency matrix and coordinates
            config_adjacency_matrix = factory_config_adjacency_matrix(param.adjacency_matrix, arg);
            adjacency_matrix = config_adjacency_matrix.adjacency_matrix;
            config_true_graph.coordinates = config_adjacency_matrix.coordinates;

            % Get true forward weights
            config_true_forward_weights = factory_config_true_forward_weights(param.true_forward_weights, arg);
            generate_true_forward_weights = config_true_forward_weights.generate_true_forward_weights;

            % Create a function handle that generates a true graph
            config_true_graph.generate_true_graph = @() generate_new_graph(adjacency_matrix, generate_true_forward_weights);

            % Create the configuration name
            config_true_graph.configuration_name = [{"true_graph=" + param.type}, ...
                                                    config_adjacency_matrix.configuration_name, ...
                                                    config_true_forward_weights.configuration_name];

        otherwise

            error("Invalid type for ""true_graph"": %s", param.type);

    end

end