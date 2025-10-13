% Proximal operator for the Huber function

function result = huber(argument, original_stepsize, threshold, coefficient)

    % Absorb the coefficient into the stepsize
    stepsize = original_stepsize * coefficient;

    % Preallocate result
    result = zeros(size(argument));
    
    % Create masks for the two cases of the proximal operator
    modulus_argument = abs(argument);
    mask_lesser = modulus_argument <= threshold * (stepsize + 1);
    mask_greater = modulus_argument > threshold * (stepsize + 1);

    % Compute the proximal operator for the two cases
    result(mask_lesser) = argument(mask_lesser) / (stepsize + 1);
    result(mask_greater) = argument(mask_greater) - threshold * stepsize * sign(argument(mask_greater));

end