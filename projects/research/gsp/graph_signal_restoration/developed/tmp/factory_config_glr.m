function config_glr = factory_config_glr(graph, true_signal, observation_model)

    % Create operators in the PDS
    config_glr.observation_operator = @(z) observation_model.observation_operator(z);
    config_glr.observation_operator_adjoint = @(z) observation_model.observation_operator_adjoint(z);
    config_glr.root_laplacian_operator = @(z) sqrt(graph.e) .* graph.U.' * z;
    config_glr.root_laplacian_operator_adjoint = @(z) graph.U * (sqrt(graph.e) .* z);

    % Generate an observed signal
    config_glr.observed_signal = config_glr.observation_operator(true_signal) + observation_model.signal_noise;

    % Formulation parameters
    config_glr.signal_lower_bound = 0;
    config_glr.signal_upper_bound = 1;
    config_glr.radius_l2_ball = 0.9 * sqrt(sum(glr_specifics.signal_mask)) * glr_specifics.standard_deviation_signal_noise;
    config_glr.coefficient_l2 = 1 / 2;

    % Define config_glr
    config_glr.step_size_primal_variable = 1 / (1 + sqrt(graph.lmax));
    config_glr.step_size_dual_variable_l2_ball = 1;
    config_glr.step_size_dual_variable_l2 = 1 / sqrt(graph.lmax);
    config_glr.initial_primal_variable = zeros(graph.N, 1);
    config_glr.initial_dual_variable_l2_ball = zeros(graph.N, 1);
    config_glr.initial_dual_variable_l2 = zeros(graph.N, 1);

    % Define solver_specifics
    tolerance = 1e-9;
    config_glr.stopping_criteria = @(config, state) is_converge_fixed_point_residual(config, state, tolerance);
    config_glr.before_iteration = @increment;
    config_glr.after_iteration = @compute_pds_residual;

end