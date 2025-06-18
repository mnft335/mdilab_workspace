clear;

% Graph setup
G_original = load("minnesota_graph.mat", "G");
G = corrupt_graph(G_original.G, 1.0);
G = gsp_compute_fourier_basis(G);
V = G.N;
true_signal = G.org_signal;

root_L = @(z) sqrt(G.e) .* G.U.' * z;
root_Lt = @(z) G.U * (sqrt(G.e) .* z);

% Observation matrix
masking_rate = round(0.5 * V);
mask = ones(V, 1);
if masking_rate ~= 0, mask(randperm(V, masking_rate)) = 0; end

Phi = @(z) mask .* z;
Phit = @(z) mask .* z;

% Observed signal
sigma = 0.25;
b = Phi(true_signal + sigma * randn(size(true_signal)));

% Parameters
lower = 0;
upper = 1;
alpha = 0.2;
epsilon = norm(Phi(true_signal - b));
gamma_x1 = 0.1;
gamma_y1 = 1 / 30 * gamma_x1;
gamma_y2 = 1 / 30 * gamma_x1;

% Initialize variables 
x1 = zeros(V, 1);
y1 = zeros(V, 1);
y2 = zeros(V, 1);

% Stopping criteria
iter = 20000;
tolerance = 1e-5;
relative_error = zeros(iter, 1);
mse = zeros(iter, 1);

% Proximal operators
import prox.*;

prox_ball_l2_conj = prox_conj(@(z, gamma) prox_ball_l2(z, b, epsilon));
prox_l2_conj = prox_conj(@(z, gamma) prox_l2(z, gamma, 1 / 2));

% Main loop
for i = 1:iter
    x1_prev = x1;
    x1 = prox_box(x1 - gamma_x1 * (Phit(y1) + root_Lt(y2)), lower, upper);

    y1 = prox_ball_l2_conj(y1 + gamma_y1 * Phi(2 * x1 - x1_prev), gamma_y1);

    y2 = prox_l2_conj(y2 + gamma_y2 * root_L(2 * x1 - x1_prev), gamma_y2);
    
    relative_error(i) = norm(x1 - x1_prev) / norm(x1_prev);
    mse(i) = norm(x1 - true_signal) / norm(true_signal);

    if mod(i, 100) == 0
        disp("iteration: " + num2str(i));
    end

    if relative_error(i) < tolerance
        disp("break at iteration " + num2str(i));
        break;
    end
end

plot_graph(G, true_signal, b, x1);
plot_status(i, relative_error, mse);
disp(mse(i));