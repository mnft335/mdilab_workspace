function result = prox_ball_l2(x, center, epsilon)
    norm_l2 = norm(x - center, "fro");
    result = center + min(norm_l2, epsilon) / norm_l2 * (x - center);
end