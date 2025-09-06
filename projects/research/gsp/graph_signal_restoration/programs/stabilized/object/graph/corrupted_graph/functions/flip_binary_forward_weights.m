function flipped_binary_forward_weights = flip_binary_forward_weights(binary_forward_weights)

    % Get the binary values
    minimum = min(binary_forward_weights);
    maximum = max(binary_forward_weights);

    % Flip the binary forward weights
    flipped_binary_forward_weights = (maximum + minimum) - binary_forward_weights;

end