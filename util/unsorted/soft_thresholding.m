% Soft thresholding operator applied to each element of "x" with the corresponding thresholds contained in "thresholds".
function result = soft_thresholding(x, thresholds)

    % Apply soft thresholding with the given thresholds
    result = sign(x) .* max(abs(x) - thresholds, 0);

end