function ensure_true_graph_over_grid(grid_config_true_graph, arg)

    % Create a grid of parameter indices
    index_grid = create_index_grid(grid_config_true_graph);

    % Generate a new true graph if it doesn't exist for each parameter combination
    for i = 1:numel(index_grid{1})

        % Create a configuration for each parameter combination
        param_collection_on_grid = create_param_collection_on_grid(grid_config_true_graph, index_grid, i);
        config_true_graph = factory_config_true_graph(param_collection_on_grid, arg);

        % Create a path to the true graph
        path_true_graph = create_path_true_graph(config_true_graph);

        % Generate the true graph if it doesn't exist
        if ~exist(path_true_graph, 'file'), generate_and_save_true_graph(config_true_graph);end

    end

end