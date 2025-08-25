function config_adjacency_matrix = factory_config_adjacency_matrix(param, arg)

    switch param.type
        
        % Load an adjacency matrix from the GSP Traffic dataset
        case "gsp_traffic"

            % Load the adjacency matrix specified with the given city name
            load(path_search(param.city_name));
            config_adjacency_matrix.adjacency_matrix = W;
            config_adjacency_matrix.coordinates = pos;

            % Create the configuration name
            config_adjacency_matrix.configuration_name = {"adjacency_matrix=" + param.type, ...
                                                          "city_name=" + param.city_name};

        otherwise

            error("Invalid type for ""adjacency_matrix"": %s", param.type);

    end
    
end