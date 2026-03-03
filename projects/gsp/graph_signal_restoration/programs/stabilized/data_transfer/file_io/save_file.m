% Save a variable to the specified file on the given path
function save_file(variable, path_file)

% Create directories if they don't exist
path_directory = fileparts(path_file);
if ~exist(path_directory, "dir"), mkdir(path_directory); end

% Get the variable name, which is supposed to be the same as the file name
[~, variable_name] = fileparts(path_file);

% Rename the input variable as intended
data.(variable_name) = variable;

% Save the data
save(path_file, "-struct", "data");

end