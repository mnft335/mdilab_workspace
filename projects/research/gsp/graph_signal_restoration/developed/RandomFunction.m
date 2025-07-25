classdef RandomFunction

    properties

        % Top level functions
        level{1} = containers.Map("KeyType", "char", "ValueType", "any");
        level{1}("top_level") = {"generate_weights", "generate_signal", "corrupt_weights", "generate_signal_mask"};

        level{2} = containers.Map("KeyType", "char", "ValueType", "any");
        level{2}("generate_weights") = {"generate_normal_weights", "generate_truncated_normal_weights", "generate_uniform_weights"};
        level{2}("generate_signal") = {};
        level{2}("corrupt_weights") = {"add_normal_noise", "add_truncated_normal_noise", "multiply_normal_noise", "multiply_truncated_normal_noise"};
        level{2}("generate_signal_mask") = {};
        
    end

    methods

        function obj = RandomFunction(master_seed)

            for i = 1:numel{level}

                key = keys(level{i});
                seeds = randi(intmax, numel(key), 1);
                