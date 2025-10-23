function sliced_array = extract_elements(array, idx, dim)

    % Create an array of index ranges for each dimension
    index_range = arrayfun(@(length) 1:length, size(array), 'UniformOutput', false);

    % Replace the index range for the specified dimension with the specified index
    index_range{dim} = idx;

    % Create an index grid
    index_grid = cell(1, ndims(array));
    [index_grid{:}] = ndgrid(index_range{:});

    % Extract the elements of interest
    sliced_array = array(sub2ind(size(array), index_grid{:}));

end
