classdef RandomFunction

    properties


        
    end

    methods

        function obj = RandomFunction(master_seed)

            % % Set up the root and its single child of a function-name tree
            % obj.functions{1} = containers.Map("KeyType", "char", "ValueType", "any");
            % obj.functions{1}("root") = {"top_level_functions"};

            % Set the child functions
            obj.functions{1} = containers.Map("KeyType", "char", "ValueType", "any");
            obj.functions{1}("top_level_functions") = {"generate_weights", "generate_signal", "corrupt_weights", "generate_signal_mask"};

            obj.functions{2} = containers.Map("KeyType", "char", "ValueType", "any");
            obj.functions{2}("generate_weights") = {"generate_normal_weights", "generate_truncated_normal_weights", "generate_uniform_weights"};
            % obj.functions{3}("generate_signal") = {};
            obj.functions{2}("corrupt_weights") = {"add_normal_noise", "add_truncated_normal_noise", "multiply_normal_noise", "multiply_truncated_normal_noise"};
            % obj.functions{3}("generate_signal_mask") = {};

            % Assign the global seed at the top level
            obj.seeds{1} = containers.Map("KeyType", "char", "ValueType", "any");
            obj.seeds{1}("top_level_funcitons") = {master_seed};

            % Set seeds for child functions
            for i = 1:numel{obj.functions}
                for j = 1:numel{obj.functions{i}}

                    % Get the keys of an element of 
                    keys = keys(obj.functions{j});
                    obj.seeds{i} = containers.Map(keys{:}, randi(intmax, numel(keys), 1));

            end
        end

    end