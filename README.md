# Custom Operator to Search Using Ag/Ack/CrlSF/etc

## Installation

* Install [kana's operator](https://github.com/kana/vim-operator-user) plugin

* Install this plugin

## Usage

* Set up some custom mappings. For example:

```
map g/ <Plug>(operator-ag) " or ack/ctrlsf
map g? <Plug>(operator-ggrep)
```

* The most useful way to use this plugin is using the visual mode mapping. E.g.
  make a selection and hit `g/`.

* You may also use motions. To search in parentheses: `g/i)`.

## Customization

You can customize the Ag, Ack, CtrlSF, command if you'd like. The most common
customizations would be:

* Use regexes rather than treating search query as a literal.

```
let g:gsearch_ag_command = 'Ag!'
```

* To jump to the first result immediately.

```
let g:gsearch_ag_command = 'Ack -Q'
```

## Acknowledgements

* sjl's original tip: http://www.vimbits.com/bits/153. If you would like an
  implementation of this plugin without relying on user operators you're
  welcome to use and extend that.

* [Angelic-sedition's](https://github.com/angelic-sedition/dotfiles/blob/master/vim/.vimrc#L1278)
  original implementation. My implementation doesn't rely on unite and on
  registers.
