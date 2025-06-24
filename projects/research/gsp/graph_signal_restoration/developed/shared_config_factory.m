function shared_config = shared_config_factory()
    
    gsp_start();

    load(path_search("Rome"));
    shared_config.G = gsp_graph(double(W), pos);
    shared_config.G = corrupt_graph(shared_config.G, @(z, i, j) corruption(z, i, j), 0.0);
    shared_config.G = gsp_compute_fourier_basis(shared_config.G);
    shared_config.true_signal = double(data(:, 1)) / double(max(data(:, 1)));

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
    shared_config.tolerance = 1e-5;

    shared_config.stopping_criteria = @(config, state) stopping_criteria(state, shared_config.max_iteration, shared_config.tolerance);
    shared_config.before_iteration = @(config, state) before_iteration(state);
    shared_config.after_iteration = @(config, state) after_iteration(state, shared_config.true_signal);
end

function is_converge = stopping_criteria(state, max_iteration, tolerance)
    is_converge = state.i >= max_iteration | state.residual < tolerance;
end

function state = before_iteration(state)
    if ~isfield(state, "i"), state.i = 1; else, state.i = state.i + 1; end
end

function state = after_iteration(state, true_signal)
    state.residual = compute_relative_error([state.x{1}; state.y{1}; state.y{2}], [state.x_prev{1}; state.y_prev{1}; state.y_prev{2}]);
    state.accuracy = compute_relative_error(state.x{1}, true_signal);
    if mod(state.i, 100) == 0, disp("iteration " + num2str(state.i)); end
end