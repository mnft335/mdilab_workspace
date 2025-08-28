function corrupted_forward_weights = corrupt_selected_forward_weights(forward_weights, corrupt_forward_weights, generate_idx_forward_weights_to_corrupt)

    % Get the indices of the corrupted forward weights
    idx_forward_weights_to_corrupt = generate_idx_forward_weights_to_corrupt(forward_weights);

    % Corrupt the selected forward weights
    forward_weights(idx_forward_weights_to_corrupt) = corrupt_forward_weights(forward_weights(idx_forward_weights_to_corrupt));
    corrupted_forward_weights = forward_weights;

end