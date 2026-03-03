function plot_graph_signal(graph_gsp_toolbox, signal)

    % Set node colors, clipping the signal values to the range [0, 1]
    config_node.values = signal;
    config_node.color_map = jet(256);

    % Set edge color, normalizing the edge weights to the range [0, 1]
    config_edge.values = graph_gsp_toolbox.weights;
    color_map = gray(288);
    config_edge.color_map = color_map(1:256, :);

    % Plot the graph
    plot_values_on_graph(graph_gsp_toolbox, config_node, config_edge);

end