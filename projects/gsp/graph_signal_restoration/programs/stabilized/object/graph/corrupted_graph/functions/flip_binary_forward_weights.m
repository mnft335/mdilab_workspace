function flipped_binary_forward_weights = flip_binary_forward_weights(binary_forward_weights, minimum, maximum)

    % Flip the binary forward weights
    flipped_binary_forward_weights = (maximum + minimum) - binary_forward_weights;

end