function result = l2_ball(x, gamma, center, epsilon)

    norm_l2 = norm(x - center, "fro");
    result = center + min(norm_l2, epsilon) / norm_l2 * (x - center);

end