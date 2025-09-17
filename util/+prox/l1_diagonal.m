function result = l1_diagonal(x, gamma, lambda, diagonal_entries)

    % Apply soft thresholding to the input, with the thresholds multiplied by diagonal_entries
    result = soft_thresholding_diagonal(x, gamma * lambda * diagonal_entries);

end