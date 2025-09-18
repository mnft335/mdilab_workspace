function weight_noise = extract_weight_noise(result)

    % Get the true forward weights
    true_forward_weights = result.object_collection.true_graph.weights;

    % Get the corrupted forward weights
    corrupted_forward_weights = result.object_collection.corrupted_graph.weights;

    % Compute the weight noise
    weight_noise = corrupted_forward_weights - true_forward_weights;

end