(local fzf (require :fzf-lua))

;; configure fzf-lua
(fzf.setup
  {:winopts {:preview {:layout "vertical"
                       :vertical "up:55%"
                       :delay 0}}
   :files {:cmd "fd --no-require-git --color=never --hidden --type f --type l --exclude .git --exclude .jj"}
   :grep {:cmd "rg --no-require-git --column --line-number --no-heading --color=always --smart-case --max-columns=4096 -e"}})

;; temporarily disbable it because fzf-lua does not work well with CodeCompanion slash commands
;; see journals/daily/2025-02-19.md
;; (fzf.register_ui_select)

;; general fzf-lua commands
(local keymaps
  [{1 "<leader>f" 2 fzf.files 3 "[f]iles"}
   {1 "<leader>F"
    2 (fn []
        (fzf.files {:cwd (vim.fn.expand "%:p:h")}))
    3 "[F]ile peers"}
   {1 "<leader>b" 2 fzf.buffers 3 "buffers"}
   {1 "<leader>d" 2 fzf.diagnostics_document 3 "[d]iagnostics"}
   {1 "<leader>D" 2 fzf.diagnostics_workspace 3 "workspace [D]iagnostics"}
   {1 "<leader>/" 2 fzf.live_grep_native 3 "fuzzy search workspace"}
   {1 "<leader>?" 2 fzf.lgrep_curbuf 3 "fuzzy search current buffer"}
   {1 "<leader>j" 2 fzf.jumps 3 "[j]ump list"}])

;; lessly used commands
(local project-keymaps
  [{1 "<leader>po"
    2 (fn []
        (fzf.oldfiles {:cwd_only true}))
    3 "[o]ld files"}
   {1 "<leader>pg" 2 fzf.git_files 3 "[g]it [f]iles"}
   {1 "<leader>pw" 2 fzf.grep_cword 3 "[w]ord"}
   {1 "<leader>ph" 2 fzf.helptags 3 "[h]elp"}
   {1 "<leader>pr" 2 fzf.resume 3 "[r]esume"}
   {1 "<leader>pm" 2 fzf.builtin 3 "[m]ore..."}])

;; special directories
(local special-dir-keymaps
  [{1 "<leader>pc"
    2 (fn []
        (fzf.files {:cwd "~/.config/"}))
    3 "[c]onfigs"}
   {1 "<leader>pj"
    2 (fn []
        (fzf.files {:cwd "~/projects/journals/"}))
    3 "[j]ournals"}])

;; apply keymaps
(local apply-keymaps
  (fn [mappings]
    (each [_ mapping (ipairs mappings)]
      (local mode (or mapping.mode "n"))
      (vim.keymap.set mode mapping[1] mapping[2] {:desc mapping[3]}))))

(apply-keymaps keymaps)
(apply-keymaps project-keymaps)
(apply-keymaps special-dir-keymaps)

{:ibhagwan/fzf-lua {:dependencies [:nvim-tree/nvim-web-devicons]}} 