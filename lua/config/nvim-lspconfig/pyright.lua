local system_config = require("config")
local current = system_config.completion.current

return system_config.completion[current]({})
