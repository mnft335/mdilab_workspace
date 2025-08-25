function clean_graph = register_and_load_clean_graph(config_clean_graph)

    % Do nothing if the clean graph has been registered
    if exist(config_clean_graph.full_file_name), return; end

    % Generate a clean graph
    clean_weight_matrix = generate_new_weight_matrix(config_clean_graph.adjacency, config_clean_graph.generate_clean_forward_weights);
    clean_graph = create_graph(clean_weight_matrix);

    % Create the registry if it doesn't exist
    registry_path = setdiff(config_clean_graph.full_file_name, "clean_graph.mat");
    if ~exist(registry_path), mkdir(registry_path); end

    % Save and load the clean graph
    save(config_clean_graph.full_file_name, "clean_graph");
    load(config_clean_graph.full_file_name);

end