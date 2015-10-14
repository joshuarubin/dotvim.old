# Vim Key Mappings

## Table of Contents

* [Leader Key (`,`) Mappings](#leader-mappings)
    * [General](#leader-general)
    * [Spelling](#leader-spelling)
    * [Edit Helpers (all modes) http://vimcasts.org/e/14](#leader-edit)
    * [Formatting shortcuts](#leader-formatting)
    * [Window shortcuts (normal mode)](#leader-window)
    * [Tabular (normal and visual modes)](#leader-tabular)
    * [Fugitive (normal mode)](#leader-fugitive)
    * [Go Filetype (normal mode)](#leader-go)
    * [CSS, SCSS Filetypes](#leader-css)
    * [VimShell (normal mode)](#leader-vimshell)
* [Normal Mode](#normal)
    * [Function Key Mappings](#normal-function)
    * [Ctrl Key Mappings](#normal-ctrl)
    * [Shift Key Mappings](#normal-shift)
    * [Regular Key Mappings](#normal-regular)
        * [Resize splits with `<up>` `<down>` `<left>` `<right>`](#normal-resize)
        * [Go Filetype](#normal-go)
        * [Unite (`<space>` is the prefix for `unite`)](#normal-unite)
        * [EasyMotion](#normal-easymotion)
* [Insert Mode](#insert)
    * [Ctrl Key Mappings](#insert-ctrl)
* [Visual Mode](#visual)
    * [Ctrl Key Mappings](#visual-ctrl)
* [Command Line Mode](#command)
* [Unite Window](#unite)
    * [Insert Mode](#unite-insert)
    * [Normal Mode](#unite-normal)
* [VimFiler](#vimfiler)

<a name="leader-mappings"></a>
## Leader Key (`,`) Mappings

<a name="leader-general"></a>
### General

| Mode     | Key               | Action                                                                         |
| :------: | :---------------- | :----------------------------------------------------------------------------- |
| `all`    | `<leader>=`       | Adjust viewports to be the same size                                           |
| `all`    | `<leader>fc`      | Find merge conflict markers                                                    |
| `visual` | `<leader>0`       | Run the visually selected code in python and replace it with the output        |
| `normal` | `<leader>f#`      | Set foldlevel to `#` where `0 ≤ # ≤ 9`                                         |
| `normal` | `<leader>n`       | Quickly disable search highlighting                                            |
| `normal` | ```<leader>`` ``` | Force quit all                                                                 |
| `normal` | `<leader>q`       | Quit all                                                                       |
| `normal` | `<leader>e`       | Fast editing of the .vimrc                                                     |
| `normal` | `<leader>p`       | Copy the full path of the current file to the clipboard                        |
| `normal` | `<leader>f`       | Open Quickfix                                                                  |
| `normal` | `<leader>cd`      | Switch (`cd`) to the directory of the open buffer                              |
| `normal` | `<leader>ff`      | Display all lines with keyword under cursor and ask which one to jump to       |
| `normal` | `<leader>s`       | Write the whole buffer to the current file                                     |
| `normal` | `<leader>jt`      | Reformat `JSON` with `python -m json.tool`                                     |
| `normal` | `<leader>tt`      | Toggle [Tagbar](http://majutsushi.github.io/tagbar/)                           |
| `normal` | `<leader>2`       | Toggle [Tagbar](http://majutsushi.github.io/tagbar/)                           |
| `normal` | `<leader>u`       | Toggle [undotree](https://github.com/mbbill/undotree)                          |
| `normal` | `<leader>nbu`     | Install and update configured plugins asynchronously, except for outdated ones |
| `normal` | `<leader>nbua`    | Install and update all configured plugins asynchronously                       |
| `normal` | `<leader>tag`     | Use [Dispatch](https://github.com/tpope/vim-dispatch) to run `ctags -R`        |
| `normal` | `<leader>r`       | [QuickRun](https://github.com/thinca/vim-quickrun) the current file            |
| `normal` | `<leader>?`       | Quickly open this file (`README.md`)                                           |


<a name="leader-spelling"></a>
### Spelling

| Mode     | Key               | Action                                                                                 |
| :------: | :---------------- | :------------------------------------------------------------------------------------- |
| `normal` | `<leader>ss`      | Toggle spell                                                                           |
| `normal` | `<leader>sj`      | Move to next misspelled word after the cursor                                          |
| `normal` | `<leader>sk`      | Move to previous misspelled word before the cursor                                     |
| `normal` | `<leader>sa`      | Add word under the cursor as a correctly spelled word and move to next misspelled word |
| `normal` | `<leader>sd`      | Once, for the word under/after the cursor suggest correctly spelled words              |
| `normal` | `<leader>sf`      | For the word under/after the cursor suggest correctly spelled words                    |

<a name="leader-edit"></a>
### Edit Helpers (all modes) [http://vimcasts.org/e/14](http://vimcasts.org/e/14)

| Key          | Action                                                                                                 |
| :----------- | :----------------------------------------------------------------------------------------------------- |
| `<leader>ew` | Start command to edit in the current buffer with the directory of the current buffer pre-populated     |
| `<leader>es` | Start command to edit in a new horizontal split with the directory of the current buffer pre-populated |
| `<leader>ev` | Start command to edit in a new vertical split with the directory of the current buffer pre-populated   |
| `<leader>et` | Start command to edit in a new tab with the directory of the current buffer pre-populated              |

<a name="leader-formatting"></a>
### Formatting shortcuts

| Mode     | Key           | Action                                                                   |
| :------: | :------------ | :----------------------------------------------------------------------- |
| `normal` | `<leader>fef` | Format the file using C-indenting and ‘lisp’                             |
| `normal` | `<leader>f$`  | Strip Trailing Whitespace                                                |
| `visual` | `<leader>s`   | Sort selected lines                                                      |
| `normal` | `<leader>fjs` | Format JavaScript files using [`jsbeautifier`](http://jsbeautifier.org/) |

<a name="leader-window"></a>
### Window shortcuts (normal mode)

| Key           | Action                                                   |
| :------------ | :------------------------------------------------------- |
| `<leader>v`   | Make vertical split and move cursor to it                |
| `<leader>s`   | Make horizontal split and move cursor to it              |
| `<leader>vsa` | Open a vertical split for each buffer in the buffer list |
| `<leader>m`   | Maximize current split                                   |
| `<leader>,`   | Switch to previous split                                 |
| `<leader>o`   | Make the current window the only one on the screen       |

<a name="leader-tabular"></a>
### [Tabular](https://github.com/godlygeek/tabular) (normal and visual modes)

| Key              | Action                                                         |
| :--------------- | :------------------------------------------------------------- |
| `<leader>a&`     | Line up all lines on `&`s                                      |
| `<leader>a|`     | Line up all lines on `|`s                                      |
| `<leader>a=`     | Line up all lines on `=`s                                      |
| `<leader>a:`     | Line up all lines on `:`s                                      |
| `<leader>a::`    | Line up all lines on `:`s, excluding `:` from the search match |
| `<leader>a,`     | Line up all lines on `,`s                                      |
| `<leader>a,,`    | Line up all lines on `,`s, excluding `,` from the search match |
| `<leader>a<bar>` | Line up all lines on spaces                                    |

<a name="leader-fugitive"></a>
### [Fugitive](https://github.com/tpope/vim-fugitive) (normal mode)

| Key          | Action                                                                                       |
| :----------- | :------------------------------------------------------------------------------------------- |
| `<leader>gs` | Bring up the output of `git-status` in the preview window                                    |
| `<leader>gd` | Perform a vimdiff against the current file in the version in the index                       |
| `<leader>gc` | A wrapper around `git-commit`, if there is nothing to commit, `git-status` is called instead |
| `<leader>gb` | Run `git-blame` on the file and open the results in a scroll bound vertical split            |
| `<leader>gl` | Load all previous revisions of the current file into the quickfix list                       |
| `<leader>gp` | `git push`                                                                                   |
| `<leader>gr` | Wrapper around `git-rm` that deletes the buffer afterward                                    |
| `<leader>gw` | Write to the current file's path and stage the results                                       |
| `<leader>ge` | Edit a revision                                                                              |
| `<leader>gi` | `git add -p`                                                                                 |
| `<leader>gg` | Toggle [Signify](https://github.com/mhinz/vim-signify) (git gutter)                          |
| `<leader>gv` | Open [Gitv](http://www.gregsexton.org/portfolio/gitv/) in browser mode                       |
| `<leader>gV` | Open [Gitv](http://www.gregsexton.org/portfolio/gitv/) in file mode                          |

<a name="leader-go"></a>
### [Go](http://golang.org/)  Filetype (normal mode)

| Key          | Action                                                                    |
| :----------- | :------------------------------------------------------------------------ |
| `<leader>d`  | Show the relevant GoDoc for the word under the cursor                     |
| `<leader>r`  | Calls `go run` for the current file                                       |
| `<leader>b`  | Calls `go build` for the current package                                  |
| `<leader>t`  | Calls `go test` for the current package                                   |
| `<leader>ds` | Goto declaration/definition, results are shown in a split window          |
| `<leader>dv` | Goto declaration/definition, results are shown in a vertical split window |
| `<leader>dt` | Goto declaration/definition, results are shown in a tab window            |

<a name="leader-css"></a>
### CSS, SCSS Filetypes

| Key         | Action                                |
| :---------- | :------------------------------------ |
| `<leader>S` | Sort lines within the current bracket |

<a name="leader-vimshell"></a>
### [VimShell](https://github.com/Shougo/vimshell.vim) (normal mode)

| Key          | Action                                            |
| :----------- | :------------------------------------------------ |
| `<leader>c`  | Runs VimShell in a horizontal split buffer window |
| `<leader>cc` | Runs VimShell in a horizontal split buffer window |
| `<leader>cn` | Runs `node` in VimShell interpreter               |
| `<leader>cl` | Runs `lua` in VimShell interpreter                |
| `<leader>cr` | Runs `irb` (Ruby) in VimShell interpreter         |
| `<leader>cp` | Runs `python` in VimShell interpreter             |

<a name="normal"></a>
## Normal Mode

<a name="normal-function"></a>
### Function Key Mappings

| Key   | Action                                                                                                             |
| :---- | :----------------------------------------------------------------------------------------------------------------- |
| `F1`  | Vim help using [Unite](https://github.com/Shougo/unite.vim) and [unite-help](https://github.com/Shougo/unite-help) |
| `F2`  | Open [`vimfiler`](https://github.com/Shougo/vimfiler.vim) file explorer                                            |
| `F3`  | Open [`Startify`](https://github.com/mhinz/vim-startify) start screen                                              |
| `F4`  | Save session                                                                                                       |
| `F5`  | Toggle [`GoldenView`](http://zhaocai.github.io/GoldenView.Vim/) auto resize                                        |
| `F12` | Toggle paste mode                                                                                                  |

<a name="normal-ctrl"></a>
### Ctrl Key Mappings

| Key            | Action                                                                                                                                                        |
| :------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `ctrl-p`       | Find files recursively in the current project (like [CtrlP](https://github.com/kien/ctrlp.vim)) using [Unite](https://github.com/Shougo/unite.vim) `[unite]f` |
| `ctrl-n`       | Find files recursively in the current project with option to create a new file using [Unite](https://github.com/Shougo/unite.vim) `[unite]n`                  |
| `ctrl-o`       | Find buffers using [Unite](https://github.com/Shougo/unite.vim) `[unite]b`                                                                                    |
| `ctrl-e`       | Find (e)verything using [Unite](https://github.com/Shougo/unite.vim) `[unite]<space>`                                                                         |
| `ctrl-d`       | Command history using [unite-history](https://github.com/thinca/vim-unite-history) `[unite];`                                                                 |
| `ctrl-y`       | Yank history using [Unite](https://github.com/Shougo/unite.vim) `[unite]y`                                                                                    |
| `ctrl-\`       | Quick outline using [unite-outline](https://github.com/Shougo/unite-outline) `[unite]o`                                                                       |
| `ctrl-c`       | (C)hange (c)urrent directory using [Unite](https://github.com/Shougo/unite.vim) `[unite]d`                                                                    |
| `ctrl-<space>` | Quick scratch buffer using [Unite](https://github.com/Shougo/unite.vim) and [junkfile](https://github.com/Shougo/junkfile.vim) `[unite]j`                     |
| `ctrl-ss`      | (S)earch for word under cur(s)or in current directory like `grep` using [Unite](https://github.com/Shougo/unite.vim)                                          |
| `ctrl-sd`      | (S)earch (grep) for word in current (d)irectory (prompt for word) like `grep` using [Unite](https://github.com/Shougo/unite.vim)                              |
| `ctrl-sf`      | Quickly (s)earch in (f)ile like `grep` using [Unite](https://github.com/Shougo/unite.vim)                                                                     |
| `ctrl-sa`      | Reopen last [Unite](https://github.com/Shougo/unite.vim) `grep` window                                                                                        |
| `ctrl-k`       | Smooth scroll up                                                                                                                                              |
| `ctrl-j`       | Smooth scroll down                                                                                                                                            |
| `ctrl-sr`      | Easier (s)earch and (r)eplace (for the word under the cursor)                                                                                                 |
| `ctrl-sw`      | Quickly surround word (with next character typed, e.g. `‘`, `“` or `[`                                                                                        |
| `ctrl-z`       | Cycle through splits                                                                                                                                          |
| `ctrl-b`       | Go to previous buffer                                                                                                                                         |
| `ctrl-f`       | Cycle forward through buffers                                                                                                                                 |
| `ctrl-g`       | Cycle backward through buffers                                                                                                                                |

<a name="normal-shift"></a>
### Shift Key Mappings

| Key | Action                                                                                                       |
| :-- | :----------------------------------------------------------------------------------------------------------- |
| `Q` | Closes the current window                                                                                    |
| `W` | Save the current buffer                                                                                      |
| `R` | Reindent entire file                                                                                         |
| `Y` | Join current line with next line (remapped from traditional `J`                                              |
| `_` | Quick horizontal splits                                                                                      |
| `|` | Quick vertical splits                                                                                        |
| `H` | Move cursor to the beginning of the line                                                                     |
| `L` | Move cursor to the last non-blank character of the line                                                      |
| `Z` | Navigate backward in buffer history for current window using [bufsurf](https://github.com/ton/vim-bufsurf)   |
| `X` | Navigate forward in buffer history for current window using [bufsurf](https://github.com/ton/vim-bufsurf)    |
| `N` | Repeat the latest "/" or "?" backwards                                                                       |
| `+` | Increment number under cursor                                                                                |
| `-` | Decrement number under cursor                                                                                |
| `K` | Select and/or expand selected region using [vim-expand-region](https://github.com/terryma/vim-expand-region) |
| `J` | Shrink selected region using [vim-expand-region](https://github.com/terryma/vim-expand-region)               |

<a name="normal-regular"></a>
### Regular Key Mappings

| Key       | Action                                                                    |
| :-------- | :------------------------------------------------------------------------ |
| `gp`      | Select last pasted text in visual mode                                    |
| `<enter>` | Highlight cursor location                                                 |
| `<tab>`   | Go to matching element (like `%`)                                         |
| `gb`      | Quickly switch buffers using [Unite](https://github.com/Shougo/unite.vim) |

<a name="normal-resize"></a>
#### Resize splits with `<up>` `<down>` `<left>` `<right>`

| Key       | Action                         |
| :-------- | :----------------------------- |
| `<up>`    | Increase current window height |
| `<down>`  | Decrease current window height |
| `<left>`  | Decrease current window width  |
| `<right>` | Increase current window width  |

<a name="normal-go"></a>
#### [Go](http://golang.org/) Filetype

| Key  | Action                                                           |
| :--- | :--------------------------------------------------------------- |
| `gd` | Goto declaration/definition, results are shown in a split window |

<a name="normal-unite"></a>
#### [Unite](https://github.com/Shougo/unite.vim) (`<space>` is the prefix for `unite`)

| Key              | Action                                                                                                                                                                                          |
| :--------------- | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `[unite]<space>` | Find (e)verything using [Unite](https://github.com/Shougo/unite.vim)                                                                                                                            |
| `[unite]r`       | Find strings stored in registers using [Unite](https://github.com/Shougo/unite.vim)                                                                                                             |
| `[unite]f`       | Find files recursively in the current project (like [CtrlP](https://github.com/kien/ctrlp.vim)) using [Unite](https://github.com/Shougo/unite.vim)                                              |
| `[unite]n`       | Find files recursively in the current project with option to create a new file using [Unite](https://github.com/Shougo/unite.vim)                                                               |
| `[unite]e`       | Find most recently used files using [Unite](https://github.com/Shougo/unite.vim) and [neomru](https://github.com/Shougo/neomru.vim)                                                             |
| `[unite]y`       | Yank history using [Unite](https://github.com/Shougo/unite.vim)                                                                                                                                 |
| `[unite]l`       | Find lines in the current buffer using [Unite](https://github.com/Shougo/unite.vim)                                                                                                             |
| `[unite]b`       | Find buffers using [Unite](https://github.com/Shougo/unite.vim)                                                                                                                                 |
| `[unite]/`       | Grep for pattern in the current project using [Unite](https://github.com/Shougo/unite.vim)                                                                                                      |
| `[unite]m`       | Find vim mappings using [Unite](https://github.com/Shougo/unite.vim)                                                                                                                            |
| `[unite];`       | Command history using [unite-history](https://github.com/thinca/vim-unite-history)                                                                                                              |
| `[unite]d`       | Change current (d)irectory using [Unite](https://github.com/Shougo/unite.vim)                                                                                                                   |
| `[unite]s`       | Quickly switch buffers using [Unite](https://github.com/Shougo/unite.vim)                                                                                                                       |
| `[unite]a`       | Switch [airline](https://github.com/bling/vim-airline) themes using [Unite](https://github.com/Shougo/unite.vim) and [unite-airline_themes](https://github.com/osyo-manga/unite-airline_themes) |
| `[unite]c`       | Switch vim colorscheme using [Unite](https://github.com/Shougo/unite.vim) and [unite-colorscheme](https://github.com/ujihisa/unite-colorscheme)                                                 |
| `[unite]t`       | Find files by tag using [Unite](https://github.com/Shougo/unite.vim) and [unite-tag](https://github.com/tsukkee/unite-tag)                                                                      |
| `[unite]o`       | Quick outline using [unite-outline](https://github.com/Shougo/unite-outline)                                                                                                                    |
| `[unite]h`       | Vim help using [Unite](https://github.com/Shougo/unite.vim) and [unite-help](https://github.com/Shougo/unite-help)                                                                              |
| `[unite]j`       | Quick scratch buffer using [Unite](https://github.com/Shougo/unite.vim) and [junkfile](https://github.com/Shougo/junkfile.vim)                                                                  |
| `[unite]p`       | Load a vim session using  [Unite](https://github.com/Shougo/unite.vim) and [unite-session](https://github.com/Shougo/unite-session)                                                             |

<a name="normal-easymotion"></a>
#### [EasyMotion](https://github.com/Lokaltog/vim-easymotion)

| Key | Action                     |
| :-- | :------------------------- |
| `f` | Find `{char}` to the right |
| `t` | Till `{char}` to the right |
| `F` | Find `{char}` to the left  |
| `T` | Till `{char}` to the left  |

<a name="insert"></a>
## Insert Mode

<a name="insert-ctrl"></a>
### Ctrl Key Mappings

| Key            | Action                                            |
| :------------- | :------------------------------------------------ |
| `ctrl-h`       | Move back a word, like zsh                        |
| `ctrl-l`       | Move forward a word, like zsh                     |
| `ctrl-w`       | Delete previous word, create undo point           |
| `ctrl-e`       | Go to end of line                                 |
| `ctrl-u`       | Delete until beginning of line, create undo point |
| `ctrl-a`       | Go to beginning of line                           |
| `ctrl-s`       | Save the current buffer                           |
| `ctrl-f`       | Move cursor left                                  |
| `ctrl-g`       | Move cursor right                                 |
| `ctrl-h`       | Move word left                                    |
| `ctrl-j`       | Move cursor up                                    |
| `ctrl-k`       | Move cursor up                                    |
| `ctrl-l`       | Move word right                                   |
| `ctrl-c`       | Inserts line below                                |
| `ctrl-v`       | Paste                                             |

<a name="visual"></a>
## Visual Mode

| Key       | Action                                             |
| :-------- | :------------------------------------------------- |
| `<enter>` | Highlight visual selections                        |
| `<space>` | [QuickRun](https://github.com/thinca/vim-quickrun) |

<a name="visual-ctrl"></a>
### Ctrl Key Mappings

| Key            | Action                               |
| :------------- | :----------------------------------- |
| `ctrl-c`       | Copy (works with system clipboard)   |
| `ctrl-r`       | Search and replace the selected text |
| `ctrl-s`       | Quickly start a substitution command |

<a name="command"></a>
## Command Line Mode

| Key        | Action                                                                |
| :--------- | :-------------------------------------------------------------------- |
| `cwd`      | Change working directory to that of the current file                  |
| `cd.`      | Change working directory to that of the current file                  |
| `<ctrl-a>` | Go to the beginning of the line, like zsh                             |
| `<ctrl-e>` | Go to the end of the line, like zsh                                   |
| `<ctrl-h>` | Move cursor left one word                                             |
| `<ctrl-l>` | Move cursor right one word                                            |
| `<ctrl-j>` | Move forward in command history                                       |
| `<ctrl-k>` | Move backward in command history                                      |
| `<ctrl-f>` | Move cursor left one character                                        |
| `<ctrl-g>` | Move cursor right one character                                       |
| `<ctrl-v>` | Paste                                                                 |
| `w!!`      | Save buffer using sudo                                                |
| `%%`       | Expand the directory of the current file anywhere on the command line |

<a name="unite"></a>
## [Unite](https://github.com/Shougo/unite.vim) Window

<a name="unite-insert"></a>
### Insert Mode

| Key        | Action                                                                        |
| :--------- | :---------------------------------------------------------------------------- |
| `<escape>` | Exit Unite                                                                    |
| `<ctrl-j>` | Select next line                                                              |
| `<ctrl-k>` | Select previous line                                                          |
| `<ctrl-a>` | Choose Unite action                                                           |
| `<tab>`    | Leave insert mode                                                             |
| `<ctrl-w>` | Delete a word backwards                                                       |
| `<ctrl-u>` | Delete a path backwards                                                       |
| `'`        | Quick match default Unite action                                              |
| `<ctrl-r>` | Redraw Unite window                                                           |
| `<ctrl-d>` | Unite “delete” action                                                         |
| `<ctrl-s>` | Unite select and open in horizontal split                                     |
| `<ctrl-v>` | Unite select and open in vertical split                                       |
| `<ctrl-\>` | Exit Unite (only in outline, so it closes with the same command that opens it |

<a name="unite-normal"></a>
### Normal Mode

| Key           | Action                                                                           |
| :------------ | :------------------------------------------------------------------------------- |
| `<ctrl-j>`    | Loop Unite cursor down                                                           |
| `<ctrl-k>`    | Loop Unite cursor up                                                             |
| `<tab>`       | Loop Unite cursor down                                                           |
| `<shift-tab>` | Loop Unite cursor up                                                             |
| `'`           | Quick match default Unite action                                                 |
| `<ctrl-r>`    | Redraw Unite window                                                              |
| `<ctrl-d>`    | Unite “delete” action                                                            |
| `<ctrl-s>`    | Unite select and open in horizontal split                                        |
| `<ctrl-v>`    | Unite select and open in vertical split                                          |
| `n`           | Unite “rename” action, except for `[unite]l` which causes Unite “replace” action |
| `cd`          | Unite “lcd” action (change local directory)                                      |

<a name="vimfiler"></a>
## [VimFiler](https://github.com/Shougo/vimfiler.vim)

| Key | Action      |
| :-- | :---------- |
| `e` | Expand Tree |
