clear;

gsp_start();

% Graph setup
load(path_search("Rome"));
G = gsp_graph(double(W), pos);
G = gsp_compute_fourier_basis(G);
G = gsp_adj2vec(G);
V = G.N;
E = G.Ne;
W = @(z) G.weights .* z;
Wt = @(z) G.weights .* z;
D = G.Diff;
true_signal = double(data(:, 1)) / double(max(data(:, 1)));

% Observation matrix
masking_rate = 0.0;
mask = ones(V, 1);
if masking_rate ~= 0, mask(randperm(V, round(masking_rate * V))) = 0; end

Phi = @(z) mask .* z;
Phit = @(z) mask .* z;

% Observed signal
sigma = 0.25;
b = Phi(true_signal + sigma * randn(size(true_signal)));

% Parameters
lower = 0;
upper = 1;
epsilon = 0.9 * sqrt((1 - masking_rate) * V) * sigma;
gamma_x1 = 1 / (1 + sqrt(max(G.e) * max(G.weights)));
gamma_y1 = 1;
gamma_y2 = 1 / (sqrt(max(G.e) * max(G.weights)));


% Initialize variables
x1 = zeros(V, 1);
y1 = zeros(V, 1);
y2 = zeros(E, 1);

% Stopping criteria
iter = 20000;
tolerance = 1e-5;
relative_error = zeros(iter, 1);
mse = zeros(iter, 1);

% Proximal operators
import prox.*;

prox_ball_l2_conj = prox_conj(@(z, gamma) prox_ball_l2(z, b, epsilon));
prox_l1_conj = prox_conj(@(z, gamma) prox_l1(z, gamma, 1));

% Main loop
for i = 1:iter
    x1_prev = x1;
    x1 = prox_box(x1 - gamma_x1 * (Phit(y1) + D.' * Wt(y2)), lower, upper);

    y1 = prox_ball_l2_conj(y1 + gamma_y1 * Phi(2 * x1 - x1_prev), gamma_y1);

    y2 = prox_l1_conj(y2 + gamma_y2 * W(D * (2 * x1 - x1_prev)), gamma_y2);

    relative_error(i) = norm(x1 - x1_prev) / norm(x1_prev);
    mse(i) = norm(x1 - true_signal) / norm(true_signal);

    if mod(i, 100) == 0
        disp("iteration: " + num2str(i));
    end

    if relative_error(i) < tolerance
        disp("break at iteration: " + num2str(i));
        break;
    end
end

disp(mse(i));
plot_graph(G, true_signal, b, x1);
% plot_status(i, relative_error, mse);