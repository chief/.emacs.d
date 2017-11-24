<img src="https://github.com/chief/.emacs.d/blob/master/logo/test.jpg" height=200/>

## Install

``` shell
git clone https://github.com/chief/.emacs.d.git ~/.emacs.d
```

## Emacs version

Tested on emacs versions >=25

## TODO

- [x] ~~Group all lisp together (elisp, clojure, paredit)~~
- [ ] Examine `add-hook` placement,
  [ref](https://github.com/jwiegley/use-package/issues/228)
- [x] ~~Enhance ruby-mode with yard paredit rubocop~~
- [x] ~~Replace fill-column-indicator~~
- [x] ~~Remove smex~~
- [ ] Examine `after` and nested declarations for `use-package`,
[ref](https://github.com/jwiegley/use-package/issues/453)
- [ ] Check warnings during installation
- [x] ~~Use  better-defaults  and remove duplications~~
- [x] ~~Bind wheel-right and wheel-left~~
- [ ] Check paredit-mode with ruby-mode, eg. space before parenthesis
- [ ] Check my-kill-region-or-line function with empty lines
- [x] ~~Add js package~~
- [ ] Check error with markdown-mode
- [ ] Optimize the use of defer in use-package
- [ ] Decrease loading time - Currently 5+ secs

## Credits

* greenonion's [dotfiles](https://github.com/greenonion/dotfiles)
* bbatsov's [prelude](https://github.com/bbatsov/prelude)
