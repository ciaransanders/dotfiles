return {
  "nvim-mini/mini.map",
  version = "*",
  config = function()
    local map = require("mini.map")
    map.setup({
      window = {
        winblend = 0,
        width = 20,
        show_integration_count = false,
      },
      -- Your other mini.map configuration options here
      integrations = {
        require("mini.map").gen_integration.builtin_search(),
        require("mini.map").gen_integration.gitsigns(),
        require("mini.map").gen_integration.diagnostic(),
      },
    })

    -- Set up automatic refresh
    local function refresh_map()
      if map.current.buf_data ~= nil then
        map.refresh()
      end
    end

    -- Create autocommands for automatic refresh
    vim.api.nvim_create_augroup("MiniMapRefresh", { clear = true })
    vim.api.nvim_create_autocmd({
      "BufEnter",
      "BufWritePost",
      "TextChanged",
      "TextChangedI",
      "WinScrolled",
    }, {
      group = "MiniMapRefresh",
      callback = refresh_map,
    })
  end,
  keys = {
    {
      "<leader>mm",
      function()
        require("mini.map").toggle()
      end,
      desc = "Toggle mini.map",
    },
  },
}
