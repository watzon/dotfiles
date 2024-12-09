local user = vim.env.USER or "User"

---@type LazySpec
return {
  "Shatur/neovim-ayu",

  {
    "watzon/goshot.nvim",
    cmd = "Goshot",
    opts = {
      binary = "goshot",
      auto_install = false,
    },
    keys = {
      { "<leader>bS", "<cmd>Goshot<cr>", mode = { "n" }, desc = "Take screenshot" },
      { "<leader>bS", "<cmd>'<,'>Goshot<cr>", mode = { "v" }, desc = "Take screenshot of selection" },
    },
  },

  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = true,
    cmd = { "CodeCompanion", "CodeCompanionActions", "CodeCompanionCmd", "CodeCompanionChat" },
    opts = function()
      -- Function to read system prompt from .codecompanion file
      local function get_system_prompt()
        local root = vim.fn.getcwd()
        local prompt_file = root .. "/.codecompanion"

        if vim.fn.filereadable(prompt_file) == 1 then
          local f = io.open(prompt_file, "r")
          if f then
            local content = f:read "*all"
            f:close()
            return content
          end
        end
        return nil
      end

      local system_prompt = get_system_prompt()

      return {
        adapters = {
          anthropic = function()
            return require("codecompanion.adapters").extend("anthropic", {
              name = "anthropic",
              env = {
                api_key = "ANTHROPIC_API_KEY",
              },
              schema = {
                model = {
                  default = "claude-3-5-sonnet-20241022",
                },
                system = system_prompt, -- Add system prompt if available
              },
            })
          end,
        },
        strategies = {
          chat = {
            adapter = "anthropic",
            roles = {
              llm = "  CodeCompanion",
              user = " " .. user:sub(1, 1):upper() .. user:sub(2),
            },
            keymaps = {
              close = { modes = { n = "q", i = "<C-c>" } },
              stop = { modes = { n = "<C-c>" } },
            },
          },
          inline = { adapter = "anthropic" },
          agent = { adapter = "anthropic" },
        },
        display = {
          chat = {
            show_settings = true,
            render_headers = false,
          },
        },
      }
    end,
    keys = {
      { "<leader>aa", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "Action Palette" },
      { "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "Toggle Chat" },
      { "<leader>aA", "<cmd>CodeCompanionChat Add<cr>", mode = "n", desc = "Add Code" },
      { "<leader>ai", "<cmd>CodeCompanion<cr>", mode = { "n", "v" }, desc = "Inline Prompt" },
    },
  },

  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>a", group = "󱚦 ai" },
      },
    },
  },

  {
    "folke/edgy.nvim",
    opts = function(_, opts)
      opts.left = opts.left or {}
      opts.bottom = opts.bottom or {}
      opts.right = opts.right or {}

      -- CodeCompanion on the right
      table.insert(opts.right, {
        ft = "codecompanion",
        title = "CodeCompanion",
        size = { width = 70 },
      })
    end,
  },
}
