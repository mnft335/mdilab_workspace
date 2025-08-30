function corrupted_forward_weights = corrupt_selected_forward_weights(forward_weights, corrupt_forward_weights, generate_idx_forward_weights_to_corrupt)

    % Generate the indices of the corrupted forward weights
    idx_forward_weights_to_corrupt = generate_idx_forward_weights_to_corrupt(forward_weights);

    % Corrupt forward weights on partial indices
    corrupted_forward_weights = apply_partial_elements(forward_weights, idx_forward_weights_to_corrupt, corrupt_forward_weights);

end