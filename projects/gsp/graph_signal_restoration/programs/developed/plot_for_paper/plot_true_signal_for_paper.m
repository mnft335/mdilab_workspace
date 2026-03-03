function graph_plot = plot_true_signal_for_paper(result)

    % Get the graph object
    graph_gsp_toolbox = result.object_collection.true_graph;

    % Get the true signal
    true_signal = result.object_collection.true_signal;

    % Configure node settings
    config_node.values = true_signal;
    config_node.color_map = jet(256);

    % Configure edge settings
    weight_noise = extract_weight_noise(result);
    config_edge.values = double(abs(weight_noise) > 1e-12);
    color_map = gray(256);
    config_edge.color_map = flipud(color_map(1:200, :));

    % Plot the observed signal on the graph, with the corrupted edges highlighted
    graph_plot = plot_values_on_graph_for_paper(graph_gsp_toolbox, config_node, config_edge);

end