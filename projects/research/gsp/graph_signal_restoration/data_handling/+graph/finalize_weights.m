function weights = finalize_weights(weights, idx_forward_edges)

    % Shift the weights so that the minimum is above eps > 0
    weights(idx_forward_edges) = weights(idx_forward_edges) + max(0, max(- (weights(idx_forward_edges) - eps)));

    % Set weights on the backward edges symmetrically
    weights = weights + weights.';

    % Normalize the weights to mean 1
    weights = weights / mean(weights(weights ~= 0), 'all');

    % Check if the weights are theoretically valid
    check_weights(weights);

end