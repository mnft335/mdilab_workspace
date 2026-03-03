% Create a path to the solution given a configuration collection
function path_solution = create_path_solution(config_collection)

% Get the path collection
path_collection = get_path_collection();

% Create a path to the solution directory
path_solution_directory = fullfile(path_collection.solution_registry, create_path_from_configuration(config_collection.configuration_name));

% Create a path to the solution file
path_solution = fullfile(path_solution_directory, "solution.mat");

end