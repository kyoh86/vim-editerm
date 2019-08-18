# vim-editerm

A plugin sets `$EDITOR` using vim in `:terminal`.

## Screenshot

![](https://user-images.githubusercontent.com/5582459/63220140-76a44400-c1bc-11e9-8555-389aafde8a38.gif)

## INSTALLATION

With vim-plug:

```
Plug 'kyoh86/vim-editerm'
```

## CONFIGURATION

Put below lines in `.zshrc` or `.bashrc`.

```
if [[ "${VIM_EDITERM_SETUP}" != "" ]]; then
  source "${VIM_EDITERM_SETUP}" 
fi
```

## USAGE

Without being conscious.

In `:terminal`, you can `git commit` in buffer in the parent vim.

If you want to stop editing with the error (i.e. to stop to commit), call `:Cq` or `:CQ`.
