function weights = add_normal_noise(stream, weights, idx_corrupted_weights, sigma)

    % Sample noises on the forward edges (idx_corrupted_weights) from a normal distribution
    noise = zeros(size(weights));
    noise(idx_corrupted_weights) = sigma * randn(stream, numel(idx_corrupted_weights), 1);

    % Set noises on the backward edges symmetrically
    noise = noise + noise.';

    % Add the noies to the weights
    weights = weights + noise;

end