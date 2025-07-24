function weights_corrupted = corrupt_weights(weights, corruption_ratio, corruption_method)

    % Find the indices of the forward edges (edges in the triangular part)
    idx_forward_weights = find(triu(weights, 1));

    % Determine the indices of corrupted weights
    num_corrupted_weights = int64(numel(idx_forward_weights) * corruption_ratio);
    idx_corrupted_weights = idx_forward_weights(randperm(numel(idx_forward_weights), num_corrupted_weights));

    % Corrupt weights
    weights_corrupted = corruption_method(weights, idx_corrupted_weights);

    % Normalize the weights to mean 1
    weights_corrupted = weights_corrupted / mean(weights(weights_corrupted ~= 0), 'all');

    % Check if the weights are theoretically valid
    check_weights(weights);

end