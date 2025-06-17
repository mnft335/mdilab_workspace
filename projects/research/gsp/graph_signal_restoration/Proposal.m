classdef Proposal
    properties
        G
        W
        D
        
        Phi
        Phit
        sigma
        
        u_true
        b
        
        lower
        upper
        alpha
        epsilon
        
        gamma_u
        gamma_q
        gamma_y1
        gamma_y2
        
        u
        q
        y1
        y2
        
        iteration = 1
    end

    methods
        function obj = Proposal()
            % Graph setup
            gsp_start();
            load("minnesota_graph.mat", "G");

            obj.G = gsp_adj2vec(G);
            obj.W = diag(obj.G.weights);
            obj.D = obj.G.Diff;
            
            % Observation setup
            masking_rate = 0.5;
            mask = ones(obj.G.N, 1);
            if masking_rate ~= 0, mask(randperm(obj.G.N, round(masking_rate * obj.G.N))) = 0; end
            
            obj.Phi = @(z) mask .* z;
            obj.Phit = @(z) mask .* z;
            obj.sigma = 0.25;

            % Signal setup
            obj.u_true = G.org_signal;
            obj.b = obj.Phi(obj.u_true + obj.sigma * randn(size(obj.u_true)));

            % Parameters
            obj.lower = 0;
            obj.upper = 1;
            obj.alpha = 0.2;
            obj.epsilon = norm(obj.Phi(obj.u_true) - obj.b);
            obj.gamma_u = 0.1;
            obj.gamma_q = 0.1;
            obj.gamma_y1 = 1 / 30 * obj.gamma_u;
            obj.gamma_y2 = 1 / 30 * obj.gamma_q;

            % Initialize variables
            obj.u = zeros(obj.G.N, 1);
            obj.q = zeros(obj.G.Ne, 1);
            obj.y1 = zeros(obj.G.N, 1);
            obj.y2 = zeros(obj.G.Ne, 1);
        end

        function result = stopping_criteria(obj, solver)
            max_iterations = 200;
            tolerance = 1e-5;

            operator_variable = cat(1, solver.x{1}, solver.x{2}, solver.y{1}, solver.y{2});
            operator_variable_prev = cat(1, solver.x_prev{1}, solver.x_prev{2}, solver.y_prev{1}, solver.y_prev{2});
            relative_error = norm(operator_variable - operator_variable_prev) / norm(operator_variable_prev);

            if relative_error < tolerance 
                disp("Stopping criteria: relative error < tolerance met at iteration " + obj.iteration);
                result = true;

            elseif obj.iteration >= max_iterations
                disp("Stopping criteria: maximum iterations reached");
                result = true;

            elseif mod(obj.iteration, 100) == 0
                mse = norm(solver.Phi(solver.x{1}) - solver.b)^2 / norm(solver.b)^2;
                disp("Iteration " + iteration_limit.iteration + ", MSE: " + mse);
                result = false;
                obj.increment();

            else
                result = false;
                obj.increment();
            end
        end

        function obj = increment(obj)
            obj.iteration = obj.iteration + 1;
        end

        function result = solver(obj)
            import prox.*;

            prox_ball_l2_conj = prox_conj(@(z, gamma) prox_ball_l2(z, obj.b, obj.epsilon));
            prox_l1_conj = prox_conj(@(z, gamma) prox_l1(z, obj.alpha, obj.gamma_y2));

            result = PDSBuilder() ...
                .set_L(@(z) {obj.Phi(z{1}), obj.W * obj.D * z{1} - obj.W * z{2}}) ...
                .set_Lt(@(z) {obj.Phit(z{1}) + obj.D.' * obj.W.' * z{2}, - obj.W.' * z{2}}) ...
                .set_grad_f(@(z) {0, 0}) ...
                .set_prox_g({@(z, gamma) prox_box(z, obj.lower, obj.upper), @(z, gamma) (1 + gamma * (1 - obj.alpha) * obj.W)^(-1) * z}) ...
                .set_prox_h_conj({prox_ball_l2_conj, prox_l1_conj}) ...
                .set_Gamma_x({obj.gamma_u, obj.gamma_q}) ...
                .set_Gamma_y({obj.gamma_y1, obj.gamma_y2}) ...
                .set_initial_x({obj.u, obj.q}) ...
                .set_initial_y({obj.y1, obj.y2}) ...
                .set_stopping_criteria(@(solver) obj.stopping_criteria(solver)) ...
                .set_after_iteration(@(solver) disp("Iteration " + obj.iteration + " completed.")) ...
                .build();
        end
    end
end