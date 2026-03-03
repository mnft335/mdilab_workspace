% Get the true graph given the configuration
function true_graph = get_true_graph(config_true_graph)

    % Create a path to the true graph
    path_true_graph = create_path_true_graph(config_true_graph);

    % Generate the true graph if it doesn't exist
    if ~exist(path_true_graph, 'file')

        true_graph = generate_and_save_true_graph(config_true_graph);

    % Load the true graph otherwise
    else

        true_graph = load_file(path_true_graph);

    end

end