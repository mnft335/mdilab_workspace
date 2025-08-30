function check_weight_matrix(weight_matrix)

    % Check whether a weight matrix is valid
    assert(all(isfinite(weight_matrix), 'all'), "The weight matrix is not finite");
    assert(all(diag(weight_matrix) == 0, 'all'), "The diagonal is not zero");
    assert(size(weight_matrix, 1) == size(weight_matrix, 2), "The weight matrix is not square");
    assert(norm(weight_matrix - weight_matrix.', 'fro') < 1e-8, "The weight matrix is not symmetric");
    assert(all(weight_matrix(~eye(size(weight_matrix))) >= 0, 'all'), "The off-diagonal is not positive");

end