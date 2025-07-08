function config = make_problem_config(Phi, W, D, b, epsilon)
    import prox.*;

    lower = 0;
    upper = 1;
    alpha = 0.4;
    
    Phit = Phi;

    config.L = {@(z) {Phi(z{1}), W * D * z{1} - W * z{2}}};
    config.Lt = {@(z) {Phit(z{1}) + WD.' * (z{2}), - W * z{2}}};
    config.grad_f = {@(z) {0, 0}};
    config.prox_g = {@(z, gamma) prox_box(z, lower, upper), @(z, gamma) prox_l2(z, gamma, 1 - alpha)};
    config.prox_h_conj = {prox_conj(@(z, gamma) prox_l1(z, gamma, alpha)), @(z, gamma) prox_conj(prox_ball_l2(z, b, epsilon))};
end