local lazy = require("config.lazy")
require("config.options")
require("config.keymaps")

-- lazy.nvim setup() should be called after options and keymaps
lazy.setup()
