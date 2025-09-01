function result = load_result(config_collection)

    % Create a path to the result
    path_result = create_path_result(config_collection);

    % Load the result
    result = load_file(path_result);

end