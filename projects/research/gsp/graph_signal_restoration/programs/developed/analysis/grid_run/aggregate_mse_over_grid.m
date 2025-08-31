function mse_over_grid = aggregate_mse_over_grid(param, arg)

    % Create all grid configurations
    grid_config_collection = generate_grid_config_collection(param, arg);

    % Create an index grid of all parameter indices
    index_grid = create_index_grid(grid_config_collection);

    % Set up a "parfor" progress bar
    parfor_progress(numel(index_grid{1}));

    % Preallocate result array
    mse_over_grid = zeros(size(index_grid{1}));

    % Load results in parallel
    parfor i = 1:numel(index_grid{1})

        % Create a "param" struct for this iteration
        param_single_run = create_param_on_grid(grid_config_collection, index_grid, i);

        % Create all configurations for this iteration
        config_collection = generate_config_collection(param_single_run, arg);

        % Load the result
        result = load_result(config_collection);

        % Calculate MSE
        mse_over_grid(i) = compute_mse(result, param_single_run);

        % Update the "parfor" progress bar
        parfor_progress;

    end

    % Clean up the "parfor" progress bar
    parfor_progress(0);

end

function mse = compute_mse(result, param)

    % Create all configurations
    config_collection = generate_config_collection(param, []);

    % Create all objects
    object_collection = generate_object_collection(config_collection);

    % Compute MSE between the true signal and the restored signal
    mse = compute_relative_error(result.x{1}, object_collection.true_signal)

end