function weights = initialize_weights(weights, signal, variance)

    % num_edges = numel(find(triu(weights, 1)));
    % adjacency = weights > 0;
    % squared_difference = (signal - signal.').^2;
    % weights = exp(- squared_difference / (2 * variance));
    % weights = weights .* num_edges / sum(weights, 'all');
    % weights = weights .* adjacency;

    [row, column] = find(triu(weights, 1));
    num_edges = numel(row);
    upper_weights = randn(num_edges, 1);
    weights(sub2ind(size(weights), row, column)) = upper_weights;
    weights = weights + weights.';
    weights = weights .* num_edges ./ sum(weights, 'all');

end