function result = solver_proposal_2(config_proposal_2)

    prox_conj_l2_ball = prox.conjugate(@(z, gamma) prox.l2_ball(z, gamma, config_proposal_2.observed_signal, config_proposal_2.radius_l2_ball));
    prox_conj_l2_squared = prox.conjugate(@(z, gamma) prox.l2_squared(z, gamma, 1 - config_proposal_2.coefficient_l1));

    formulation_config.L = @(z) {config_proposal_2.observation_operator(z{1}), ...
                                 config_proposal_2.gradient_operator(z{1}) - z{2}};
    formulation_config.Lt = @(z) {config_proposal_2.observation_operator_adjoint(z{1}) + config_proposal_2.gradient_operator_adjoint(z{2}), ...
                                  - z{2}};
    formulation_config.grad_f = @(z) {zeros(size(z{1})), ...
                                      zeros(size(z{2}))};
    formulation_config.prox_g = @(z, gamma) {prox.box(z{1}, gamma{1}, config_proposal_2.signal_lower_bound, config_proposal_2.signal_upper_bound), ...
                                             prox.l1(z{2}, gamma{2}, config_proposal_2.coefficient_l1)};
    formulation_config.prox_h_conj = @(z, gamma) {prox_conj_l2_ball(z{1}, gamma{1}), ...
                                                  prox_conj_l2_squared(z{2}, gamma{2})};

    pds_config.gamma_x = {config_proposal_2.step_size_primal_variable_signal, ...
                          config_proposal_2.step_size_primal_variable_infimal_convolution};
    pds_config.gamma_y = {config_proposal_2.step_size_dual_variable_l2_ball, ...
                          config_proposal_2.step_size_dual_variable_l2_squared};
    pds_config.x_init = {config_proposal_2.initial_primal_variable_signal, ...
                         config_proposal_2.initial_primal_variable_infimal_convolution};
    pds_config.y_init = {config_proposal_2.initial_dual_variable_l2_ball, ...
                         config_proposal_2.initial_dual_variable_l2_squared};

    loop_config.stopping_criteria = config_proposal_2.stopping_criteria;
    loop_config.before_iteration = config_proposal_2.before_iteration;
    loop_config.after_iteration = config_proposal_2.after_iteration;

    result = pds_solver(formulation_config, pds_config, loop_config);

end