local utils = require("utils")

local attach_common = function(client,bufnr)
     vim.cmd("set completeopt=menuone,noinsert,noselect")
    require('completion').on_attach()

    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end


    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
    -- Mappings.
    local opts = { noremap=true, silent=true }
    buf_set_keymap('i', '<c-o>', '<Cmd>lua vim.lsp.omnifunc()<CR>', opts)
    -- vim.cmd("imap <silent> <c-p> <Plug>(completion_trigger)")
    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', '<c-]>', '<Cmd>lua jumpToDef(vim.lsp.buf.definition)<CR>', opts)
    -- buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<leader>law', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<leader>lrw', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<leader>llw', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', '<leader>lt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<leader>lrn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '-lrf', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<leader>ld', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    buf_set_keymap('n', '<leader>ll', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
    buf_set_keymap('n', '<leader>lca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)

    -- Set some keybinds conditional on server capabilities
    if client.resolved_capabilities.document_formatting then
        buf_set_keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    elseif client.resolved_capabilities.document_range_formatting then
        buf_set_keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
    end

-- Set autocommands conditional on server_capabilities
    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec([[
        hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
        hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
        hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
        augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        augroup END
        ]], false)
    end
    vim.cmd("inoremap <cr> <Cmd> call TzzEnter()<Cr>")
end


function tzz_jump_def()
    vim.cmd("OmniSharpGotoDefinition")
end

local on_attach_omni_sharp = function(client, bufnr)
    local opts = { noremap=true, silent=true }
    attach_common(client,bufnr)
     vim.api.nvim_buf_set_keymap(bufnr,'n', '<c-]>', '<Cmd>lua jumpToDef(tzz_jump_def)<CR>', opts ) 
     -- :OmniSharpGotoDefinition
end

local on_attach = function(client, bufnr)
    attach_common(client,bufnr)
end


local nvim_lsp = require('lspconfig')
-- require'snippets'.use_suggested_mappings(true) -- for snippets.vim
local capabilities = vim.lsp.protocol.make_client_capabilities()

-- Code actions
capabilities.textDocument.codeAction = {
  dynamicRegistration = false;
      codeActionLiteralSupport = {
          codeActionKind = {
              valueSet = {
                 "",
                 "quickfix",
                 "refactor",
                 "refactor.extract",
                 "refactor.inline",
                 "refactor.rewrite",
                 "source",
                 "source.organizeImports",
              };
          };
      };
}

local vimfn = vim.fn


function jumpToDef(doJump)
    if utils.buffer_modified() and (vimfn.len(vimfn.win_findbuf(vimfn.bufnr('%'))) < 2 )then
        vim.cmd("normal -vs")
    end
    -- vim.lsp.buf.definition()
    doJump()
end

-- Snippets
capabilities.textDocument.completion.completionItem.snippetSupport = true;

local omni_sharp_bin_path = "/home/tzz/tools/omni_sharp/run"
-- LSPs
 local servers = { "pyright", "rust_analyzer", "gopls", "tsserver","dartls" }
--  local servers = { "pyright", "rust_analyzer", "gopls", "tsserver","dartls" }
for _, lsp in ipairs(servers) do
    local params = { 
        capabilities = capabilities;
        on_attach = on_attach;
        init_options = {
            onlyAnalyzeProjectsWithOpenFiles = true,
            suggestFromUnimportedLibraries = false,
            closingLabels = true,
        };
    }
    if (lsp == "omnisharp") then
        params.cmd = {omni_sharp_bin_path,"--languageserver"}
         -- params.on_attach = on_attach_omni_sharp
    end
    nvim_lsp[lsp].setup(params) 
end
