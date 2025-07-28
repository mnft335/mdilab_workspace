function corrupted_weight_matrix = generate_corrupted_weight_matrix(stream, weights, corrupted_weights_ratio, corrupt_forward_weights)

    % Extract the forward weights
    forward_weights = weights(triu(weights, 1) ~= 0);

    % Determine the indices of corrupted weights
    idx_corrupted_weights = randperm(stream, numel(forward_weights), int64(numel(forward_weights) * corrupted_weights_ratio));

    % Corrupt weights
    forward_weights(idx_corrupted_weights) = corrupt_forward_weights(forward_weights(idx_corrupted_weights));

    % Create a corrrupted_weight_matrix
    adjacency = weights ~=0;
    corrupted_weight_matrix = create_weight_matrix(forward_weights, adjacency);

end