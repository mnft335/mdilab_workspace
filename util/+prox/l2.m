function result = l2(x, gamma, lambda)
    
    result = (1 - (gamma * lambda) / max(norm(x), gamma * lambda)) * x;

end