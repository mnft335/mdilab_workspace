function noise = generate_normal_noise(stream, forward_weights, sigma)

    % Sample noises on the forward edges (idx_corrupted_weights) from a normal distribution
    noise = sigma * randn(stream, size(forward_weights));

end