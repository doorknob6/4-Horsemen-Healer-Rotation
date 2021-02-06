function()
    local periodicMove=(aura_env.markCount==aura_env.config.optStart or (aura_env.markCount-aura_env.config.optStart) % aura_env.config.optStep==0 and aura_env.markCount>aura_env.config.optStart)
    return periodicMove and aura_env.config.optMoveSound
end