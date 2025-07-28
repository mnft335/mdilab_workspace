function mask = generate_signal_mask(stream, size, masking_rate)

    % Generate a mask
    mask = ones(size, 1);
    idx_masked = randperm(stream, size, int64(size * masking_rate));

    mask(idx_masked) = 0;

end