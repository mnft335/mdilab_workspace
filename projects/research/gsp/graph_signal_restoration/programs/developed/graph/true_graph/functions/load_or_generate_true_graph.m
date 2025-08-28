function true_graph = load_or_generate_true_graph(config_true_graph, path_true_graph_registry)

    % Create a path to the true graph file
    path_true_graph_directory = fullfile(path_true_graph_registry, create_path(config_true_graph.configuration_name));

    % Store a new true graph if it doesn't exist
    if ~exist(fullfile(path_true_graph_directory, "true_graph.mat"))

        true_graph = config_true_graph.generate_true_graph()
        mkdir(path_true_graph_directory);
        save(fullfile(path_true_graph_directory, "true_graph.mat"), "true_graph");

    end

    % Load the true graph
    load(fullfile(path_true_graph_directory, "true_graph.mat"), "true_graph");

end