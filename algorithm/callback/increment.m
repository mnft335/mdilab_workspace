function state = increment(config, state)

    if ~isfield(state, "i"), state.i = 0; end
    state.i = state.i + 1;

end