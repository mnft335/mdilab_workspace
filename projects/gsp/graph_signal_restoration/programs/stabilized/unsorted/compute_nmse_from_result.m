function nmse = compute_nmse_from_result(result)

    % Compute the NMSE, keeeping the array shape
    nmse = arrayfun(@(each_result) compute_relative_error(each_result.solution.x{1}, each_result.object_collection.true_signal), result);

end