function true_graph = load_true_graph(config_true_graph)

    % Create a path to the true graph
    path_true_graph = create_path_true_graph(config_true_graph);

    % Load the true graph
    load(path_true_graph);

end