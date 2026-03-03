function resultant_string = convert_list_to_string(list)

    % Convert each element of the list to a string
    string_list = string(list);

    % Concatenate the strings with underscores
    resultant_string = strjoin(string_list, "_");

end