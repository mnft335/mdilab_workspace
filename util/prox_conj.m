function result = prox_conj(prox)
    result = @(z, gamma) z - gamma * prox(z / gamma, 1 / gamma);
end