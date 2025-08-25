function result = solve_gtv(formulation_specifics, pds_specifics, loop_specifics)

    prox_l2_ball_conj = prox.conjugate(@(z, gamma) prox.l2_ball(z, gamma, formulation_secifics.observed_signal, formulation_specifics.radius_l2_ball));
    prox_l1_conj = prox.conjugate(@(z, gamma) prox.l1(z, gamma, formulation_specifics.coefficient_l1));

    formulation_config.L = @(z) {formulation_specifics.apply_observation_operator(z{1}), ...
                             formulation_specifics.apply_first_order_differential_operator(z{1})};
    formulation_config.Lt = @(z) {formulation_specifics.apply_observation_operator_adjoint(z{1}) + apply_first_order_differential_operator_adjoint(z{2})};
    formulation_config.grad_f = @(z) {zeros(size(z{1}))};
    formulation_config.prox_g = @(z, gamma) {prox.box(z{1}, gamma{1}, formulation_specifics.signal_lower_bound, formulation_specifics.signal_upper_bound)};
    formulation_config.prox_h_conj = @(z, gamma) {prox_l2_ball_conj(z{1}, gamma{1}), ...
                                                  prox_l1_conj(z{2}, gamma{2})};
                                  
    pds_config.gamma_x = {pds_specifics.step_size_primal_variable};
    pds_config.gamma_y = {pds_specifics.step_size_dual_variable_l2_ball, ...
                          pds_specifics.step_size_dual_variable_l2};
    pds_config.x_init = {pds_specifics.initial_primal_variable};
    pds_config.y_init = {pds_specifics.initial_dual_variable_l2_ball, ...
                         pds_specifics.initial_dual_variable_l2};

    loop_config.stopping_criteria = loop_specifics.stopping_criteria;
    loop_config.before_iteration = loop_specifics.before_iteration;
    loop_config.after_iteration = loop_specifics.after_iteration;

    result = solve_pds(formulation_config, pds_config, loop_config);
    
end