clear;
gsp_start();

% Load the result array
load("C:\Users\Owner\Downloads\research\mdilab\programs\projects\research\gsp\graph_signal_restoration\results\test_grid.mat");

% The grid used in the test
range_master_seed = 1:10;
range_ratio_corrupted_weights = [0.0, 0.5, 1.0];
range_standard_deviation_weight_noise = 0.0:0.05:0.1;
range_ratio_masked_nodes = 0.0:0.2:0.4;
range_standard_deviation_signal_noise = 0.0:0.05:0.1;
[grid_master_seed, grid_ratio_corrupted_weights, grid_standard_deviation_weight_noise, grid_ratio_masked_nodes, grid_standard_deviation_signal_noise] = ndgrid(1:numel(range_master_seed), 1:numel(range_ratio_corrupted_weights), 1:numel(range_standard_deviation_weight_noise), 1:numel(range_ratio_masked_nodes), 1:numel(range_standard_deviation_signal_noise));

% The parameters of interest
master_seed = 1;
ratio_corrupted_weights = 1.0;
standard_deviation_weight_noise = 0.0;
ratio_masked_nodes = 0.4;
standard_deviation_signal_noise = 0.05;

% Find the indices in the grid corresponding to the parameters of interest
idx_master_seed = find(range_master_seed == master_seed);
idx_ratio_corrupted_weights = find(range_ratio_corrupted_weights == ratio_corrupted_weights);
idx_standard_deviation_weight_noise = find(range_standard_deviation_weight_noise == standard_deviation_weight_noise);
idx_ratio_masked_nodes = find(range_ratio_masked_nodes == ratio_masked_nodes);
idx_standard_deviation_signal_noise = find(range_standard_deviation_signal_noise == standard_deviation_signal_noise);

% Extract the result for the specified parameters
% result_of_interest = result{idx_standard_deviation_signal_noise, idx_ratio_masked_nodes, idx_ratio_corrupted_weights, idx_master_seed};
result_of_interest = result{sub2ind(size(grid_master_seed), idx_master_seed, idx_ratio_corrupted_weights, idx_standard_deviation_weight_noise, idx_ratio_masked_nodes, idx_standard_deviation_signal_noise)};

% Get RandStream objects assigned uniquely to each random value generator
stream_ids = get_stream_ids();
streams = create_streams(stream_ids, master_seed);

% Load clean and corrupted graphs
path_programs_to_directory = fullfile("projects", "research", "gsp", "graph_signal_restoration", "synthesized_graph", num2str(master_seed), num2str(ratio_corrupted_weights), num2str(standard_deviation_weight_noise));
load(fullfile(path_programs_to_directory, "clean_graph.mat"));
load(fullfile(path_programs_to_directory, "corrupted_graph.mat"));

% Generate a graph signal from the clean graph
num_sampled_frequencies = 15;
generate_signal_sampling_coefficients = @(size) sample_gaussian(streams("generate_signal_sampling_coefficients:normal"), size);
generate_raw_signal = @() sample_low_frequency_components(clean_graph, num_sampled_frequencies, generate_signal_sampling_coefficients);
true_signal = generate_clean_signal(generate_raw_signal);

% Generate a linear observation operator and its transpose
num_nodes = corrupted_graph.N;
num_masked_nodes = int64(ratio_masked_nodes * num_nodes);
generate_masked_signal_indices = @(size) sample_indices(streams("generate_masked_signal_indices:permutation"), size, num_masked_nodes);
mask = generate_signal_mask(num_nodes, generate_masked_signal_indices);
formulation_specifics.apply_observation_operator = @(z) mask .* z;
formulation_specifics.apply_observation_operator_transpose = @(z) mask .* z;

% Generate an observed signal
generate_signal_noise = @(size) standard_deviation_signal_noise * sample_gaussian(streams("generate_signal_noise:normal"), size);
formulation_specifics.observed_signal = generate_observed_signal(true_signal, formulation_specifics.apply_observation_operator, generate_signal_noise);

% Plot the results
load(path_search("Rome"));
clean_weight_matrix = clean_graph.W;
clean_graph = gsp_graph(clean_weight_matrix, pos);
plot_graph(clean_graph, true_signal, formulation_specifics.observed_signal, result_of_interest.x{1});
disp("MSE: " + num2str(compute_relative_error(result_of_interest.x{1}, true_signal)));