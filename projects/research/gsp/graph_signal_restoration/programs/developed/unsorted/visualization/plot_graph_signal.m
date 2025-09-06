function plot_graph_signal(graph_gsp_toolbox, signal)

    % Plot the graph converted to a MATLAB graph object
    graph_plot = plot(graph(graph_gsp_toolbox.A));

    % Set node colors
    color_map_nodes = jet(256);
    graph_plot.NodeColor = map_vector_to_color(signal, color_map_nodes);

    % Set edge color
    color_map_edges = gray(288);
    graph_plot.EdgeColor = map_vector_to_color(graph_gsp_toolbox.weights, flipud(color_map_edges(1:256, :)));

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