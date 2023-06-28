local lsp = require'lspconfig'
local coq = require "coq"

function File_exists(name)
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

-- Bash
lsp.bashls.setup{}
lsp.bashls.setup(coq.lsp_ensure_capabilities{})


-- C/C++
if File_exists("./build/compile_commands.json") then
    vim.g.clang_compilation_database = "./build"
elseif File_exists("./cmake-build-debug/compile_commands.json") then
    vim.g.clang_compilation_database = "./cmake-build-debug"
elseif File_exists("./cmake-build-release/compile_commands.json") then
    vim.g.clang_compilation_database = "./cmake-build-release"
else
    vim.g.clang_compilation_database = nil
end

lsp.clangd.setup{}
lsp.clangd.setup(coq.lsp_ensure_capabilities{})

-- CMake
lsp.cmake.setup{}
lsp.cmake.setup(coq.lsp_ensure_capabilities{})

-- CSS
local css_capabilities = vim.lsp.protocol.make_client_capabilities()
css_capabilities.textDocument.completion.completionItem.snippetSupport = true
lsp.cssls.setup{}
lsp.cssls.setup(coq.lsp_ensure_capabilities{
    capabilities = css_capabilities,
    cmd = { "vscode-css-languageserver", "--stdio" }
})

-- Go
lsp.gopls.setup{}
lsp.gopls.setup(coq.lsp_ensure_capabilities{})

-- HTML
local html_capabilities = vim.lsp.protocol.make_client_capabilities()
html_capabilities.textDocument.completion.completionItem.snippetSupport = true
lsp.html.setup{}
lsp.html.setup(coq.lsp_ensure_capabilities{
    capabilities = html_capabilities,
    cmd = { "vscode-html-languageserver", "--stdio" }
})

-- Json
lsp.jsonls.setup{}
lsp.jsonls.setup(coq.lsp_ensure_capabilities{})

-- Latex
lsp.texlab.setup{}
lsp.texlab.setup(coq.lsp_ensure_capabilities{})

-- Lua
lsp.lua_ls.setup{}
lsp.lua_ls.setup(coq.lsp_ensure_capabilities{
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim', 'use'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
})

-- Python
vim.g.virtualenv_directory = "."
lsp.pylsp.setup{}
lsp.pylsp.setup(coq.lsp_ensure_capabilities{})

-- Rust
lsp.rust_analyzer.setup{}
lsp.rust_analyzer.setup(coq.lsp_ensure_capabilities{})

-- Vim
lsp.vimls.setup{}
lsp.vimls.setup(coq.lsp_ensure_capabilities{})


vim.cmd('COQnow -s')
