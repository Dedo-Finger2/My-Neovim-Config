-- Plugin manager
require("config.lazy")

-- Plugins
require("config.telescope")  -- Search files
require("config.mason")      -- LSP installer
require("config.lspconfig")  -- Lspconfiguration
require("config.cmp")        -- autocomplete
require("config.nvim-dap")   -- Debugger
require("config.conform")    -- Format on save
require("config.treesitter") -- Highlight
require("config.neocord")    -- Rich presence

-- My stuff
require("config.tint-whitespaces")
require("config.my-tweaks")
require("config.my-remap")
require("config.diagnostic-sign-icons")
require("config.hover-diagnostics")
require("config.spell-checker")
require("config.select-colorschema")("kanagawa")

-- Other
require("config.welcome-message")
