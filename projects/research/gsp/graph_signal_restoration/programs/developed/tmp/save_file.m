function save_file(path_file, data)

    % Create directories if they don't exist
    path_directory = fileparts(path_file);

    if ~exist(path_directory, "dir"), mkdir(path_directory); end

    % Rename the input data using a struct
    [~, variable_name] = fileparts(path_file);
    structure.(variable_name) = data;

    % Save the data
    save(path_file, "-struct", "structure");

end