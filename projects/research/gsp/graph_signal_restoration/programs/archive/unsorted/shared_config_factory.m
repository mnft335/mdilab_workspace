function shared_config = shared_config_factory(concrete_config)
    
    % Generate a signal from correct weights
    W_clean = concrete_config.generate_weights(concrete_config.adjacency);
    shared_config.true_signal = concrete_config.generate_clean_signal(create_graph(W_clean));

    % Generate a graph from corrupted weights
    W_noisy = concrete_config.corrupt_weights(W_clean);
    shared_config.G = create_graph(W_noisy);

    % Generate an observation matrix Phi and its transpose Phit
    mask = concrete_config.generate_signal_mask(shared_config.G.N, concrete_config.masking_rate);

    shared_config.Phi = @(z) mask .* z;
    shared_config.Phit = @(z) mask .* z;

    % Generate an observed signal
    shared_config.b = concrete_config.corrupt_signal(shared_config.true_signal, shared_config.Phi, concrete_config.signal_noise_sigma);

    % Regularization parameters
    shared_config.lower = 0;
    shared_config.upper = 1;
    shared_config.epsilon = 0.9 * sqrt(int64((1 - concrete_config.masking_rate) * shared_config.G.N)) * concrete_config.signal_noise_sigma;

    % Configurations for solve_pds()
    max_iteration = 10000;
    tolerance = 1e-5;

    shared_config.stopping_criteria = @(config, state) stopping_criteria(state, max_iteration, tolerance);
    shared_config.before_iteration = @(config, state) before_iteration(state);
    shared_config.after_iteration = @(config, state) after_iteration(config, state);

end

function is_converge = stopping_criteria(state, max_iteration, tolerance)

    is_converge = state.i >= max_iteration | state.residual < tolerance;

end

function state = before_iteration(state)

    if ~isfield(state, "i"), state.i = 0; end
    state.i = state.i + 1;

end

function state = after_iteration(config, state)

    % Compute the fixed-point residual
    if ~isfield(state, "residual"), state.residual = Inf; end

    previous_residual = state.residual;
    state.residual = compute_pds_residual(config, state);

    % Terminate if the fixed-point residual is not monotonically nonincreasing
    assert(state.residual < previous_residual, "Fixed point residual is not monotonically nonincreasing");

end

function result = compute_pds_residual(config, state)

    primal_difference = cellfun(@(z1, z2) z1 - z2, state.x, state.x_prev, "UniformOutput", false);
    dual_difference = cellfun(@(z1, z2) z1 - z2, state.y, state.y_prev, "UniformOutput", false);

    primal_term = cellfun(@(z1, z2) sum(z1.^2) / z2, primal_difference, config.Gamma_x);
    dual_term = cellfun(@(z1, z2) sum(z1.^2) / z2, dual_difference, config.Gamma_y);
    mixed_term = cellfun(@(z1, z2) - 2 * dot(z1, z2), primal_difference, config.Lt(dual_difference));
    result = sum([primal_term, dual_term, mixed_term]);

end