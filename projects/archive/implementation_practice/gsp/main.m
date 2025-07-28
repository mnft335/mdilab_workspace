clear

gsp_start;

load("config.mat");

% Graph          1x1              623495  struct              
% L            256x256             35464  double    sparse    
% M              1x1                   8  double              
% N              1x1                   8  double              
% Phi           32x256             65536  double              
% alpha          1x1                   8  double              
% epsilon        1x1                   8  double              
% sigma          1x1                   8  double              
% u_true       256x1                2048  double              
% v             32x1                 256  double  

import functions.*
import prox.*

iter = 20000;
tolerance = 1e-5;

u = zeros(N, 1);
s = zeros(M, 1);
y = zeros(M, 1);

relative_residual = zeros(iter);
absolute_residual = zeros(iter);

for i = 1:iter
    u_prev = u;
    u = prox_box(u - sigma * (2 * L * u + Phi.' * y), 0, Inf);

    s_prev = s;
    s = ProjFastL1Ball(s - sigma * y, alpha);

    prox_ball_l2_dual = @(arg) arg - sigma * prox_ball_l2(arg / sigma, v, epsilon);
    y = prox_ball_l2_dual(y + sigma * (Phi * (2 * u - u_prev) + (2 * s - s_prev)));

    relative_residual(i) = norm(u - u_prev, "fro") / norm(u_prev, "fro");
    absolute_residual(i) = immse(u, u_true);

    if mod(i, 100) == 0
        disp(i);
    end

    if relative_residual(i) < tolerance
        disp(["break at iteration", i]);
        break
    end
end

figure;

subplot(2, 1, 1);
plot(1:i, relative_residual(1:i));
title("relative residual");

subplot(2, 1, 2);
plot(1:i, absolute_residual(1:i));
title("absolute residual");

figure;

subplot(1, 2, 1);
gsp_plot_signal(Graph, u_true);
title("ground truth");

subplot(1, 2, 2);
gsp_plot_signal(Graph, u);
title("recovered");