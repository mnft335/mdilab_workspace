function path_true_graph = create_path_true_graph(config_true_graph)

    % Get the path collection
    path_collection = get_path_collection();

    % Create a path to the true graph directory
    path_true_graph_directory = fullfile(path_collection.true_graph_registry, create_path_from_configuration(config_true_graph.configuration_name));

    % Create a path to the true graph file
    path_true_graph = fullfile(path_true_graph_directory, "true_graph.mat");

end