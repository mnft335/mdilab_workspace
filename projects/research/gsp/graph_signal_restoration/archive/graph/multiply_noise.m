function corrupted_forward_weights = multiply_noise(forward_weights, generate_noise)

    % Generate noise
    noise = generate_noise(forward_weights);

    % Shift the noise to make them positive (strictly larger than eps)
    noise = noise + max(0, max(- noise + eps));

    % Multiply the noise to the weights
    corrupted_forward_weights = forward_weights .* noise;

end