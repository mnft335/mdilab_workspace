function result = solve_gtv(shared_config, specific_config)

    import prox.*;

    problem_config.L = @(z) {shared_config.Phi(z{1}), ...
                             shared_config.G.weight .* shared_config.G.Diff * z{1}};
    problem_config.Lt = @(z) {shared_config.Phit(z{1} + shared_config.G.Diff.' * shared_config.G.weight .* z{1})};
    problem_config.grad_f = {@(z) zeros(shared_config.G.N, 1)};
    problem_config.prox_g = {@(z, gamma) prox_box{z, shared_config.lower, shared_config.upper}};
    problem_config.prox_h_conj = {prox_conj(@(z, gamma) prox_ball_l2(z, shared_config.b, shared_config.epsilon)), ...
                                  prox_conj(@(z, gamma) prox_l1(z, gamma, 1))};
                                  