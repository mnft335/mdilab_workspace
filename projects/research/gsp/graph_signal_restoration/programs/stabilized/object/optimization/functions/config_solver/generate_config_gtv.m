function config_gtv = generate_config_gtv(graph, true_signal, observation_model)

    % Create operators in the PDS
    config_gtv.observation_operator = @(z) observation_model.observation_operator(z);
    config_gtv.observation_operator_adjoint = @(z) observation_model.observation_operator_adjoint(z);
    config_gtv.weighted_incidence_operator = @(z) sqrt(graph.weights) .* (graph.Diff * z);
    config_gtv.weighted_incidence_operator_adjoint = @(z) graph.Diff.' * (sqrt(graph.weights) .* z);

    % Create an observed signal
    config_gtv.observed_signal = observation_model.observation_operator(true_signal) + observation_model.signal_noise;

    % Formulation parameters
    norm_upper_bound_weighted_incidence_operator = sqrt(eigs(graph.Diff.' * diag(graph.weights) * graph.Diff, 1));
    config_gtv.signal_lower_bound = 0;
    config_gtv.signal_upper_bound = 1;
    config_gtv.radius_l2_ball = 0.9 * sqrt(sum(abs(observation_model.signal_noise) > eps)) * observation_model.std_dev_signal_noise;
    config_gtv.coefficient_l1 = 0.01 * norm_upper_bound_weighted_incidence_operator;

    % PDS configurations
    config_gtv.step_size_primal_variable = 1 / (1 + norm_upper_bound_weighted_incidence_operator);
    config_gtv.step_size_dual_variable_l2_ball = 1;
    config_gtv.step_size_dual_variable_l1 = 1 / norm_upper_bound_weighted_incidence_operator;
    config_gtv.initial_primal_variable = zeros(graph.N, 1);
    config_gtv.initial_dual_variable_l2_ball = zeros(graph.N, 1);
    config_gtv.initial_dual_variable_l1 = zeros(graph.Ne, 1);

    % Solver configurations
    tolerance = 1e-9;
    config_gtv.stopping_criteria = @(config, state) is_converge_fixed_point_residual(config, state, tolerance);
    config_gtv.before_iteration = @increment;
    config_gtv.after_iteration = @compute_pds_residual;

end