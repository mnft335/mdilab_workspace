function weights = additive_corruption(weights, sigma)

    % Find the indices of the forward edges (edges in the upper triangular part)
    idx_forward_edges = find(triu(weights, 1));

    % Function that creates normal distributions truncated at the input
    normal_distribution = makedist("Normal", "mu", 0, "sigma", sigma);
    truncated_normal_distribution = @(z) truncate(normal_distribution, z, Inf);

    % Sample noises on the forward edges from normal distributions truncated at each weight
    noise = zeros(size(weights));
    noise(idx_forward_edges) = arrayfun(@(z) random(truncated_normal_distribution(z)), weights(idx_forward_edges));

    % Set noises on the backward edges symmetrically
    noise = noise + noise.';

    % Add the noise to the weights
    weights = weights + noise;

    % Normalize the weights to mean 1
    weights = weights / mean(weights(weights ~= 0), 'all');

    check_weights(weights);

end