classdef AlgorithmConfigBuilder
    properties
        Gamma_x
        Gamma_y
        x_init
        y_init
        stopping_criteria
    end

    methods
        function obj = set_Gamma_x(obj, Gamma_x)
            obj.Gamma_x = Gamma_x;
        end

        function obj = set_Gamma_y(obj, Gamma_y)
            obj.Gamma_y = Gamma_y;
        end

        function obj = set_initial_x(obj, x_init)
            obj.x_init = x_init;
        end

        function obj = set_initial_y(obj, y_init)
            obj.y_init = y_init;
        end

        function obj = set_stopping_criteria(obj, stopping_criteria)
            obj.stopping_criteria = stopping_criteria;
        end

        function config = build(obj)
            config = AlgorithmConfig();
            config.Gamma_x = obj.Gamma_x;
            config.Gamma_y = obj.Gamma_y;
            config.x_init = obj.x_init;
            config.y_init = obj.y_init;
            config.stopping_criteria = obj.stopping_criteria;
        end
    end
end