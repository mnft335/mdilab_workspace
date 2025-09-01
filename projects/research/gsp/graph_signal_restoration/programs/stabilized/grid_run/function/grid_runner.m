function grid_runner(param, arg)

    % Create all grid configurations
    grid_config_collection = generate_grid_config_collection(param, arg);

    % Ensure all true graphs exist
    ensure_true_graph_over_grid(grid_config_collection.grid_config_true_graph, arg);

    % Create an index grid of all parameter indices
    index_grid = create_index_grid(grid_config_collection);

    % Set up a "parfor" progress bar
    parfor_progress(numel(index_grid{1}));

    % Run optimizations in parallel
    parfor i = 1:numel(index_grid{1})

        % Create a "param" struct for this iteration
        param_single_run = create_param_on_grid(grid_config_collection, index_grid, i);

        % % Call the single runner
        single_runner(param_single_run, arg);

        % Update the "parfor" progress bar
        parfor_progress;

    end

    % Clean up the "parfor" progress bar
    parfor_progress(0);

end