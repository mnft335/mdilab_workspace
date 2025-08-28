function param_on_grid = generate_param_on_grid(param_template, grid_config)

    % Create a grid of parameter indices
    index_range = cellfun(@(z) 1:numel(z), grid_config.parameter_range, 'UniformOutput', false);
    index_grid = cell(1, numel(index_range));
    [index_grid{:}] = ndgrid(index_range{:});

    % Pre-allocate the output
    param_on_grid = cell(index_grid{1});

    % Create "param" structs for all parameter combinations
    for i = 1:numel(param_on_grid)

        % Start with the param template
        param = param_template;

        % Set each parameter
        for j = 1:numel(grid_config.parameter_name)

            % Get the path to the parameter in the nested struct
            path_parameter = grid_config.parameter_name{j};

            % Get the parameter to set
            parameter = grid_config.parameter_range{j}(index_grid{j}(i));

            param = setfield(param, param_path{:}, parameter);

        end

        % Store the param struct
        param_on_grid{i} = param;

    end

end