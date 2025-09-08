function config_adjacency_matrix = factory_config_adjacency_matrix(param, arg)

    switch param.type
        
        % Load an adjacency matrix from the GSP Traffic dataset
        case "gsp_traffic"

            % Load the adjacency matrix specified with the given city name
            graph = load(path_search(param.city_name));
            config_adjacency_matrix.adjacency_matrix = graph.A;
            config_adjacency_matrix.coordinates = graph.pos;

            % Create the configuration name
            config_adjacency_matrix.configuration_name = {"adjacency_matrix=" + param.type, ...
                                                          "city_name=" + param.city_name};

        % Create an adjacency matrix of a path graph
        case "path"

            % Create a path graph with the specified number of nodes
            path_graph = gsp_path(param.num_nodes);
            config_adjacency_matrix.adjacency_matrix = path_graph.A;
            config_adjacency_matrix.coordinates = path_graph.coords;

            % Create the configuration name
            config_adjacency_matrix.configuration_name = {"adjacency_matrix=" + param.type, ...
                                                          "num_nodes=" + param.num_nodes};

        case "david_sensor_network"

            % Create a David sensor network graph with the specified number of nodes
            david_sensor_network_graph = gsp_david_sensor_network(param.num_nodes);
            config_adjacency_matrix.adjacency_matrix = david_sensor_network_graph.A;
            config_adjacency_matrix.coordinates = david_sensor_network_graph.coords;
            
            % Create the configuration name
            config_adjacency_matrix.configuration_name = {"adjacency_matrix=" + param.type, ...
                                                          "num_nodes=" + param.num_nodes};

        otherwise

            error("Invalid type for ""adjacency_matrix"": %s", param.type);

    end
    
end