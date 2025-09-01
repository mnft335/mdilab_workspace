function save_file(data, path_file)

    % Create directories if they don't exist
    path_directory = fileparts(path_file);
    if ~exist(path_directory, "dir"), mkdir(path_directory); end

    % Get the variable name
    [~, variable_name] = fileparts(path_file);

    % Rename the input data as intended
    structure.(variable_name) = data;

    % Save the data
    save(path_file, "-struct", "structure");

end