function config_adjacency_matrix = factory_config_adjacency_matrix(param, arg)

    switch param.type
        
        % Load an adjacency matrix from the GSP Traffic dataset
        case "gsp_traffic"

            % Load the adjacency matrix specified with the given city name
            load_graph = @() load(path_search(param.city_name));
            config_adjacency_matrix.generate_adjacency_matrix = @() load_graph().A;
            config_adjacency_matrix.coordinates = load_graph().pos;

            % Create the configuration name
            config_adjacency_matrix.configuration_name = {"adjacency_matrix=" + param.type, ...
                                                          "city_name=" + param.city_name};

        % Create an adjacency matrix of a path graph
        case "path"

            % Create a path graph with the specified number of nodes
            path_graph = gsp_path(param.num_nodes);
            config_adjacency_matrix.generate_adjacency_matrix = @() path_graph.A;
            config_adjacency_matrix.coordinates = path_graph.coords;

            % Create the configuration name
            config_adjacency_matrix.configuration_name = {"adjacency_matrix=" + param.type, ...
                                                          "num_nodes=" + param.num_nodes};

        case "david_sensor_network"

            % Create a David sensor network graph with the specified number of nodes
            david_sensor_network_graph = gsp_david_sensor_network(param.num_nodes);
            config_adjacency_matrix.generate_adjacency_matrix = @() david_sensor_network_graph.A;
            config_adjacency_matrix.coordinates = david_sensor_network_graph.coords;
            
            % Create the configuration name
            config_adjacency_matrix.configuration_name = {"adjacency_matrix=" + param.type, ...
                                                          "num_nodes=" + string(param.num_nodes)};

        case "rgg"

            % Generate a connected Random Geometric Graph
            [A, coords] = generate_connected_rgg(param.num_nodes, param.distance_threshold, param.random_seed);
            config_adjacency_matrix.generate_adjacency_matrix = @() A;
            config_adjacency_matrix.coordinates = coords;
            
            % Create the configuration name
            config_adjacency_matrix.configuration_name = {"adjacency_matrix=" + param.type, ...
                                                          "num_nodes=" + string(param.num_nodes), ...
                                                          "distance_threshold=" + string(param.distance_threshold), ...
                                                          "random_seed=" + string(param.random_seed)};

        case "sbm"

            % Generate a connected Stochastic Block Model graph
            [A, ~] = generate_connected_sbm(param.cluster_sizes, param.connection_probabilities, param.random_seed);
            config_adjacency_matrix.generate_adjacency_matrix = @() A;
            config_adjacency_matrix.coordinates = []; % No inherently meaningful 2D coordinates for SBM
            
            % Create the configuration name
            config_adjacency_matrix.configuration_name = {"adjacency_matrix=" + param.type, ...
                                                          "num_clusters=" + string(length(param.cluster_sizes)), ...
                                                          "random_seed=" + string(param.random_seed)};

        case "ba"

            % Generate a connected Barabasi-Albert graph
            A = generate_connected_ba(param.num_nodes, param.num_initial_nodes, param.num_edges_to_add, param.random_seed);
            config_adjacency_matrix.generate_adjacency_matrix = @() A;
            config_adjacency_matrix.coordinates = [];
            
            % Create the configuration name
            config_adjacency_matrix.configuration_name = {"adjacency_matrix=" + param.type, ...
                                                          "num_nodes=" + string(param.num_nodes), ...
                                                          "num_initial_nodes=" + string(param.num_initial_nodes), ...
                                                          "random_seed=" + string(param.random_seed)};

        otherwise

            error("Invalid type for ""adjacency_matrix"": %s", param.type);

    end
    
end