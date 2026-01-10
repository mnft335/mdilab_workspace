% Get the result of a single run based on the given parameter collection and optional arguments
function result = get_result(param_collection, arg)

    % Create all configurations
    config_collection = create_config_collection(param_collection, arg);

    % Create a file path to store the results
    path_result = create_path_result(config_collection);

    % Create all objects
    result.object_collection = create_object_collection(config_collection);

    % Load the result if it exists and return it
    if exist(path_result, "file")

        result.solution = load_file(path_result);

    % Generate and save the result if it does not exist
    else

        % Solve the optimization problem
        result.solution = result.object_collection.optimization.solver(result.object_collection.optimization.config_solver);

        % Save the result
        save_file(result.solution, path_result);

    end

end