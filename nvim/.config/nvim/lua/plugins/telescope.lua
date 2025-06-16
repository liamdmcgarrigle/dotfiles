return {
  { "nvim-telescope/telescope.nvim", priority = 1000 },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      require("telescope").setup({
        extension = { ["ui-select"] = { require("telescope.themes").get_dropdown({}) } },
      })
      require("telescope").load_extension("ui-select")
    end,
  },
}
