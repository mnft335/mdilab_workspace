function grid_config_adjacency_matrix = factory_grid_config_adjacency_matrix(param, arg)

    switch param.type

        case "gsp_traffic"

            % Create a cell of parameter names
            grid_config_adjacency_matrix.parameter_name = {{"city_name"}};

            % Create a cell of parameter ranges
            grid_config_adjacency_matrix.parameter_range = {param.city_name};

            % Create the grid configuration name
            grid_config_adjacency_matrix.configuration_name = {"adjacency_matrix=" + param.type};

        case "path"

            % Create a cell of parameter names
            grid_config_adjacency_matrix.parameter_name = {{"num_nodes"}};

            % Create a cell of parameter ranges
            grid_config_adjacency_matrix.parameter_range = {param.num_nodes};

            % Create the grid configuration name
            grid_config_adjacency_matrix.configuration_name = {"adjacency_matrix=" + param.type};

        case "david_sensor_network"

            % Create a cell of parameter names
            grid_config_adjacency_matrix.parameter_name = {{"num_nodes"}};

            % Create a cell of parameter ranges
            grid_config_adjacency_matrix.parameter_range = {param.num_nodes};

            % Create the grid configuration name
            grid_config_adjacency_matrix.configuration_name = {"adjacency_matrix=" + param.type};

        case "rgg"

            % Create a cell of parameter names
            grid_config_adjacency_matrix.parameter_name = {{"num_nodes"}, {"distance_threshold"}, {"random_seed"}};

            % Create a cell of parameter ranges
            grid_config_adjacency_matrix.parameter_range = {param.num_nodes, param.distance_threshold, param.random_seed};

            % Create the grid configuration name
            grid_config_adjacency_matrix.configuration_name = {"adjacency_matrix=" + param.type};

        case "sbm"

            % Create a cell of parameter names
            grid_config_adjacency_matrix.parameter_name = {{"cluster_sizes"}, {"connection_probabilities"}, {"random_seed"}};

            % Create a cell of parameter ranges
            grid_config_adjacency_matrix.parameter_range = {param.cluster_sizes, param.connection_probabilities, param.random_seed};

            % Create the grid configuration name
            grid_config_adjacency_matrix.configuration_name = {"adjacency_matrix=" + param.type};

        case "ba"

            % Create a cell of parameter names
            grid_config_adjacency_matrix.parameter_name = {{"num_nodes"}, {"num_initial_nodes"}, {"num_edges_to_add"}, {"random_seed"}};

            % Create a cell of parameter ranges
            grid_config_adjacency_matrix.parameter_range = {param.num_nodes, param.num_initial_nodes, param.num_edges_to_add, param.random_seed};

            % Create the grid configuration name
            grid_config_adjacency_matrix.configuration_name = {"adjacency_matrix=" + param.type};

        otherwise

            error("Invalid type for ""adjacency_matrix"": %s", param.type);

    end

end