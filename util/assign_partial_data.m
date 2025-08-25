function data = assign_partial_data(data, idx_to_assign, data_to_assign)

    % Assign values to the data array based on the mask
    data(idx_to_assign) = data_to_assign;
    
end