function sliced_array = extract_elements(array, idx, dim)

    % Create an array of index ranges for each dimension
    index_range = arrayfun(@(length) 1:length, size(array), 'UniformOutput', false);

    % Replace the index range for the specified dimension with 1, as it is supposed to be unique for every combination of other dimensions
    index_range{dim} = 1;

    % Create an index grid
    index_grid = cell(1, ndims(array));
    [index_grid{:}] = ndgrid(index_range{:});

    % Replace the index grid for the specified dimension with the given index
    index_grid{dim} = idx;

    % Extract the elements of interest
    sliced_array = array(sub2ind(size(array), index_grid{:}));

end
