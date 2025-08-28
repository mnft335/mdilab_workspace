function corrupted_forward_weights = add_noise(forward_weights, generate_noise)

    % Generate noise
    noise = generate_noise(forward_weights);

    % Add the noise to the forward weights
    corrupted_forward_weights = forward_weights + noise;

end