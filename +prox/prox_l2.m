function result = prox_l2(x, gamma, lambda)
    result = 1 / (1 + 2 * lambda * gamma) * x;
end