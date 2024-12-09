-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.motion.leap-nvim" },
  { import = "astrocommunity.motion.nvim-surround" },
  { import = "astrocommunity.color.ccc-nvim" },
  { import = "astrocommunity.debugging.telescope-dap.nvim" },
  { import = "astrocommunity.packs.go" },
  { import = "astrocommunity.packs.svelte" },
  { import = "astrocommunity.packs.rust" },
  { import = "astrocommunity.packs.sql" },
  { import = "astrocommunity.packs.zig" },
  { import = "astrocommunity.packs.typescript-all-in-one" },
  { import = "astrocommunity.packs.toml" },
  { import = "astrocommunity.packs.json" },
}
