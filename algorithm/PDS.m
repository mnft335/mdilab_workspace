classdef PDS < handle
    properties
        % Problem settings
        L
        Lt
        grad_f
        prox_g
        prox_h_conj
        Gamma_x
        Gamma_y

        % Algorithm settings
        x
        x_prev
        y
        y_prev
        stopping_criteria
        before_iteration
        after_iteration
    end

    methods
        function result = update_x(obj)
            argument = cellfun(@(z1, z2, z3, z4) z1 - z2 * (z3 + z4), obj.x, obj.Gamma_x, obj.grad_f(obj.x), obj.Lt(obj.y), "UniformOutput", false);
            result = cellfun(@(z1, z2, z3) z1(z2, z3), obj.prox_g, argument, obj.Gamma_x, "UniformOutput", false);
        end

        function result = update_y(obj)
            argument = cellfun(@(z1, z2, z3) z1 + z2 * z3, obj.y, obj.Gamma_y, obj.L(cellfun(@(z1, z2) 2 * z1 - z2, obj.x, obj.x_prev, "UniformOutput", false)), "UniformOutput", false);
            result = cellfun(@(z1, z2, z3) z1(z2, z3), obj.prox_h_conj, argument,  obj.Gamma_y, "UniformOutput", false);
        end

        function solve(obj)
            while 1
                obj.before_iteration(obj);

                obj.x_prev = cellfun(@(z) z,obj.x, "UniformOUtput", false);
                obj.x = obj.update_x();

                obj.y_prev = cellfun(@(z) z,obj.y, "UniformOutput", false);
                obj.y = obj.update_y();

                obj.after_iteration(obj);
                
                if obj.stopping_criteria(obj), break; end
            end
        end
    end
end