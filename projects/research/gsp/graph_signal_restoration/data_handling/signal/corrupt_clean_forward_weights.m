function corrupted_forward_weights = corrupt_clean_forward_weights(clean_forward_weights, generate_idx_clean_forward_weights_to_corrupt, generate_noise, apply_noise)

    % Extract clean forward weights to corrupt
    idx_clean_forward_weights_to_corrupt = generate_idx_clean_forward_weights_to_corrupt(clean_forward_weights);
    clean_forward_weights_to_corrupt = clean_forward_weights(idx_clean_forward_weights_to_corrupt);

    % Generate noise for the corruption
    noise = generate_noise(clean_forward_weights_to_corrupt);

    % Apply the generated noise to the clean forward weights to corrupt
    corrupted_forward_weights = clean_forward_weights;
    apply_noise(corrupted_forward_weights(idx_clean_forward_weights_to_corrupt), noise);

end