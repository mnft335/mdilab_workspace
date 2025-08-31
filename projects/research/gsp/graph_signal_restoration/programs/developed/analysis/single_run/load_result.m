function result = load_result(param, arg)

    % Create all configurations
    config_collection = generate_config_collection(param, arg);

    % Create a path to the result
    path_result = create_path_result(config_collection);

    % Load the result
    load(path_result);

end