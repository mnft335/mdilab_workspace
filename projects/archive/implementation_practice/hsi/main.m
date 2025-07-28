clear

load("config");
%{
U_true        64x64x64            1048576  single              
V             64x64x64            1048576  single              
epsilon        1u                      8  double              
gamma_L        1u                      4  single              
gamma_U        1u                      4  single              
gamma_Y1       1u                      4  single              
gamma_Y2       1u                      4  single              
gamma_Y3       1u                      4  single              
lambda         1u                      8  double   
%}

import functions.*
import prox.*

iter = 20000;
tolerance = 1e-5;

[n1, n2, n3] = size(U_true);

u = zeros(n1, n2, n3);
l = zeros(n1, n2, n3);
y1 = zeros(n1, n2, n3, 2);
y2 = zeros(n1, n2, n3);
y3 = zeros(n1, n2, n3);

relative_residual = zeros(iter);
functional_value = zeros(iter);

for i = 1:20000
    u_prev = u;
    u = prox_box(u - gamma_U * (Dvht(y1) + y3), 0, 1);

    l_prev = l;
    l = prox_l1(l - gamma_L * (Dvt(y2) + y3), gamma_L, lambda);
    
    prox_12band_dual = @(arg) arg - gamma_Y1 * Prox12band(arg / gamma_Y1, 1 / gamma_Y1);
    y1 = prox_12band_dual(y1 + gamma_Y1 * Dvh(2 * u - u_prev));  % using a given code

    prox_zero_dual = @(arg) arg - gamma_Y2 * prox_zero(arg / gamma_Y2);
    y2 = prox_zero_dual(y2 + gamma_Y2 * Dv(2 * l - l_prev));

    prox_ball_l2_dual = @(arg) arg - gamma_Y3 * prox_ball_l2(arg / gamma_Y3, V, epsilon);
    y3 = prox_ball_l2_dual(y3 + gamma_Y3 * (2 * (u + l) - (u_prev + l_prev)));

    relative_residual(i) = norm(u - u_prev, "fro") / norm(u_prev, "fro");
    functional_value(i) = sum(sqrt(sum(u .* u, [3, 4])), [1, 2]) + lambda * norm(u(:), 1);
    if mod(i, 100) == 0
        disp(i);
    end

    if relative_residual(i) < tolerance
        disp(["break at iteration ", i]);
        break
    end
end

figure;

subplot(2, 1, 1);
semilogx(1:i, relative_residual(1:i));
title("relative residual");

subplot(2, 1, 2);
plot(1:i, functional_value(1:i));
title("functional value");

figure;

subplot(1, 2, 1);
montage(U_true);
title("ground truth");

subplot(1, 2, 2);
montage(u);
title("recovered");