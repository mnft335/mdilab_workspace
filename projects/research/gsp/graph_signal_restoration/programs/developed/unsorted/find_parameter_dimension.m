function dimension = find_parameter_dimension(grid_config, parameter_name)

    % Create a list of all parameter names in the grid configuration
    parameter_name_list = cellfun(@(x) strjoin([x{:}], '.'), grid_config.parameter_name, 'UniformOutput', false);

    % Find the dimension of the specified parameter in the grid
    dimension = find(ismember([parameter_name_list{:}], parameter_name), 1);

    if isempty(dimension), error('Parameter name "%s" not found in the grid configuration.', parameter_name); end

end