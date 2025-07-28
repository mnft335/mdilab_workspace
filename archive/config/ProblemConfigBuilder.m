classdef ProblemConfigBuilder
    properties
        L
        Lt
        grad_f
        prox_g
        prox_h_conj
    end

    methods
        function obj = set_L(obj, L)
            obj.L = L;
        end

        function obj = set_Lt(obj, Lt)
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
    end
end