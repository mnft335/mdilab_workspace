function sliced_array = extract_elements(array, idx, dim)

    % Create an index grid for the array of extracted elements
    index_range = arrayfun(@(length) 1:length, size(idx), 'UniformOutput', false);
    index_grid = cell(1, ndims(array));
    [index_grid{:}] = ndgrid(index_range{:});

    % Replace the index grid for the specified dimension with the given index
    index_grid{dim} = idx;

    % Extract the elements of interest
    sliced_array = array(sub2ind(size(array), index_grid{:}));

end