return {
  "MunsMan/kitty-navigator.nvim",
  build = {
    "cp navigate_kitty.py ~/.config/kitty",
    "cp pass_keys.py ~/.config/kitty",
  },
  keys = {
    { "<C-h>", function() require("kitty-navigator").navigateLeft() end,  desc = "Move left a Split" },
    { "<C-j>", function() require("kitty-navigator").navigateDown() end,  desc = "Move down a Split" },
    { "<C-k>", function() require("kitty-navigator").navigateUp() end,    desc = "Move up a Split" },
    { "<C-l>", function() require("kitty-navigator").navigateRight() end, desc = "Move right a Split" },
  },
}
