function result = create_grid(config)

    [result{1:numel(config)}] = ndgrid(config{:});

end