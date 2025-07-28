function result = solve_glr(formulation_specifics, algorithm_specifics, solver_specifics)

    prox_conj_l2_ball = prox_conj(@(z, gamma) prox.l2_ball(z, formulation_specifics.observed_signal, formulation_specifics.l2_ball_radius));
    prox_conj_l2 = prox_conj(@(z, gamma) prox.l2(z, gamma, formulation_specifics.coefficient_l2 / 2));

    formulation_config.L = @(z) {formulation_specifics.linear_observation(z{1}), ...
                                 formulation_specifics.root_laplacian(z{1})};
    formulation_config.Lt = @(z) {formulation_specifics.linear_observation_transpose(z{1}) + formulation_specifics.root_laplacian_transpose(z{2})};
    formulation_config.grad_f = @(z) {zeros(size(z{1}))};
    formulation_config.prox_g = @(z, gamma) {prox_box(z{1}, formulation_specifics.signal_lower_bound, formulation_specifics.signal_upper_bound)};
    formulation_config.prox_h_conj = @(z, gamma) {prox_conj_l2_ball(z{1}, gamma{1}), ...
                                                  prox_conj_l2(z{2}, gamma{2})};

    algorithm_config.gamma_x = {algorithm_specifics.step_size_primal_variable};
    algorithm_config.gamma_y = {algorithm_specifics.step_size_dual_variable_l2_ball, ...
                                algorithm_specifics.step_size_dual_variable_l2};

    solver_config.x_init = {solver_specifics.initial_primal_variable};
    solver_config.y_init = {solver_specifics.initial_dual_variable_l2_ball, ...
                            solver_specifics.initial_dual_variable_l2};
    solver_config.stopping_criteria = solver_specifics.stopping_criteria;
    solver_config.before_iteration = solver_specifics.before_iteration;
    solver_config.after_iteration = solver_specifics.after_iteration;

    result = solve_pds(formulation_config, algorithm_config, solver_config);
    
end