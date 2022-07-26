local lsp = require'lspconfig'
local coq = require "coq"

function file_exists(name)
   local f=io.open(name,"r")
   if f~=nil then io.close(f) return true else return false end
end


-- Avoid showing extra messages when using completion
vim.cmd('set shortmess+=c')

-- Set completeopt to have a better completion experience
-- :help completeopt
-- menuone: popup even when there's only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not select, force user to select one from the menu
vim.cmd('set completeopt=menuone,noinsert,noselect')

local opts = {
    tools = { -- rust-tools options
        autoSetHints = true,
        hover_with_actions = true,
        inlay_hints = {
            show_parameter_hints = true,
            parameter_hints_prefix = "",
            other_hints_prefix = "",
        },
    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
    server = {
        -- on_attach is a callback called when the language server attachs to the buffer
        -- on_attach = on_attach,
        settings = {
            -- to enable rust-analyzer settings visit:
            -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
            ["rust-analyzer"] = {
                -- enable clippy on save
                checkOnSave = {
                    command = "clippy"
                },
            }
        }
    },
}
require('rust-tools').setup(opts)

-- Rust
lsp.rust_analyzer.setup{}
lsp.rust_analyzer.setup(coq.lsp_ensure_capabilities{})

-- C/C++
if file_exists("./build/compile_commands.json") then
    vim.g.clang_compilation_database = "./build"
elseif file_exists("./cmake-build-debug/compile_commands.json") then
    vim.g.clang_compilation_database = "./cmake-build-debug"
elseif file_exists("./cmake-build-release/compile_commands.json") then
    vim.g.clang_compilation_database = "./cmake-build-release"
else
    vim.g.clang_compilation_database = nil
end

lsp.clangd.setup{}
lsp.clangd.setup(coq.lsp_ensure_capabilities{})

-- CMake
lsp.cmake.setup{}
lsp.cmake.setup(coq.lsp_ensure_capabilities{})

vim.cmd('COQnow -s')
