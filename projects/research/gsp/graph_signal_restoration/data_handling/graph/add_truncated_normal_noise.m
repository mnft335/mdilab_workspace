function weights = add_truncated_normal_noise(weights, idx_corrupted_weights, sigma)

    % Function that creates normal distributions truncated at the input
    normal_distribution = makedist("Normal", "mu", 0, "sigma", sigma);
    truncated_normal_distribution = @(z) truncate(normal_distribution, - z, Inf);

    % Sample noises on the forward edges (idx_currupted_weights) from normal distributions truncated at each weight
    noise = zeros(size(weights));
    noise(idx_corrupted_weights) = arrayfun(@(z) random(truncated_normal_distribution(z)), weights(idx_corrupted_weights));

    % Set noises on the backward edges symmetrically
    noise = noise + noise.';

    % Add the noise to the weights
    weights = weights + noise;

end