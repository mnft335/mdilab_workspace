function ensure_grid_result(grid_param_collection, mode, arg)
    
    % Create all grid configurations
    grid_config_collection = generate_grid_config_collection(grid_param_collection, arg);

    % Ensure all true graphs exist
    ensure_true_graph_over_grid(grid_config_collection.grid_config_true_graph, arg);

    % Create an index grid of all parameter indices
    index_grid = create_index_grid(grid_config_collection);

    switch mode

        case "serial"

        % Set up a "parfor" progress bar
        parfor_progress(numel(index_grid{1}));

            % Run optimizations in serial
            for i = 1:numel(index_grid{1})

                result = get_result_on_grid(grid_config_collection, index_grid, i, arg);

                % Update the "parfor" progress bar
                parfor_progress;

            end

            % Clean up the "parfor" progress bar
            parfor_progress(0);

        case "parallel"

            % Set up a "parfor" progress bar
            parfor_progress(numel(index_grid{1}));

            % Run optimizations in parallel
            parfor i = 1:numel(index_grid{1})

                result = get_result_on_grid(grid_config_collection, index_grid, i, arg);

                % Update the "parfor" progress bar
                parfor_progress;

            end

            % Clean up the "parfor" progress bar
            parfor_progress(0);

        otherwise

            error('Invalid mode. Use "serial" or "parallel".');

    end