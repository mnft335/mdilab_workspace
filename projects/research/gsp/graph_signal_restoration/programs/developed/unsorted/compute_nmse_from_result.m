function nmse = compute_nmse_from_result(result)

    % Compute the NMSE
    nmse = arrayfun(@(result) compute_relative_error(result.solution.x{1}, result.object_collection.true_signal), result);

end