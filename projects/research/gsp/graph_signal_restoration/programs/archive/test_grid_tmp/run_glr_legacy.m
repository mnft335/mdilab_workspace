function result = run_glr(master_seed, ratio_corrupted_weights, ratio_masked_nodes, standard_deviation_signal_noise)

    % gsp_start();
    
    % Get RandStream objects assigned uniquely to each random value generator
    stream_ids = get_stream_ids();
    streams = create_streams(stream_ids, master_seed);

    % Load a graph adjacency W
    load(path_search("Rome"));
    adjacency = W;

    % Generate a clean graph
    generate_clean_forward_weights = @(size) sample_gaussian(streams("generate_clean_forward_weights:normal"), size);
    clean_weight_matrix = generate_clean_weight_matrix(adjacency, generate_clean_forward_weights);
    clean_graph = create_graph(clean_weight_matrix);

    % Generate a graph signal from the clean graph
    num_sampled_frequencies = 15;
    generate_signal_sampling_coefficients = @(size) sample_gaussian(streams("generate_signal_sampling_coefficients:normal"), size);
    generate_raw_signal = @() sample_low_frequency_components(clean_graph, num_sampled_frequencies, generate_signal_sampling_coefficients);
    true_signal = generate_clean_signal(generate_raw_signal);

    % Generate a corrupted graph
    generate_corrupted_weight_indices = @(forward_weights) sample_indices(streams("generate_corrupted_weight_indices:permutation"), numel(forward_weights), int64(numel(forward_weights) * ratio_corrupted_weights));
    generate_corrupted_forward_weights = @(forward_weights_to_corrupt) sample_gaussian(streams("generate_corrupted_forward_weights:normal"), [numel(forward_weights_to_corrupt), 1]);
    corrupted_weight_matrix = generate_corrupted_weight_matrix(clean_weight_matrix, generate_corrupted_weight_indices, generate_corrupted_forward_weights);
    corrupted_graph = create_graph(corrupted_weight_matrix);

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

    % Define operators in the PDS
    formulation_specifics.apply_root_laplacian = @(z) sqrt(corrupted_graph.e) .* corrupted_graph.U.' * z;
    formulation_specifics.apply_root_laplacian_transpose = @(z) corrupted_graph.U * (sqrt(corrupted_graph.e) .* z);

    % Formulation parameters
    formulation_specifics.signal_lower_bound = 0;
    formulation_specifics.signal_upper_bound = 1;
    coefficient_radius_l2_ball = 0.9;
    formulation_specifics.radius_l2_ball = coefficient_radius_l2_ball * sqrt(double(num_nodes - num_masked_nodes)) * standard_deviation_signal_noise;
    formulation_specifics.coefficient_l2 = 1 / 2;

    % Define pds_specifics
    pds_specifics.step_size_primal_variable = 1 / (1 + sqrt(corrupted_graph.lmax));
    pds_specifics.step_size_dual_variable_l2_ball = 1;
    pds_specifics.step_size_dual_variable_l2 = 1 / sqrt(corrupted_graph.lmax);
    pds_specifics.initial_primal_variable = zeros(num_nodes, 1);
    pds_specifics.initial_dual_variable_l2_ball = zeros(num_nodes, 1);
    pds_specifics.initial_dual_variable_l2 = zeros(num_nodes, 1);

    % Define solver_specifics
    tolerance = 1e-12;
    loop_specifics.stopping_criteria = @(config, state) is_converge_fixed_point_residual(config, state, tolerance);
    loop_specifics.before_iteration = @increment;
    loop_specifics.after_iteration = @compute_pds_residual;

    result = solve_glr(formulation_specifics, pds_specifics, loop_specifics);

end