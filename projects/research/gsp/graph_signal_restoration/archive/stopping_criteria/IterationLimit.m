classdef StateMonitor < handle
    properties
        current_iteration = 1;
        relative_error = [];
    end

    methods
        function result = stopping_criteria(obj, max_iterations)
            result = obj.current_iteration >= max_iterations;
            if result
                disp("Reached maximum iterations: " + num2str(max_iterations));
            else
                obj.increment();
            end
        end

        function obj = increment(obj)
            obj.current_iteration = obj.current_iteration + 1;
        end
    end
end