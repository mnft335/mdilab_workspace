function weights_forward = generate_truncated_normal_weights(stream, idx_forward_edges, sigma)

    % Create a normal distribution object truncated at 0
    truncated_normal_distribution = truncate(makedist("Normal", "mu", 0, "sigma", sigma), 0, Inf);

    % Sample weights on the forward edges from the Gaussian distribution, usign the inverse transform sampling
    weights_forward = icdf(truncated_normal_distribution, rand(stream, numel(idx_forward_edges), 1));

end