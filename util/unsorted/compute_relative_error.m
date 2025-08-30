function relative_error = compute_relative_error(x1, x2)

    % Compute relative error
    relative_error = norm(x1(:) - x2(:)) / norm(x2(:));

end