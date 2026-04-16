-- To install all LSPs
-- :MasonInstall astro-language-server lua-language-server vue-language-server vtsls typescript-language-server eslint-lsp html-lsp css-lsp css-variables-language-server cssmodules-language-server graphql-language-service-cli tailwindcss-language-server marksman yaml-language-server emmet-language-server json-lsp

vim.lsp.enable({
  'astro',                    -- astro-language-server
  'lua_ls',                   -- lua-language-server
  'vue_ls',                   -- vue-language-server
  'vtsls',                    -- vtsls
  -- 'ts_ls',                    -- typescript-language-server
  'eslint',                   -- eslint-lsp
  'html',                     -- html-lsp
  'cssls',                    -- css-lsp
  'css_variables',            -- css-variables-language-server
  'cssmodules_ls',            -- cssmodules-language-server
  'graphql',                  -- graphql-language-service-cli
  'tailwindcss',              -- tailwindcss-language-server
  'marksman',                 -- marksman
  'yamlls',                   -- yaml-language-server
  'emmet_language_server',    -- emmet-language-server
  'jsonls',                   -- json-lsp
})
