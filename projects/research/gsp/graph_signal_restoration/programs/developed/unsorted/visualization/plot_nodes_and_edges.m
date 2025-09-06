function plot_nodes_and_edges(graph_gsp_toolbox, node_values, edge_values)

    % Plot the graph, converting to MATLAB graph object
    graph_plot = plot(graph(graph_gsp_toolbox.A));

    % Set node colors
    color_map_nodes = jet(256);
    graph_plot.NodeColor = map_vector_to_color(node_values, color_map_nodes);

    % Set edge color
    color_map_edges = gray(288);
    graph_plot.EdgeColor = map_vector_to_color(edge_values, flipud(color_map_edges(1:256, :)));

    % Set node size
    graph_plot.MarkerSize = 3;

    % Set edge width
    graph_plot.LineWidth = 1;

    % Set edge transparency
    graph_plot.EdgeAlpha = 1;

    % Set the coordinates
    graph_plot.XData = graph_gsp_toolbox.coords(:, 1);
    graph_plot.YData = graph_gsp_toolbox.coords(:, 2);

    % Disable node labels
    graph_plot.NodeLabel = [];

end