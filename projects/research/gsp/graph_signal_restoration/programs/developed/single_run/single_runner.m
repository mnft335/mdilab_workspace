function single_runner(param, path)

    % Get all configurations
    all_config = generate_all_config(param);

    % Create a file path to store the results
    path_result= fullfile(path.path_result_registry, create_path(all_config.configuration_name), "result.mat");

    % Return the result if it exists
    if exist(path_result, "file"), return; end

    % Get all data
    all_data = generate_all_data(all_config, path.path_true_graph_registry);

    % Solve the optimization problem
    result = all_data.optimization.solver(all_data.optimization.config_solver);

    % Save the result
    save_file(path_result, result);

end