% Load a variable from the specified file on the given path
function variable = load_file(path_file)

% Raise an error if a file does not exist
if ~exist(path_file, "file"), error("File does not exist: %s", path_file); end

% Get the variable name, which is supposed to be the same as the file name
[~, variable_name] = fileparts(path_file);

% Load data from the file into a struct
loaded_data = load(path_file, variable_name);

% Return the intended variable
variable = loaded_data.(variable_name);

end