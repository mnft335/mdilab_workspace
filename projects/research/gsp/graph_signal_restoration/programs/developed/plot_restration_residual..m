function plot_restoration_residual(result)

    % Get the difference between the true and restored signals
    true_signal = result.object_collection.true_signal;
    restored_signal = result.solution.x{1};


    % Get the weight noise
    true_weights = result.object_collection.true_graph.weights;
    corrupted_weights = result.object_collection.corrupted_graph.weights;
    weight_noise = corrupted_weights - true_weights;

    % 