-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

-- Plugins
lvim.plugins = {
  {"epwalsh/obsidian.nvim"},
  { "RRethy/nvim-treesitter-endwise" },
  {"tpope/vim-surround"},
  { "stevearc/dressing.nvim" },
  { "rcarriga/nvim-notify" },
  { "tpope/vim-rails" },
  { "klen/nvim-test" },
  { "lukas-reineke/lsp-format.nvim" },
  { "AndrewRadev/splitjoin.vim" },
  { "windwp/nvim-ts-autotag" },
  { "mattn/emmet-vim" },
  { "MunifTanjim/eslint.nvim" },
  { "tiagovla/tokyodark.nvim" },
  { "EdenEast/nightfox.nvim" },
  { "github/copilot.vim" },
  { "norcalli/nvim-colorizer.lua" },
  { "williamboman/mason-lspconfig.nvim" },
  { "ggandor/leap.nvim"},
  {"almo7aya/openingh.nvim"},
  {"junegunn/gv.vim"},
  {"tpope/vim-fugitive"}
}

lvim.colorscheme = "duskfox"

vim.notify = require("notify")

require 'colorizer'.setup()

-- Remap access to insert and EX modes
lvim.keys.insert_mode["jk"] = "<ESC>"
lvim.keys.normal_mode[";"] = ":"
lvim.keys.normal_mode["<C-l>"] = "$"
lvim.keys.normal_mode["<C-h>"] = "^"

lvim.keys.normal_mode["<S-l>"] = "<cmd>bn<cr>"
lvim.keys.normal_mode["<S-h>"] = "<cmd>bp<cr>"

-- Send keys to nvim terminal ALT-1
lvim.builtin.which_key.mappings["d"] = {
  "<cmd>ToggleTermSendCurrentLine 0<cr>", "Send Line"
}
lvim.builtin.which_key.mappings["x"] = {
  "<cmd>ToggleTermSendVisualLines 0<cr>", "Send Visual Lines"
}

lvim.builtin.which_key.mappings["s"]["s"] = { "<cmd>Telescope grep_string<cr>", "Grep String (under cursor)" }
-- Beginning/end of line shortcuts
lvim.keys.normal_mode["<C-h>"] = "^"
lvim.keys.normal_mode["<C-l>"] = "$"

require('nvim-treesitter.configs').setup {
  endwise = {
    enable = true,
  },
}

lvim.builtin.which_key.mappings["r"] = {
  name = "Rails",
  a = { "<cmd>A<cr>", "Alternate" },
  r = { "<cmd>R<cr>", "Related" }
}

require('nvim-test').setup {
  run = true,                 -- run tests (using for debug)
  commands_create = true,     -- create commands (TestFile, TestLast, ...)
  filename_modifier = ":.",   -- modify filenames before tests run(:h filename-modifiers)
  silent = false,             -- less notifications
  term = "toggleterm",        -- a terminal to run ("terminal"|"toggleterm")
  termOpts = {
    direction = "horizontal", -- terminal's direction ("horizontal"|"vertical"|"float")
    width = 96,               -- terminal's width (for vertical|float)
    height = 12,              -- terminal's height (for horizontal|float)
    go_back = false,          -- return focus to original window after executing
    stopinsert = true,        -- exit from insert mode (true|false|"auto")
    keep_one = true,          -- keep only one terminal for testing
  },
  runners = {                 -- setup tests runners
    ruby = "nvim-test.runners.rspec",
  }
}

require('nvim-test.runners.rspec'):setup {
  command = "docker",
  args = { "exec", "-ti", "-e", "RAILS_ENV=test", "-e", "RUBYOPT=-W0", "musashi-web-1", "bundle", "exec", "rspec" },
  file_pattern = "\\v(test/.*|(_spec))\\.(rb)$",
  find_files = { "{name}_spec.{ext}" },
  filename_modifier = nil,
  working_directory = nil,
}

lvim.builtin.which_key.mappings["t"] = {
  name = "Test",
  f = { "<cmd>TestFile<cr>", "Run Tests for Current File" }
}

lvim.builtin.which_key.mappings["k"] = { "<C-l><C-w>k", "Leave Terminal" }

vim.diagnostic.config({
  virtual_text = {
    source = true,
  }
})

require("lsp-format").setup {}
require("lspconfig").solargraph.setup { on_attach = require("lsp-format").on_attach }

require("lspconfig").volar.setup({
  -- enable "take over mode" for typescript files as well: https://github.com/johnsoncodehk/volar/discussions/471
  filetypes = { "typescript", "javascript", "vue" },
  on_attach = function(client)
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
  end
})

require 'lspconfig'.eslint.setup({
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end,
})

-- require'lspconfig'.tsserver.setup{
--   init_options = {
--     plugins = {
--       {
--         name = "@vue/typescript-plugin",
--         location = "/home/matt/code/musashi/node_modules/@vue/typescript-plugin",
--         languages = {"javascript", "typescript", "vue"},
--       },
--     },
--   },
--   filetypes = {
--     "javascript",
--     "typescript",
--     "vue",
--   },
-- }

local mason_handlers = {
  ["tsserver"] = function()
    require("lspconfig").tsserver.setup {
      handlers = {
        ['textDocument/publishDiagnostics'] = function() end
      }
    }
  end
}

require("mason-lspconfig").setup_handlers(mason_handlers)

vim.g.rails_projections = {
  ["app/controllers/app/api/*_controller.rb"] = {
    test = {
      "spec/requests/app/api/{}_controller_spec.rb"
    }
  },
  ["app/controllers/*_controller.rb"] = {
    test = {
      "spec/requests/{}_controller_spec.rb"
    }
  },
  ["app/controllers/users/*_controller.rb"] = {
    test = {
      "spec/requests/users/{}_controller_spec.rb"
    }
  },
  ["spec/requests/app/api/*_spec.rb"] = {
    alternate = {
      "app/controllers/app/api/{}.rb"
    }
  },
  ["spec/requests/*_spec.rb"] = {
    alternate = {
      "app/controllers/{}.rb"
    }
  },
  ["spec/requests/users/*_spec.rb"] = {
    alternate = {
      "app/controllers/users/{}.rb"
    }
  }
}

lvim.builtin.which_key.mappings["l"]["d"] = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Goto Definition" }

require('telescope').setup {
  defaults = {
    file_ignore_patterns = { "node_modules" },
    layout_strategy = "vertical",
    layout_config = { height = 0.75 },
  }
}

require('nvim-ts-autotag').setup()


vim.g.copilot_no_tab_map = true
vim.api.nvim_set_keymap("i", "<C-T>", 'copilot#Accept("<CR>")', { silent = true, expr = true })

vim.opt.conceallevel = 1

require("obsidian").setup({
  workspaces = {
    {
      name = "personal",
      path = "~/code/notes",
    },
  },
  picker = {
    -- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', or 'mini.pick'.
    name = "telescope.nvim",
    -- Optional, configure key mappings for the picker. These are the defaults.
    -- Not all pickers support all mappings.
    mappings = {
      -- Create a new note from your query.
      new = "<C-x>",
      -- Insert a link to the selected note.
      insert_link = "<C-l>",
    },
  },
  completion = {
    -- Set to false to disable completion.
    nvim_cmp = true,
    -- Trigger completion at 2 chars.
    min_chars = 2,
  },
  mappings = {},
    -- Optional, customize how note IDs are generated given an optional title.
  ---@param title string|?
  ---@return string
  note_id_func = function(title)
    -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
    -- In this case a note with the title 'My new note' will be given an ID that looks
    -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
    local suffix = ""
    if title ~= nil then
      -- If title is given, transform it into valid file name.
      suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
    else
      -- If title is nil, just add 4 random uppercase letters to the suffix.
      for _ = 1, 4 do
        suffix = suffix .. string.char(math.random(65, 90))
      end
    end
    return tostring(os.time()) .. "-" .. suffix
  end,
  -- Optional, customize how note file names are generated given the ID, target directory, and title.
  note_path_func = function(spec)
    -- This is equivalent to the default behavior.
    local path = spec.dir / tostring(spec.id)
    return path:with_suffix(".md")
  end,
})

lvim.builtin.which_key.mappings["o"] = {
  name = "Obsidian",
  s = { "<cmd>ObsidianQuickSwitch<cr>", "Open Note" },
  n = { "<cmd>ObsidianNew<cr>", "New Note" },
}

vim.keymap.set('n',        's', '<Plug>(leap)')
vim.keymap.set('n',        'S', '<Plug>(leap-from-window)')
vim.keymap.set({'x', 'o'}, 's', '<Plug>(leap-forward)')
vim.keymap.set({'x', 'o'}, 'S', '<Plug>(leap-backward)')
