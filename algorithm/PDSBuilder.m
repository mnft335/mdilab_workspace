classdef PDSBuilder < handle
    properties
        L
        Lt
        grad_f
        prox_g
        prox_h_conj
        Gamma_x
        Gamma_y

        x
        y
        stopping_criteria
        before_iteration = @(obj) [];
        after_iteration = @(obj) [];
    end

    methods
        function obj = set_L(obj, L);
            obj.L = L;
        end

        function obj = set_Lt(obj, Lt);
            obj.Lt = Lt;
        end

        function obj = set_grad_f(obj, grad_f)
            obj.grad_f = grad_f;
        end

        function obj = set_prox_g(obj, prox_g)
            obj.prox_g = prox_g;
        end

        function obj = set_prox_h_conj(obj, prox_h_conj)
            obj.prox_h_conj = prox_h_conj;
        end

        function obj = set_Gamma_x(obj, Gamma_x)
            obj.Gamma_x = Gamma_x;
        end

        function obj = set_Gamma_y(obj, Gamma_y)
            obj.Gamma_y = Gamma_y;
        end

        function obj = set_initial_x(obj, initial_x)
            obj.x = initial_x;
        end

        function obj = set_initial_y(obj, initial_y)
            obj.y = initial_y;
        end

        function obj = set_stopping_criteria(obj, stopping_criteria)
            obj.stopping_criteria = stopping_criteria;
        end

        function obj = set_before_iteration(obj, before_iteration)
            obj.before_iteration = before_iteration;
        end

        function obj = set_after_iteration(obj, after_iteration)
            obj.after_iteration = after_iteration;
        end

        function pds = build(obj)

            pds = PDS();
            pds.L = obj.L;
            pds.Lt = obj.Lt;
            pds.grad_f = obj.grad_f;
            pds.prox_g = obj.prox_g;
            pds.prox_h_conj = obj.prox_h_conj;
            pds.Gamma_x = obj.Gamma_x;
            pds.Gamma_y = obj.Gamma_y;
            pds.x = obj.x;
            pds.y = obj.y;
            pds.stopping_criteria = obj.stopping_criteria;
            pds.before_iteration = obj.before_iteration;
            pds.after_iteration = obj.after_iteration;
        end
    end
end