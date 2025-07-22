function weights = add_normal_noise(weights, idx_corrupted_weights, sigma)

    % Sample noises on the forward edges (idx_corrupted_weights) from a normal distribution
    noise = zeros(size(weights));
    noise(idx_corrupted_weights) = sigma * randn(numel(idx_corrupted_weights), 1);

    % Shift the noise to make them positive (larger than eps)
    noise(idx_corrupted_weights) = noise(idx_corrupted_weights) + abs(min(0, noise(idx_corrupted_weights))) + eps;

    % Set noises on the backward edges symmetrically
    noise = noise + noise.';

    % Add the noies to the weights
    weights = weights + noise;

end