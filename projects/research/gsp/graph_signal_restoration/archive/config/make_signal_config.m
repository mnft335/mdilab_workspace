function config = make_signal_config()
    load("minnesota_graph.mat", G);

    masking_rate = 0.5;
    mask = ones(G.N, 1);
    mask(randperm(G.N, round(masking_rate * G.N))) = 0;

    config.true_signal = G.org_signal;
    config.Phi = @(z) mask .* z;
    config.epsilon = 0.25;
    config.observed_signal = config.true_signal + noise_standard_deviation * randn(size(G.org_signal));
end