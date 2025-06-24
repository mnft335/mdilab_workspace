clear;

gsp_start();

% Graph setup
load(path_search("Rome"));
G = gsp_graph(double(W), pos);
G = corrupt_graph(G, @(z, i, j) corruption(z, i, j), 0.0);
G = gsp_compute_fourier_basis(G);
G = gsp_adj2vec(G);
V = G.N;
E = G.Ne;
W = @(z) G.weights .* z;
Wt = @(z) G.weights .* z;
root_W = @(z) sqrt(G.weights) .* z;
root_Wt = @(z) sqrt(G.weights) .* z;
WD = @(z) W(G.Diff * z);
WDt = @(z) G.Diff.' * W(z);
true_signal = double(data(:, 1)) / double(max(data(:, 1)));

% Observation matrix
masking_rate = 0.5;
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
alpha = 0.2;
epsilon = 0.9 * sqrt((1 - masking_rate) * V) * sigma
gamma_x1= 1 / (1 + sqrt(max(G.e) * max(G.weights)));
gamma_x2= 1 / (max(G.weights) + sqrt(max(G.weights)));
gamma_y1 = 1;
gamma_y2 = 1 / (sqrt(max(G.e) * max(G.weights)));
gamma_y3 = 1 / (sqrt(max(G.weights)));

% Initialize variables
x1= zeros(V, 1);
x2= zeros(E, 1);
y1 = zeros(V, 1);
y2 = zeros(E, 1);
y3 = zeros(E, 1);

% Stopping criteria
iter = 20000;
tolerance = 1e-5;
relative_error = zeros(iter, 1);
mse = zeros(iter, 1);

% Proximal operators
import prox.*

prox_ball_l2_conj = prox_conj(@(z, gamma) prox_ball_l2(z, b, epsilon));
prox_l1_conj = prox_conj(@(z, gamma) prox_l1(z, gamma, alpha));
prox_l2_conj = prox_conj(@(z, gamma) prox_l2(z, gamma, 1 - alpha));

% Main loop
for i = 1:iter
    x1_prev = x1;
    x1= prox_box(x1- gamma_x1 * (Phit(y1) + WDt(y2)), lower, upper);

    x2_prev = x2;
    x2= prox_none(x2 - gamma_x2 * (- Wt(y2) + root_Wt(y3)));

    y1_prev = y1;
    y1 = prox_ball_l2_conj(y1 + gamma_y1 * Phi(2 * x1 - x1_prev), gamma_y1);

    y2_prev = y2;
    y2 = prox_l1_conj(y2 + gamma_y2 * (WD(2 * x1 - x1_prev) - W(2 * x2 - x2_prev)), gamma_y2);

    y3_prev = y3;
    y3 = prox_l2_conj(y3 + gamma_y3 * root_W(2 * x2 - x2_prev), gamma_y3);

    relative_error(i) = norm([x1; x2; y1; y2; y3] - [x1_prev; x2_prev; y1_prev; y2_prev; y3_prev]) / norm([x1_prev; x2_prev; y1_prev; y2_prev; y3_prev]);
    mse(i) = norm(x1 - true_signal) / norm(true_signal);

    if mod(i, 100) == 0
        disp("iteration: " + num2str(i));
    end

    if relative_error(i) < tolerance
        disp("break at iteration " + num2str(i));
        break;
    end
end

disp(mse(i));
plot_graph(G, true_signal, b, x1);
% plot_status(i, relative_error, mse);