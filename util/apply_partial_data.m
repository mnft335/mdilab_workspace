function data = apply_partial_data(data, idx_to_apply, method)

    % Apply the given method to the data on the given indices
    data(idx_to_apply) = method(data(idx_to_apply));

end