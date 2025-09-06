function index_grid = create_index_grid(grid_config)

    % Create a grid of parameter indices
    index_range = cellfun(@(z) 1:numel(z), grid_config.parameter_range, 'UniformOutput', false);
    index_grid = cell(1, numel(index_range));
    [index_grid{:}] = ndgrid(index_range{:});

end