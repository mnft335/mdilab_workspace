function shared_config = shared_config_factory(experiment_config)
    
    gsp_start();

    % Load a graph weights (adjacency) W
    load(path_search("Rome"));

    % Generate a signal from correct weights
    W = experiment_config.generate_weights(W);
    shared_config.true_signal = generate_signal(create_graph(W));

    % Generate a graph from corrupted weights
    W = experiment_config.corrupt_weights(W);
    shared_config.G = create_graph(W);

    % Generate an observation matrix Phi and its transpose Phit
    mask = ones(shared_config.G.N, 1);
    if experiment_config.masking_rate ~= 0, mask(randperm(shared_config.G.N, round(experiment_config.masking_rate * shared_config.G.N))) = 0; end

    shared_config.Phi = @(z) mask .* z;
    shared_config.Phit = @(z) mask .* z;

    % Generate an observed signal
    shared_config.b = shared_config.Phi(shared_config.true_signal + experiment_config.sigma * randn(size(shared_config.true_signal)));

    % Regularization parameters
    shared_config.lower = 0;
    shared_config.upper = 1;
    shared_config.epsilon = 0.9 * sqrt((1 - experiment_config.masking_rate) * shared_config.G.N) * experiment_config.sigma;

    % Configurations for solve_pds()
    max_iteration = 20000;
    tolerance = 1e-5;

    shared_config.stopping_criteria = @(config, state) stopping_criteria(state, max_iteration, tolerance);
    shared_config.before_iteration = @(config, state) before_iteration(state);
    shared_config.after_iteration = @(config, state) after_iteration(config, state, shared_config.true_signal);

end

function is_converge = stopping_criteria(state, max_iteration, tolerance)

    is_converge = state.residual(state.i) < tolerance;

end

function state = before_iteration(state)

    if ~isfield(state, "i"), state.i = 1; else, state.i = state.i + 1; end

end

function state = after_iteration(config, state, true_signal)

    state.residual(state.i) = compute_pds_residual(config, state);
    state.accuracy(state.i) = compute_relative_error(state.x{1}, true_signal);
    if mod(state.i, 100) == 0, disp("iteration " + num2str(state.i)); end
    assert(state.residual(state.i) <= state.residual(state.i - 1), "Fixed point residual is not monotonically nonincreasing");

end

function result = compute_pds_residual(config, state)

    primal_difference = cellfun(@(z1, z2) z1 - z2, state.x, state.x_prev, "UniformOutput", false);
    dual_difference = cellfun(@(z1, z2) z1 - z2, state.y, state.y_prev, "UniformOutput", false);

    primal_term = cellfun(@(z1, z2) sum(z1.^2) / z2, primal_difference, config.Gamma_x);
    dual_term = cellfun(@(z1, z2) sum(z1.^2) / z2, dual_difference, config.Gamma_y);
    mixed_term = cellfun(@(z1, z2) - 2 * dot(z1, z2), primal_difference, config.Lt(dual_difference));
    result = sum([primal_term, dual_term, mixed_term]);

end