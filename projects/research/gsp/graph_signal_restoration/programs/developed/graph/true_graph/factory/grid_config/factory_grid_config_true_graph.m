function grid_config_true_graph = factory_grid_config_true_graph(param, arg)

    switch param.type

        case "generate"

            % Get the grid configuration for an adjacency matrix
            grid_config_adjacency_matrix = factory_grid_config_adjacency_matrix(param.adjacency_matrix, arg);

            % Get the grid configuration for true forward weights
            grid_config_true_forward_weights = factory_grid_config_true_forward_weights(param.true_forward_weights, arg);

            % Create a cell of parameter names
            parameter_name_adjacency_matrix = cellfun(@(z) [{"adjacency_matrix"}, z], grid_config_adjacency_matrix.parameter_name, 'UniformOutput', false);
            parameter_name_true_forward_weights = cellfun(@(z) [{"true_forward_weights"}, z], grid_config_true_forward_weights.parameter_name, 'UniformOutput', false);
            grid_config_true_graph.parameter_name = [parameter_name_adjacency_matrix, parameter_name_true_forward_weights];

            % Create a cell of parameter ranges
            grid_config_true_graph.parameter_range = [grid_config_adjacency_matrix.parameter_range, grid_config_true_forward_weights.parameter_range];

            % Create the grid configuration name
            grid_config_true_graph.configuration_name = [{"true_graph=" + string(param.type)}, ...
                                                         grid_config_adjacency_matrix.configuration_name, ...
                                                         grid_config_true_forward_weights.configuration_name];

        otherwise

            error("Invalid type for ""true_graph"": %s", param.type);

    end

end