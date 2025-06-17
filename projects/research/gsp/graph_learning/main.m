clear;

gsp_start();
% implement later
prox_cv_dual = @(arg) arg - gamma_2 * prox_cv(arg / gamma_2);
prox_indicator_dual = @(arg) arg - gamma_2 * prox_indicator(arg / gamma_2);
prox_rv_dual = @(arg) arg - gamma_2 * prox_rv(arg / gamma_2);

for i = 1:iter
    l_i_prev = l_i;
    l_i = prox_box(l_i - gamma_1 * (2 * alpha * (S.' * S + 2) * sum(l_i, 1) + sum(2 * k - S.' * d, 1) + y1 + y2), - Inf, 0);

    l_prev = l;
    l = prox_box(l - gamma_1 * (- y1 + y3), - Inf, 0);

    y1 = prox_cv_dual(y1 + gamma_2 * (2 * (l_i - l) - (l_i - l)));
    y2 = prox_indicator_dual(y2 + gamma_2 * (2 * l_i - l_i_prev));
    y3 = prox_rv_dual(y3 + gamma_2 * (2 * l - l_prev));