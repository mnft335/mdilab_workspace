% Solve the optimization problem given the object collection
function solution = solve_optimization(object_collection)

    % Extract the solver and its configuration
    optimization = object_collection.optimization;
    solver = optimization.solver;
    config_solver = optimization.config_solver;

    % Solve the optimization problem
    solution = solver(config_solver);

end