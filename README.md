# vim-editerm

A plugin sets `$EDITOR` using vim in `:terminal`.

## Screenshot

![](https://user-images.githubusercontent.com/5582459/63220140-76a44400-c1bc-11e9-8555-389aafde8a38.gif)

## INSTALLATION

With vim-plug:

```
Plug 'kyoh86/vim-editerm'
```

And put below lines in `.zshrc` or `.bashrc`.

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
let g:editerm_opener = 't'  " :tab <file>
```

Or by `.zshrc` or `.bashrc`

```sh
export VIM_EDITERM_OPENER="n"  # :new <file>
export VIM_EDITERM_OPENER="e"  # :edit <file>
export VIM_EDITERM_OPENER="v"  # :vnew <file>
export VIM_EDITERM_OPENER="t"  # :tab <file>
```
