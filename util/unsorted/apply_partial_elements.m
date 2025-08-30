function data = apply_partial_elements(data, idx_to_apply, method)

    % Apply the given method to the elements on the given indices
    data(idx_to_apply) = method(data(idx_to_apply));

end