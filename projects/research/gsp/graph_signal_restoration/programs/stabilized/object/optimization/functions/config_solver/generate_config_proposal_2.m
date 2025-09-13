function config_proposal_2 = generate_config_proposal_2(graph, true_signal, observation_model, coefficient_l1)

    % Create operators in the PDS
    config_proposal_2.observation_operator = @(z) observation_model.observation_operator(z);
    config_proposal_2.observation_operator_adjoint = @(z) observation_model.observation_operator_adjoint(z);
    config_proposal_2.gradient_operator = @(z) graph.Diff * z;
    config_proposal_2.gradient_operator_adjoint = @(z) graph.Diff.' * z;

    % Create an observed signal
    config_proposal_2.observed_signal = observation_model.observation_operator(true_signal) + observation_model.signal_noise;

    % Formulation parameters
    config_proposal_2.signal_lower_bound = 0;
    config_proposal_2.signal_upper_bound = 1;
    config_proposal_2.radius_l2_ball = 0.9 * sqrt(sum(abs(observation_model.signal_noise) > eps)) * observation_model.std_dev_signal_noise;
    config_proposal_2.coefficient_l1 = coefficient_l1;

    % PDS configurations
    config_proposal_2.step_size_primal_variable_signal = 1 / (1 + sqrt(graph.lmax));
    config_proposal_2.step_size_primal_variable_infimal_convolution = 1;
    config_proposal_2.step_size_dual_variable_l2_ball = 1;
    config_proposal_2.step_size_dual_variable_l2_squared= 1 / (1 + sqrt(graph.lmax));
    config_proposal_2.initial_primal_variable_signal = zeros(graph.N, 1);
    config_proposal_2.initial_primal_variable_infimal_convolution = zeros(graph.Ne, 1);
    config_proposal_2.initial_dual_variable_l2_ball = zeros(graph.N, 1);
    config_proposal_2.initial_dual_variable_l2_squared= zeros(graph.Ne, 1);

    % Solver configurations
    tolerance = 1e-9;
    config_proposal_2.stopping_criteria = @(config, state) is_converge_fixed_point_residual(config, state, tolerance);
    config_proposal_2.before_iteration = @increment;
    config_proposal_2.after_iteration = @compute_pds_residual;

end