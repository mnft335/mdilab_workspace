% Create a grid of parameter indices
function index_grid = create_index_grid(grid_config)

    % Create a cell array of indices for each parameter
    index_range = cellfun(@(z) 1:numel(z), grid_config.parameter_range, 'UniformOutput', false);

    % Preallocate a cell array to capture the output of "ndgrid"
    index_grid = cell(1, numel(index_range));

    % Create the grid
    [index_grid{:}] = ndgrid(index_range{:});

end