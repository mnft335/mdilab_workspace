function weights = add_truncated_normal_noise(stream, weights, idx_corrupted_weights, sigma)
    
    % Function that creates normal distributions truncated at the input
    truncated_normal_distribution = @(z) truncate(makedist("Normal", "mu", 0, "sigma", sigma), - z, Inf);

    % Sample noises on the forward edges (idx_currupted_weights) from normal distributions truncated at each weight, using the inverse transform sampling
    noise = zeros(size(weights));
    noise(idx_corrupted_weights) = arrayfun(@(z) icdf(truncated_normal_distribution(z), rand(stream)), weights(idx_corrupted_weights));

    % Set noises on the backward edges symmetrically
    noise = noise + noise.';

    % Add the noise to the weights
    weights = weights + noise;

end