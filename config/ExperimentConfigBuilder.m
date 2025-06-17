classdef ExperimentConfigBuilder
    properties
        before_iteration
        after_iteration
    end

    methods
        function obj = set_before_iteration(obj, before_iteration)
            obj.before_iteration = before_iteration;
        end

        function obj = set_after_iteration(obj, after_iteration)
            obj.after_iteration = after_iteration;
        end

        function config = build(obj)
            config = ExperimentConfig();
            config.before_iteration = obj.before_iteration;
            config.after_iteration = obj.after_iteration;
        end
    end
end