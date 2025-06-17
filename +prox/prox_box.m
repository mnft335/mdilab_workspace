function y = prox_box(x, lower, upper)
    y = max(min(x, upper), lower);
end