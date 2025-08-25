function corrupted_forward_weights = add_forward_weight_noise(forward_weights, generate_forward_weight_noise)

    % Generate forward weight noise
    forward_weight_noise = generate_forward_weight_noise(forward_weights);

    % Add the noise to the forward weights
    corrupted_forward_weights = forward_weights + forward_weight_noise;

end