return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "ravitemer/mcphub.nvim",
    },
    config = function()
      -- Secure API key retrieval function
      local function get_claude_api_key()
        -- Try multiple credential sources in order of preference
        local methods = {
          -- Method 1: secret-tool (GNOME Keyring/KeePassXC)
          function()
            local handle = io.popen(
              "secret-tool lookup service codecompanion account primary provider anthropic 2>/dev/null"
            )
            if handle then
              local key = handle:read("*a"):gsub("%s+", "")
              handle:close()
              return key ~= "" and key or nil
            end
            return nil
          end,

          -- Method 2: Environment variable (fallback)
          function()
            return os.getenv("ANTHROPIC_API_KEY")
          end,
        }

        for _, method in ipairs(methods) do
          local key = method()
          if key then
            return key
          end
        end

        vim.notify(
          "Claude API key not found. Please configure credentials using secret-tool or environment variable.",
          vim.log.levels.ERROR
        )
        return nil
      end

      -- Setup CodeCompanion
      require("codecompanion").setup({
        adapters = {
          anthropic = function()
            return require("codecompanion.adapters").extend("anthropic", {
              env = {
                api_key = get_claude_api_key,
              },
              schema = {
                model = {
                  default = "claude-3-5-sonnet-20241022",
                },
                max_tokens = { default = 8192 },
              },
            })
          end,
        },
        strategies = {
          chat = { adapter = "anthropic" },
          inline = { adapter = "anthropic" },
          agent = { adapter = "anthropic" },
        },
        display = {
          chat = {
            window = {
              layout = "vertical",
              position = "right",
              width = 0.35,
              border = "single",
              relative = "editor",
              full_height = true,
            },
            show_header_separator = true,
          },
        },
      })

      -- Suggested keymappings
      vim.keymap.set({ "n", "v" }, "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
      vim.keymap.set(
        { "n", "v" },
        "<LocalLeader>a",
        "<cmd>CodeCompanionChat Toggle<cr>",
        { noremap = true, silent = true }
      )
      vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })

      -- Expand 'cc' into 'CodeCompanion' in the command line
      vim.cmd([[cab cc CodeCompanion]])
    end,
  },
  {
    "echasnovski/mini.diff",
    config = function()
      local diff = require("mini.diff")
      diff.setup({
        -- Disabled by default
        source = diff.gen_source.none(),
      })
    end,
  },
}
