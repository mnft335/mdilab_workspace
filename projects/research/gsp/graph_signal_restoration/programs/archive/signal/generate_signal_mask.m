function mask = generate_signal_mask(true_signal, generate_idx_masked_nodes)

    % Generate a mask
    mask = ones(true_signal, 1);
    idx_masked_nodes = generate_idx_masked_nodes(true_signal);

    mask(idx_masked_nodes) = 0;

end