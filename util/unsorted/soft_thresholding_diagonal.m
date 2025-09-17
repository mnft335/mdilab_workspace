function result = soft_thresholding_diagonal(x, diagonal_entries)

    % Apply soft thresholding to the input with a diagonal matrix of thresholds
    result = sign(x) .* max(abs(x) - diagonal_entries, 0);

end