function result = create_handle_list(handle, parameters)

    result = arrayfun(@(z) struct(handle, z), parameters);

end