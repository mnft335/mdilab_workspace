function true_graph = generate_and_save_true_graph(config_true_graph)

    % Generate a true graph
    true_graph = config_true_graph.generate_true_graph();

    % Create a path to the true graph
    path_true_graph = create_path_true_graph(config_true_graph);

    % Save the true graph
    save_file(true_graph, path_true_graph);

end