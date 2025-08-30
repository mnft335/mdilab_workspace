function single_runner(param, arg)

    % Create all configurations
    config_collection = generate_config_collection(param, arg);

    % Create a file path to store the results
    path_result = create_path_result(config_collection);

    % Do nothing if the result already exists
    if exist(path_result, "file"), return; end

    % Create all objects
    object_collection = generate_object_collection(config_collection);

    % Solve the optimization problem
    result = object_collection.optimization.solver(object_collection.optimization.config_solver);

    % Save the result
    save_file(result, path_result);

end