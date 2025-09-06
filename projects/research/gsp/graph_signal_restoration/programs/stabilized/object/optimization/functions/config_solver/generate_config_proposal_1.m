function config_proposal_1 = generate_config_proposal_1(graph, true_signal, observation_model, coefficient_l1)

    % Create operators in the PDS
    config_proposal_1.observation_operator = @(z) observation_model.observation_operator(z);
    config_proposal_1.observation_operator_adjoint = @(z) observation_model.observation_operator_adjoint(z);
    config_proposal_1.weight_operator = @(z) graph.weights .* z;
    config_proposal_1.weight_operator_adjoint = @(z) graph.weights .* z;
    config_proposal_1.gradient_operator = @(z) graph.Diff * z;
    config_proposal_1.gradient_operator_adjoint = @(z) graph.Diff.' * z;
    config_proposal_1.root_weight_operator = @(z) sqrt(graph.weights) .* z;
    config_proposal_1.root_weight_operator_adjoint = @(z) sqrt(graph.weights) .* z;

    % Create an observed signal
    config_proposal_1.observed_signal = observation_model.observation_operator(true_signal) + observation_model.signal_noise;

    % Formulation parameters
    config_proposal_1.signal_lower_bound = 0;
    config_proposal_1.signal_upper_bound = 1;
    config_proposal_1.radius_l2_ball = 0.9 * sqrt(sum(abs(observation_model.signal_noise) > eps)) * observation_model.std_dev_signal_noise;
    config_proposal_1.coefficient_l1 = coefficient_l1;

    % PDS configurations
    config_proposal_1.step_size_primal_variable_signal = 1 / (1 + sqrt(graph.lmax));
    config_proposal_1.step_size_primal_variable_infimal_convolution = 1 / (max(graph.weights) + max(sqrt(graph.weights)));
    config_proposal_1.step_size_dual_variable_l2_ball = 1;
    config_proposal_1.step_size_dual_variable_l1 = 1 / max(graph.weights);
    config_proposal_1.step_size_dual_variable_l2 = 1 / (sqrt(graph.lmax) + max(sqrt(graph.weights)));
    config_proposal_1.initial_primal_variable_signal = zeros(graph.N, 1);
    config_proposal_1.initial_primal_variable_infimal_convolution = zeros(graph.Ne, 1);
    config_proposal_1.initial_dual_variable_l2_ball = zeros(graph.N, 1);
    config_proposal_1.initial_dual_variable_l1 = zeros(graph.Ne, 1);
    config_proposal_1.initial_dual_variable_l2 = zeros(graph.Ne, 1);

    % Solver configurations
    tolerance = 1e-9;
    config_proposal_1.stopping_criteria = @(config, state) is_converge_fixed_point_residual(config, state, tolerance);
    config_proposal_1.before_iteration = @increment;
    config_proposal_1.after_iteration = @compute_pds_residual;

end