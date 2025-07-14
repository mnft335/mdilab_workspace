function weights = generate_truncated_normal_weights(adjacency, sigma)

    % Find the indices of the forward edges (edges in the upper triangular part)
    idx_forward_edges = find(triu(adjacency, 1));

    % Create a normal distribution object truncated at 0
    truncated_normal_distribution = truncate(makedist("Normal", "mu", 0, "sigma", sigma), 0, Inf);

    % Sample weights on the forward edges from the Gaussian distribution
    weights = zeros(size(adjacency));
    weights(idx_forward_edges) = random(truncated_normal_distribution, numel(idx_forward_edges), 1);

    % Set weights on the backward edges symmetrically
    weights = weights + weights.';

    % Normalize the weights to mean 1
    weights = weights / mean(weights(weights ~= 0), 'all');

    check_weights(weights);

end