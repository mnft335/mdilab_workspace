function path_result = create_path_result(config_collection)

    % Get the path collection
    path_collection = get_path_collection();

    % Create a path to the result directory
    path_result_directory = fullfile(path_collection.result_registry, create_path_from_configuration(config_collection.configuration_name));

    % Create a path to the result file
    path_result = fullfile(path_result_directory, "result.mat");

end