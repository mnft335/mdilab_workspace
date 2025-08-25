clear;
gsp_start();

% Define the parameter ranges to search
range_master_seed = 1:10;
range_ratio_masked_nodes = 0.0:0.2:0.4;
range_standard_deviation_signal_noise = 0.0:0.05:0.1;

% Create clean and corrupted graphs beforehand

% Define a graph adjacency
load(path_search("Rome"));
adjacency = W;

for i = 1:numel(range_master_seed)

    % Extract the parameters for this iteration
    master_seed = range_master_seed(i);

    % Get RandStream objects assigned uniquely to each random value generator
    stream_ids = get_stream_ids();
    streams = create_streams(stream_ids, master_seed);

    num2str_safe = @(z) strrep(num2str(z), '.', '_');
    path_programs_to_directory = fullfile("projects", "research", "gsp", "graph_signal_restoration", "synthesized_graph", num2str(master_seed));

    % Load a clean graph if it exists
    if exist(fullfile(path_programs_to_directory, "clean_graph.mat"))
        
        load(fullfile(path_programs_to_directory, "clean_graph.mat"));

    % Generate a clean graph if it doesn't exist
    else
        
        % Create directories if they don't exist
        if ~exist(path_programs_to_directory), mkdir(path_programs_to_directory); end

        % Generate and store a clean graph
        generate_clean_forward_weights = @(size) sample_gaussian(streams("generate_clean_forward_weights:normal"), size);
        clean_weight_matrix = generate_clean_weight_matrix(adjacency, generate_clean_forward_weights);
        clean_graph = create_graph(clean_weight_matrix);

        save(fullfile(path_programs_to_directory, "clean_graph.mat"), "clean_graph");

    % Load a corrupted graph if it exists
    if exist(fullfile(path_programs_to_directory, "all1", "corrupted_graph.mat"))
        
        load(fullfile(path_programs_to_directory, "all1", "corrupted_graph.mat"));

    % Create a corrupted graph if it doesn't exist
    else 

        % Create directories if they don't exist
        if ~exist(fullfile(path_programs_to_directory, "all1")), mkdir(fullfile(path_programs_to_directory, "all1")); end

        % Set the corrupted graph to have the weights of all 1
        corrupted_weight_matrix = double(adjacency);
        corrupted_graph = create_graph(corrupted_weight_matrix);

        save(fullfile(path_programs_to_directory, "all1", "corrupted_graph.mat"), "corrupted_graph");

        end
    end
end

[grid_master_seed, grid_ratio_masked_nodes, grid_standard_deviation_signal_noise] = ndgrid(1:numel(range_master_seed), 1:numel(range_ratio_masked_nodes), 1:numel(range_standard_deviation_signal_noise));
result = cell(numel(range_master_seed), numel(range_ratio_masked_nodes), numel(range_standard_deviation_signal_noise));

parfor i = 1:numel(grid_master_seed)

    % Extract the parameters for this iteration
    master_seed = range_master_seed(grid_master_seed(i));
    ratio_masked_nodes = range_ratio_masked_nodes(grid_ratio_masked_nodes(i));
    standard_deviation_signal_noise = range_standard_deviation_signal_noise(grid_standard_deviation_signal_noise(i));

    % Run the GLR solver with the current parameters
    result{i} = run_glr_all1(master_seed, ratio_masked_nodes, standard_deviation_signal_noise);
    disp("Done!");
    
end

% Save or process the result as needed
save("C:\Users\Owner\Downloads\research\mdilab\programs\projects\research\gsp\graph_signal_restoration\results\test_grid_all1.mat", "result");