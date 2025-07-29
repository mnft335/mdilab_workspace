    function weights = multiply_truncated_normal_noise(stream, weights, idx_corrupted_weights, sigma)

        % Create a normal diistribution object truncated at 0
        truncated_normal_distribution = truncate(makedist("Normal", "mu", 0, "sigma", sigma), 0, Inf);

        % Sample noises on the forward edges (idx_corrupted_weights) from a normal distribution truncated at 0, using the inverse transform sampling
        noise = zeros(size(weights));
        noise(idx_corrupted_weights) = icdf(truncated_normal_distribution, rand(stream, numel(idx_forward_corrupted_weights), 1));

        % Set noises on the backward edges symmetrically
        noise = noise + noise.';

        % Multiply the noise to the weights
        weights = weights .* noise;
        
    end