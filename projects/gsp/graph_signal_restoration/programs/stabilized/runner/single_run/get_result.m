% Get the solution and objects of a single run based on the given parameter collection and optional arguments
function result = get_result(param_collection, arg)

    % Create all configurations
    config_collection = create_config_collection(param_collection, arg);

    % Create all objects
    result.object_collection = create_object_collection(config_collection);

    % Create a path to the solution
    path_solution = create_path_solution(config_collection);

    % Load the solution if it exists
    if exist(path_solution, "file")

        result.solution = load_file(path_solution);

    % Calculate and save the solution otherwise
    else

        % Solve the optimization problem
        result.solution = solve_optimization(result.object_collection);

        % Save the solution
        save_file(result.solution, path_solution);

    end

end