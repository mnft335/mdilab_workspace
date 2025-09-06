function plot_infimal_convolution(result, arrangement)

    % Get the graphs, a signal, and a signal difference
    true_graph = result.object_collection.true_graph;
    corrupted_graph = result.object_collection.corrupted_graph;
    true_signal = result.object_collection.true_signal;
    restored_signal = result.solution.x{1};
    component_l1_term = result.solution.x{2};

    % Create the true and corrupted graph incidence operators
    true_graph_incidence_operator = @(z) (1 ./ sqrt(true_graph.weights)) .* (true_graph.Diff * z);
    corrupted_graph_incidence_operator = @(z) (1 ./ sqrt(corrupted_graph.weights)) .* (corrupted_graph.Diff * z);

    % Compute the true signal difference
    true_signal_difference = true_graph_incidence_operator(true_signal);

    % Compute the corrupted signal difference
    corrupted_signal_difference = corrupted_graph_incidence_operator(restored_signal);

    % Create a figure
    figure_object = figure;
    figure_object.WindowState = "maximized";

    % Create a "tiledlayout" layout
    tiled_chart_layout = tiledlayout(arrangement);
    tiled_chart_layout.TileSpacing = "tight";
    tiled_chart_layout.Padding = "tight";

    % Plot the true signal difference
    axes_object = nexttile(tiled_chart_layout);
    plot_values_on_edges(true_graph, true_signal_difference);
    axes_object.Title.String = "True difference";

    % Plot the corrupted signal difference
    axes_object = nexttile(tiled_chart_layout);
    plot_values_on_edges(corrupted_graph, corrupted_signal_difference);
    axes_object.Title.String = "Corrupted difference";

    % Plot the infimal convolution component in the L1 term
    axes_object = nexttile(tiled_chart_layout);
    plot_values_on_edges(corrupted_graph, component_l1_term);
    axes_object.Title.String = "Difference in L1";

    % Plot the infimal convolution component in the L2 term
    axes_object = nexttile(tiled_chart_layout);
    plot_values_on_edges(corrupted_graph, corrupted_signal_difference - component_l1_term);
    axes_object.Title.String = "Difference in L2";

end