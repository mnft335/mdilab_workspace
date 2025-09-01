function result = solver_gtv(config_gtv)

    prox_conj_l2_ball = prox.conjugate(@(z, gamma) prox.l2_ball(z, gamma, config_gtv.observed_signal, config_gtv.radius_l2_ball));
    prox_conj_l1 = prox.conjugate(@(z, gamma) prox.l1(z, gamma, config_gtv.coefficient_l1));

    formulation_config.L = @(z) {config_gtv.observation_operator(z{1}), ...
                                 config_gtv.weighted_differential_operator(z{1})};
    formulation_config.Lt = @(z) {config_gtv.observation_operator_adjoint(z{1}) + config_gtv.weighted_differential_operator_adjoint(z{2})};
    formulation_config.grad_f = @(z) {zeros(size(z{1}))};
    formulation_config.prox_g = @(z, gamma) {prox.box(z{1}, gamma{1}, config_gtv.signal_lower_bound, config_gtv.signal_upper_bound)};
    formulation_config.prox_h_conj = @(z, gamma) {prox_conj_l2_ball(z{1}, gamma{1}), ...
                                                  prox_conj_l1(z{2}, gamma{2})};
                                  
    pds_config.gamma_x = {config_gtv.step_size_primal_variable};
    pds_config.gamma_y = {config_gtv.step_size_dual_variable_l2_ball, ...
                          config_gtv.step_size_dual_variable_l1};
    pds_config.x_init = {config_gtv.initial_primal_variable};
    pds_config.y_init = {config_gtv.initial_dual_variable_l2_ball, ...
                         config_gtv.initial_dual_variable_l1};

    loop_config.stopping_criteria = config_gtv.stopping_criteria;
    loop_config.before_iteration = config_gtv.before_iteration;
    loop_config.after_iteration = config_gtv.after_iteration;

    result = solve_pds(formulation_config, pds_config, loop_config);
    
end