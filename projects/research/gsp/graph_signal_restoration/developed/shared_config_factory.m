function shared_config = shared_config_factory()
    
    gsp_start();

    load(path_search("Rome"));
    W = corrupt_weights(double(W), @multiplicative_corruption, 0.1);
    % shared_config.G = gsp_graph(W, pos);
    % shared_config.G = gsp_compute_fourier_basis(shared_config.G);
    % shared_config.G = gsp_adj2vec(shared_config.G);
    % isequal(shared_config.G.Diff.' * diag(shared_config.G.weights) * shared_config.G.Diff, shared_config.G.L)
    % shared_config.true_signal = double(data(:, 1)) / double(max(data(:, 1)));

    masking_rate = 0.5;
    mask = ones(shared_config.G.N, 1);
    if masking_rate ~= 0, mask(randperm(shared_config.G.N, round(masking_rate * shared_config.G.N))) = 0; end

    shared_config.Phi = @(z) mask .* z;
    shared_config.Phit = @(z) mask .* z;

    sigma = 0.25;
    shared_config.b = shared_config.Phi(shared_config.true_signal + sigma * randn(size(shared_config.true_signal)));

    shared_config.lower = 0;
    shared_config.upper = 1;
    shared_config.epsilon = 0.9 * sqrt((1 - masking_rate) * shared_config.G.N) * sigma;

    shared_config.max_iteration = 20000;
    shared_config.tolerance = 1e-8;

    shared_config.stopping_criteria = @(config, state) stopping_criteria(state, shared_config.max_iteration, shared_config.tolerance);
    shared_config.before_iteration = @(config, state) before_iteration(state);
    shared_config.after_iteration = @(config, state) after_iteration(config, state, shared_config.true_signal);
end

function is_converge = stopping_criteria(state, max_iteration, tolerance)
    is_converge = state.i >= max_iteration | state.residual(state.i) < tolerance;
end

function state = before_iteration(state)
    if ~isfield(state, "i"), state.i = 1; else, state.i = state.i + 1; end
end

function state = after_iteration(config, state, true_signal)
    state.residual(state.i) = compute_relative_error(vertcat(state.x{:}, state.y{:}), vertcat(state.x_prev{:}, state.y_prev{:}));
    state.accuracy(state.i) = compute_relative_error(state.x{1}, true_signal);
    if mod(state.i, 100) == 0, disp("iteration " + num2str(state.i)); end
    state.update_norm(state.i) = compute_update_norm(config, state);
    if state.i > 1 & state.update_norm(state.i) > state.update_norm(state.i - 1), disp("error!" + num2str(state.update_norm(state.i) - state.update_norm(state.i - 1))); end
end

function result = compute_update_norm(config, state)
    primal_difference = cellfun(@(z1, z2) z1 - z2, state.x, state.x_prev, "UniformOutput", false);
    dual_difference = cellfun(@(z1, z2) z1 - z2, state.y, state.y_prev, "UniformOutput", false);

    primal_term = cellfun(@(z1, z2) sum(z1.^2) / z2, primal_difference, config.Gamma_x);
    dual_term = cellfun(@(z1, z2) sum(z1.^2) / z2, dual_difference, config.Gamma_y);
    mixed_term = cellfun(@(z1, z2) - 2 * dot(z1, z2), primal_difference, config.Lt(dual_difference));
    result = sum([primal_term, dual_term, mixed_term]);
end