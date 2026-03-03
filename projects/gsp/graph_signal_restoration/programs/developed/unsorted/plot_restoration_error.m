function plot_restoration_error(result)

    % Get the difference between the true and restored signals
    true_signal = result.object_collection.true_signal;
    restored_signal = result.solution.x{1};
    signal_error = restored_signal - true_signal;

    % Get the weight noise
    true_weights = result.object_collection.true_graph.weights;
    corrupted_weights = result.object_collection.corrupted_graph.weights;

    % Align the scale of the true and corrupted weights
    corrupted_weights = corrupted_weights * min(true_weights, [], "all") / min(corrupted_weights, [], "all");

    % Identify the indices of the corrupted weights
    idx_corrupted_weights = find(abs(corrupted_weights - true_weights) > 1e-9);

    % Create configurations for plotting
    config_node.values = abs(signal_error);
    config_node.color_map = create_red_color_map(256);
    config_edge.values = abs(assign_partial_elements(zeros(numel(true_weights), 1), idx_corrupted_weights, 1));
    color_map = gray(288);
    config_edge.color_map = flipud(color_map(1:256, :));

    % Plot the signal error and weight noise
    plot_values_on_graph(result.object_collection.true_graph, config_node, config_edge);

end