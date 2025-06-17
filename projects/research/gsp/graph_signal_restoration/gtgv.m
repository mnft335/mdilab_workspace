clear;

gsp_start();

% Graph setup
load("minnesota_graph.mat");
G = gsp_adj2vec(G);
V = G.N;
E = G.Ne;
u_true = G.org_signal;
W = diag(G.weights);
D = G.Diff;
WD = W * D;

% Observation matrix
masking_rate = round(0.5 * V);
mask = ones(V, 1);
% mask(randperm(V, masking_rate)) = 0;

Phi = @(z) mask .* z;
Phit = @(z) mask .* z;

% Observed signal
sigma = 0.25;
b = Phi(u_true + sigma * randn(size(u_true)));

% Parameters
lower = 0;
upper = 1;
alpha = 0.5;
epsilon = norm(Phi(u_true) - b);
gamma_u = 0.1;
gamma_q = 0.1;
gamma_y1 = 1 / 30 * gamma_u;
gamma_y2 = 1 / 30 * gamma_u;
gamma_y3 = 1 / 30 * gamma_u;

% Initialize variables
u = zeros(V, 1);
q = zeros(E, 1);
y1 = zeros(E, 1);
y2 = zeros(V, 1);
y3 = zeros(V, 1);

% Stopping criteria
iter = 20000;
tolerance = 1e-5;
relative_error = zeros(iter, 1);
mse = zeros(iter, 1);

import functions.*
import prox.*

prox_l1_dual = @(arg, gamma, lambda) arg - gamma * prox_l1(arg / gamma, 1 / gamma, lambda);
prox_ball_l2_dual = @(arg) arg - gamma_y3 * prox_ball_l2(arg / gamma_y3, b, epsilon);

for i = 1:iter
    u_prev = u;
    u = prox_box(u - gamma_u * (WD.' * y1 + Phit(y3)), lower, upper);

    q_prev = q;
    q = q - gamma_q * (- y1 + WD * y2);

    y1 = prox_l1_dual(y1 + gamma_y1 * (WD * (2 * u - u_prev) - (2 * q - q_prev)), gamma_y1, alpha);
    
    y2 = prox_l1_dual(y2 + gamma_y2 * (WD.' * (2 * q - q_prev)), gamma_y2, 1 - alpha);

    y3 = prox_ball_l2_dual(y3 + gamma_y3 * (Phi(2 * u - u_prev)));

    relative_error(i) = norm(u - u_prev) / norm(u_prev);
    mse(i) = norm(u - u_true) / norm(u_true);

    if mod(i, 100) == 0
        disp("Iteration: " + num2str(i));
    end
    
    if relative_error(i) < tolerance
        disp("Break at iteration " + num2str(i));
        break;
    end
end

figure;

subplot(1, 3, 1);
gsp_plot_signal(G, u_true);
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
gsp_plot_signal(G, u);
clim([0, 1]);
colorbar("off");
colorbar("North");
title("Restored by GTGV");

figure;

subplot(2, 1, 1);
semilogx(1:i, relative_error(1:i));
title("Relative error");

subplot(2, 1, 2);
semilogx(1:i, mse(1:i));
title("MSE");