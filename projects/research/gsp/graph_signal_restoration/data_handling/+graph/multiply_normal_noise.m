function weights = multiply_normal_noise(stream, weights, idx_corrupted_weights, sigma)

    % Sample noises on the forward edges (idx_corrupted_weights) from a normal distribution
    noise = zeros(size(weights));
    noise(idx_corrupted_weights) = sigma + randn(stream, numel(idx_corrupted_weights), 1);

    % Shift the noise to make them positive (larger than eps)
    noise(idx_corrupted_weights) = noise(idx_corrupted_weights) + max(0, max(- noise(idx_corrupted_weights))) + eps;

    % Set noises on the backward edges symmetrically
    noise = noise + noise.';

    % Multiply the noise to the weights
    weights = weights .* noise;

end