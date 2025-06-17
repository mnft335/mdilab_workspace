clear;

gsp_start();

% Graph setup
load("minnesota_graph.mat");
V = G.N;
E = G.Ne;
L = G.L;
x1_true = G.org_signal;


% Observation matrix
masking_rate = round(0.0 * G.N);
mask = ones(G.N, 1);
if masking_rate ~= 0, mask(randperm(V, masking_rate)) = 0; end

Phi = @(z) mask .* z;
Phit = @(z) mask .* z;

% Observed signal
sigma = 0.25;
b = Phi(x1_true + sigma * randn(size(x1_true)));

% Parameters
epsilon = norm(Phi(x1_true) - b);
lower = 0;
upper = 1;
gamma_x1 = 0.1;
gamma_y1 = 1 / 30 * gamma_x1;

% Initialize variables
x1 = zeros(G.N, 1);
y1 = zeros(G.N, 1);

% Stopping criteira
iter = 20000;
tolerance = 1e-5;
relative_error = zeros(iter, 1);
mse = zeros(iter, 1);

% Proximal Operators
import prox.*

prox_ball_l2_conj = prox_conj(@(z, gamma) prox_ball_l2(z, b, epsilon));

for i = 1:iter
    x1_prev = x1;
    x1 = prox_box(x1 - gamma_x1 * (L * x1 + Phit(y1)), lower, upper);

    y1 = prox_ball_l2_conj(y1 + gamma_y1 * Phi(2 * x1 - x1_prev), gamma_y1);
    
    relative_error(i) = norm(x1 - x1_prev) / norm(x1_prev);
    mse(i) = norm(x1 - x1_true) / norm(x1_true);

    if mod(i, 100) == 0
        disp("iteration: " + num2str(i));
    end

    if relative_error(i) < tolerance
        disp("break at iteration: " + num2str(i));
        break;
    end
end

figure;

subplot(1, 3, 1);
gsp_plot_signal(G, x1_true);
clim([0, 1]);
colorbar("off");
colorbar("North");
title("Original");

subplot(1, 3, 2);
gsp_plot_signal(G, b);
clim([0, 1]);
colorbar("off");
colorbar("North");
title("Noisy with missing samples");

subplot(1, 3, 3);
gsp_plot_signal(G, x1);
clim([0, 1]);
colorbar("off");
colorbar("North");
title("Restored by GLR");

figure;
subplot(2, 1, 1);
semilogx(1:i, relative_error(1:i));
title("Relative error");

subplot(2, 1, 2);
semilogx(1:i, mse(1:i));
title("MSE");