vim.g.rails_projections = {
  ["app/controllers/app/api/*_controller.rb"] = {
    test = {
      "spec/requests/app/api/{}_controller_spec.rb",
    },
  },
  ["app/controllers/*_controller.rb"] = {
    test = {
      "spec/requests/{}_controller_spec.rb",
    },
  },
  ["app/controllers/users/*_controller.rb"] = {
    test = {
      "spec/requests/users/{}_controller_spec.rb",
    },
  },
  ["spec/requests/app/api/*_spec.rb"] = {
    alternate = {
      "app/controllers/app/api/{}.rb",
    },
  },
  ["spec/requests/*_spec.rb"] = {
    alternate = {
      "app/controllers/{}.rb",
    },
  },
  ["spec/requests/users/*_spec.rb"] = {
    alternate = {
      "app/controllers/users/{}.rb",
    },
  },
}

return {
  { "tpope/vim-rails" },
  {
    vim.keymap.set("n", "ra", "<cmd>A<cr>", { desc = "Alternate" }),
    vim.keymap.set("n", "rr", "<cmd>R<cr>", { desc = "Relative" }),
  },
}
