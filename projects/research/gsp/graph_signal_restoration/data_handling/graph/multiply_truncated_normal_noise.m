    function weights = multiply_truncated_normal_noise(weights, idx_corrupted_weights, sigma)

        % Create a normal diistribution object truncated at 0
        truncated_normal_distribution = truncate(makedist("Normal", "mu", 0, "sigma", sigma));

        % Sample noises on the forward edges from a normal distribution truncated at 0
        noise = zeros(size(weights));
        noise(idx_corrupted_weights) = random(truncated_normal_distribution, numel(idx_corrupted_weights), 1);

        % Set noises on the backward edges symmetrically
        noise = noise + noise.';

        % Multiply the noise to the weights
        weights = weights .* noise;
        
    end