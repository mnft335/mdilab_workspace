function result = solver_proposal_3(config_proposal_3)

    prox_conj_l2_ball = prox.conjugate(@(z, gamma) prox.l2_ball(z, config_proposal_3.observed_signal, config_proposal_3.radius_l2_ball));
    prox_conj_l2 = prox.conjugate(@(z, gamma) prox.l2(z, gamma, 1 - config_proposal_3.coefficient_l1));

    formulation_config.L = @(z) {config_proposal_3.observation_operator(z{1}), ...
                                 config_proposal_3.second_order_incidence_operator(z{1}) - config_proposal_3.incidence_operator_adjoint(z{2})};
    formulation_config.Lt = @(z) {config_proposal_3.observation_operator_adjoint(z{1}) + config_proposal_3.second_order_incidence_operator_adjoint(z{2}),
                                  - config_proposal_3.incidence_operator_adjoint(z{2})};
    formulation_config.grad_f = @(z) {zeros(size(z{1})), ...
                                      zeros(size(z{2}))};
    formulation_config.prox_g = @(z, gamma) {prox.box(z{1}, config_proposal_3.signal_lower_bound, config_proposal_3.signal_upper_bound), ...
                                             prox.l2(z{2}, gamma{2}, 1 - config_proposal_3.coefficient_l1)};
    formulation_config.prox_h_conj = @(z, gamma) {prox_conj_l2_ball(z{1}, gamma{1}), ...
                                                  prox_conj_l2(z{2}, gamma{2})};


    pds_config.Gamma_x = {config_proposal_3.step_size_primal_variable_signal, ...
                          config_proposal_3.step_size_primal_variable_infimal_convolution};
    pds_config.Gamma_y = {config_proposal_3.step_size_dual_variable_l2_ball, ...
                          config_proposal_3.step_size_dual_variable_l2};
    pds_config.x_init = {config_proposal_3.initial_primal_variable_signal, ...
                         config_proposal_3.initial_primal_variable_infimal_convolution};
    pds_config.y_init = {config_proposal_3.initial_dual_variable_l2_ball, ...
                         config_proposal_3.initial_dual_variable_l2};

    loop_config.stopping_criteria = config_proposal_3.stopping_criteria;
    loop_config.before_iteration = config_proposal_3.before_iteration;
    loop_config.after_iteration = config_proposal_3.after_iteration;

    result = solve_pds(formulation_config, pds_config, loop_config);

end 