function plot_restoration_error(result)

    % Get the difference between the true and restored signals
    true_signal = result.object_collection.true_signal;
    restored_signal = result.solution.x{1};
    signal_error = restored_signal - true_signal;

    % Get the weight noise
    true_weights = result.object_collection.true_graph.weights;
    corrupted_weights = result.object_collection.corrupted_graph.weights;
    weight_noise = corrupted_weights - true_weights;

    % Create configurations for plotting
    config_node.values = abs(signal_error);
    config_node.color_map = jet(256);
    config_edge.values = abs(weight_noise);
    color_map = gray(288);
    config_edge.color_map = flipud(color_map(1:256, :));

    % Plot the signal error and weight noise
    plot_values_on_graph(result.object_collection.true_graph, config_node, config_edge);

end