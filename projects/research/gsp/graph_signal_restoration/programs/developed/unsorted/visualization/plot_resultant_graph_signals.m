function plot_resultant_graph_signals(result, arrangement)

    % Get the graph and signals to plot
    graph = result.object_collection.true_graph;
    true_signal = result.object_collection.true_signal;
    observed_signal = result.object_collection.optimization.config_solver.observed_signal;
    restored_signal = result.solution.x{1};
    
    % Create a figure
    figure_object = figure;
    figure_object.WindowState = "maximized";

    % Create a "tiledlayout" layout
    tiled_chart_layout = tiledlayout(arrangement);
    tiled_chart_layout.TileSpacing = "tight";
    tiled_chart_layout.Padding = "tight";

    % Plot the original, observed, and restored signals
    axes_object = nexttile(tiled_chart_layout);
    plot_graph_signal(graph, true_signal);
    axes_object.Title.String = "True signal";

    axes_object = nexttile(tiled_chart_layout);
    plot_graph_signal(graph, observed_signal);
    axes_object.Title.String = "Observed signal";

    axes_object = nexttile(tiled_chart_layout);
    plot_graph_signal(graph, restored_signal);
    axes_object.Title.String = "Restored signal";

end