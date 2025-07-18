function weights = corrupt_weights(weights, corruption_ratio, corruption)

    % Find the indices of the forward edges (edges in the triangular part)
    idx_forward_weights = find(triu(weights, 1));

    % Determine the indices of corrupted weights
    random_indices = randperm(numel(idx_forward_weights), int8(numel(idx_forward_weights) * corruption_ratio));
    idx_corrupted_weights = idx_forward_weights(random_indices);

    % Corrupt weights
    weights = corruption(weights, idx_corrupted_weights);

    % Normalize the weights to mean 1
    weights = weights / mean(weights(weights ~= 0), 'all');

    check_weights(weights);

end