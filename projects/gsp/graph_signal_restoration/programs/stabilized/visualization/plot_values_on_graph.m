function plot_values_on_graph(graph_gsp_toolbox, config_node, config_edge)

    % Plot the graph, converting to MATLAB graph object
    graph_plot = plot(graph(graph_gsp_toolbox.A));

    % Set node colors
    graph_plot.NodeColor = map_vector_to_color(config_node.values, [0, 1], config_node.color_map);

    % Set edge color
    graph_plot.EdgeColor = map_vector_to_color(config_edge.values, [0, 1], config_edge.color_map);

    % Set node size
    graph_plot.MarkerSize = 5;

    % Set edge width
    graph_plot.LineWidth = 1;

    % Set edge transparency
    graph_plot.EdgeAlpha = 0.7;

    % Set the coordinates
    graph_plot.XData = graph_gsp_toolbox.coords(:, 1);
    graph_plot.YData = graph_gsp_toolbox.coords(:, 2);

    % Disable node labels
    graph_plot.NodeLabel = [];

end