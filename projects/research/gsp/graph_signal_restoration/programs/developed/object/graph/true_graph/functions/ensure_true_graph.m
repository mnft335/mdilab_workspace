function ensure_true_graph(config_true_graph)

    % Get the path collection
    path_collection = get_path_collection();

    % Create a path to the true graph
    path_true_graph = create_path_true_graph(config_true_graph);

    % Do nothing if a true graph exists
    if exist(path_true_graph, 'file'), return; end

    % Generate a true graph
    true_graph = config_true_graph.generate_true_graph();

    % Save the true graph
    save_file(true_graph, path_true_graph);

end