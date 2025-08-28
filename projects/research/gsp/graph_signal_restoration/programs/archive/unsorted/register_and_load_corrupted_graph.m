function graph = register_and_load_graph(config_graph)

    full_file_name = fullfile(config_graph.path_registry, config_graph.file_name);

    % Generate and save a graph if it doesn't exist
    if ~exist(config_graph.full_file_name)

        % Generate a graph
        new_weight_matrix = generate_new_weight_matrix(config_graph.weight_matrix, config_graph.generate_new_forward_weights);
        graph = create_graph(new_weight_matrix);

        % Create the registry if it doesn't exist
        if ~exist(config_graph.path_registry), mkdir(config_graph.path_registry), end

        % Save the graph
        save(full_file_name, "graph");

    else

        % Load the graph
        load(full_file_name);

    end

end