function check_weights(weights)

    assert(all(isfinite(weights), 'all'), "The weight matrix is not finite");
    assert(all(diag(weights) == 0, 'all'), "The diagonal is not zero");
    assert(size(weights, 1) == size(weights, 2), "The weight matrix is not square");
    assert(norm(weights - weights.', 'fro') < 1e-8, "The weight matrix is not symmetric");
    assert(all(weights(~eye(size(weights))) >= 0, 'all'), "The off-diagonal is not positive");

end