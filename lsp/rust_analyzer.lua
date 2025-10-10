-- Rust Analyzer LSP Configuration for Neovim 0.11
return {
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  root_markers = { "Cargo.toml" },
  settings = {
    ["rust-analyzer"] = {
      checkOnSave = {
        command = "clippy",
        extraArgs = { "--all-features", "--no-deps" },
      },
      procMacro = {
        enable = true,
      },
      inlayHints = {
        bindingModeHints = { enable = true },
        closureReturnTypeHints = { enable = "always" },
        expressionAdjustmentHints = { enable = "always" },
        lifetimeElisionHints = { enable = "always", useParameterNames = true },
      },
    },
  },
}