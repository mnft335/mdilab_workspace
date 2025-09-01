function true_graph = load_true_graph(config_true_graph)

    % Create a path to the true graph
    path_true_graph = create_path_true_graph(config_true_graph);

    % Load the true graph
    true_graph = load_file(path_true_graph);

end