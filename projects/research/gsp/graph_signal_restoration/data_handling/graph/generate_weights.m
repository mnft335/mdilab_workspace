function generate_weights(adjacency, generation_method)

    % Find the indices of the forward edges (edges in the upper triangular part)
    idx_forward_edges = find(triu(adjacency, 1));

    % Sample weights on the forward edges from the Gaussian distribution
    weights = zeros(size(adjacency));
    weights(idx_forward_edges) = generation_method(idx_forward_edges);

    % Shift the weights so that the minimum is above eps > 0
    weights = weights + max(0, - min(weights, [], 'all')) + eps;

    % Set weights on the backward edges symmetrically
    weights = weights + weights.';

    % Normalize the weights to mean 1
    weights = weights / mean(weights(weights ~= 0), 'all');

    % Check if the weights are theoretically valid
    check_weights(weights);

end