function result = aggregate_differences(incidence, difference)
    
    source_indices = incidence > 0;
    result = source_indices .* difference;

end