function result = prox_conj(prox)
    result = @(z, gamma) z - gamma * prox(z, 1 / gamma);
end