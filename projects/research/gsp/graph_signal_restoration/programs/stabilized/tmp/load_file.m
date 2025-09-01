function data = load_file(path_file)

    % Raise an error if a file does not exist
    if ~exist(path_file, "file"), error("File does not exist: %s", path_file); end

    % Get the variable name
    [~, variable_name] = fileparts(path_file);

    % Load the data from the file into a struct
    loaded_data = load(path_file, variable_name);

    % Return the intended variable
    data = loaded_data.(variable_name);

end