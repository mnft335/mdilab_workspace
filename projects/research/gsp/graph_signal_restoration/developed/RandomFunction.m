classdef RandomFunction

    properties

    end

    methods

        function obj = RandomFunction(master_seed)

            % Construct a random-function tree
            obj.functions{1} = containers.Map("KeyType", "char", "ValueType", "any");
            obj.functions{1}("top_level_functions") = {"generate_weights", "generate_signal", "corrupt_weights", "generate_signal_mask"};

            obj.functions{2} = containers.Map("KeyType", "char", "ValueType", "any");
            obj.functions{2}("generate_weights") = {"generate_normal_weights", "generate_truncated_normal_weights", "generate_uniform_weights"};
            obj.functions{2}("corrupt_weights") = {"add_normal_noise", "add_truncated_normal_noise", "multiply_normal_noise", "multiply_truncated_normal_noise"};

            % Set the global seed to the root
            obj.seeds{1} = containers.Map("KeyType", "char", "ValueType", "any");
            obj.seeds{1}("top_level_funcitons") = {master_seed};

            % Set seeds for children
            for i = 1:numel{obj.functions}

                % Get the keys of the current level
                parents = keys(obj.functions{i});

                for j = 1:numel(obj.functions(i))

                    childs = values(obj.functions{i}(parents(j)));
                    obj.seeds{i}
                     = containers.Map(childs{:}, randi(intmax, numel(keys), 1));

            end
        end

    end