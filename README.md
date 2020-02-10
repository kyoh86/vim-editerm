# vim-editerm

A plugin sets `$EDITOR` in `:terminal` to open a file in the working vim instead of a new one.

Usually, calling `git commit`, `vim` and suchlike commands in |:terminal|,  
new vim process starts in their.
But it makes some unfavorable situation depending on the settings.

This plugin, *vim-editerm* will set an environment varialble `$EDITOR` and
override `vim` command with function that drops files in new buffer in parent
vim.

## Screenshot

![](https://user-images.githubusercontent.com/5582459/63220140-76a44400-c1bc-11e9-8555-389aafde8a38.gif)

## INSTALLATION

With vim-plug:

```
Plug 'kyoh86/vim-editerm'
```

And if you want to override `vim` and create commands `:edit|new|vnew|tabnew` in `:terminal`, put below lines in `.zshrc` or `.bashrc`.

```
if [[ "${VIM_EDITERM_SETUP}" != "" ]]; then
  source "${VIM_EDITERM_SETUP}"
fi
```

## USAGE

Without being conscious.

In `:terminal`, you can `git commit` in buffer in the parent vim.

If you want to stop editing with the error (i.e. to stop to commit), call `:Cq` or `:CQ`.

## CONFIGURATION

### Behavior to open files

We can change behavior to open files.

```vim
let g:editerm_opener = 'n'  " :new <file> (default)
let g:editerm_opener = 'e'  " :edit <file>
let g:editerm_opener = 'v'  " :vnew <file>
let g:editerm_opener = 't'  " :tabnew <file>
```

Or by `.zshrc` or `.bashrc`

```sh
export VIM_EDITERM_OPENER="n"  # :new <file>
export VIM_EDITERM_OPENER="e"  # :edit <file>
export VIM_EDITERM_OPENER="v"  # :vnew <file>
export VIM_EDITERM_OPENER="t"  # :tabnew <file>
```

### Definition of the dropping commands

`vim-editerm` will create below commands which drop files to vim.

```shell
:drop <files...>
:edit <files...>
:new <files...>
:vnew <files...>
:tabnew <files...>
```

If you want to supress them:

```vim
let g:editerm_defdrop = '0'  " default: '1'
```

And if you want to change prefix of them:

```vim
let g:editerm_defdrop_prefix = 'vim_'  " default: ':'
```

## Similar projects

- [lambdalisue/edita.vim](https://github.com/lambdalisue/edita.vim)
  - **no external dependencies**

# LICENSE

[![MIT License](http://img.shields.io/badge/license-MIT-blue.svg)](http://www.opensource.org/licenses/MIT)

This software is released under the [MIT License](http://www.opensource.org/licenses/MIT), see LICENSE.
