function result = solver_glr(config_glr)

    prox_conj_l2_ball = prox.conjugate(@(z, gamma) prox.l2_ball(z, gamma, config_glr.observed_signal, config_glr.radius_l2_ball));
    prox_conj_l2 = prox.conjugate(@(z, gamma) prox.l2(z, gamma, config_glr.coefficient_l2));

    formulation_config.L = @(z) {config_glr.observation_operator(z{1}), ...
                                 config_glr.gradient_operator(z{1})};
    formulation_config.Lt = @(z) {config_glr.observation_operator_adjoint(z{1}) + config_glr.gradient_operator_adjoint(z{2})};
    formulation_config.grad_f = @(z) {zeros(size(z{1}))};
    formulation_config.prox_g = @(z, gamma) {prox.box(z{1}, gamma{1}, config_glr.signal_lower_bound, config_glr.signal_upper_bound)};
    formulation_config.prox_h_conj = @(z, gamma) {prox_conj_l2_ball(z{1}, gamma{1}), ...
                                                  prox_conj_l2(z{2}, gamma{2})};

    pds_config.gamma_x = {config_glr.step_size_primal_variable};
    pds_config.gamma_y = {config_glr.step_size_dual_variable_l2_ball, ...
                          config_glr.step_size_dual_variable_l2};
    pds_config.x_init = {config_glr.initial_primal_variable};
    pds_config.y_init = {config_glr.initial_dual_variable_l2_ball, ...
                         config_glr.initial_dual_variable_l2};

    loop_config.stopping_criteria = config_glr.stopping_criteria;
    loop_config.before_iteration = config_glr.before_iteration;
    loop_config.after_iteration = config_glr.after_iteration;

    result = pds_solver(formulation_config, pds_config, loop_config);
    
end