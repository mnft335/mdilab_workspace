function plot_values_on_edges(graph_gsp_toolbox, edge_values)

    % Plot the graph, converting to MATLAB graph object
    graph_plot = plot(graph(graph_gsp_toolbox.A));

    % Disable node plotting
    graph_plot.Marker = "none";
    graph_plot.NodeLabel = [];

    % Set edge color
    color_map_edges = jet(256);
    graph_plot.EdgeColor = map_vector_to_color(edge_values, color_map_edges);

    % Set edge width
    graph_plot.LineWidth = 1;

    % Set edge transparency
    graph_plot.EdgeAlpha = 1;

    % Set the coordinates
    graph_plot.XData = graph_gsp_toolbox.coords(:, 1);
    graph_plot.YData = graph_gsp_toolbox.coords(:, 2);

end