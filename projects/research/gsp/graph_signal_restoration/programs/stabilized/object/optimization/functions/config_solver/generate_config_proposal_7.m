function config_proposal_7 = generate_config_proposal_7(graph, true_signal, observation_model, coefficient_huber, threshold_huber)

    % Create operators in the PDS
    incidence_matrix = sign(graph.Diff) .* double(graph.Diff ~= 0);
    config_proposal_7.observation_operator = @(z) observation_model.observation_operator(z);
    config_proposal_7.observation_operator_adjoint = @(z) observation_model.observation_operator_adjoint(z);
    config_proposal_7.laplacian_operator = @(z) graph.L * z;
    config_proposal_7.laplacian_operator_adjoint = @(z) graph.L' * z;
    config_proposal_7.incidence_operator = @(z) incidence_matrix * z;
    config_proposal_7.incidence_operator_adjoint = @(z) incidence_matrix' * z;

    % Create an observed signal
    config_proposal_7.observed_signal = observation_model.observation_operator(true_signal) + observation_model.signal_noise;

    % Formulation parameters
    config_proposal_7.signal_lower_bound = 0;
    config_proposal_7.signal_upper_bound = 1;
    config_proposal_7.radius_l2_ball = 0.9 * sqrt(sum(abs(observation_model.signal_noise) > eps)) * observation_model.std_dev_signal_noise;
    config_proposal_7.threshold_huber = threshold_huber;
    config_proposal_7.coefficient_huber = coefficient_huber;

    % PDS configurations
    norm_upper_bound_incidence_operator = sqrt(eigs(incidence_matrix.' * incidence_matrix, 1));
    config_proposal_7.step_size_primal_variable_signal = 1 / (1 + graph.lmax);
    config_proposal_7.step_size_primal_variable_infimal_convolution = 1 / norm_upper_bound_incidence_operator;
    config_proposal_7.step_size_dual_variable_l2_ball = 1;
    config_proposal_7.step_size_dual_variable_l2 = 1 / (graph.lmax + norm_upper_bound_incidence_operator);
    config_proposal_7.initial_primal_variable_signal = zeros(graph.N, 1);
    config_proposal_7.initial_primal_variable_infimal_convolution = zeros(graph.Ne, 1);
    config_proposal_7.initial_dual_variable_l2_ball = zeros(graph.N, 1);
    config_proposal_7.initial_dual_variable_l2 = zeros(graph.N, 1);

    % Solver configurations
    tolerance = 1e-9;
    config_proposal_7.stopping_criteria = @(config, state) is_converge_fixed_point_residual(config, state, tolerance);
    config_proposal_7.before_iteration = @increment;
    config_proposal_7.after_iteration = @compute_pds_residual;

end