function result = box(x, gamma, lower, upper)
    result = max(min(x(:), upper), lower);
end