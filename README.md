# flymake-fennel

Flymake backend for [Fennel](https://fennel-lang.org).

## Installation

Make sure you have
[fennel-mode](https://git.sr.ht/~technomancy/fennel-mode) installed.

Clone the repo:

```
git clone https://git.sr.ht/~mgmarlow/flymake-fennel /path/to/flymake-fennel
```

Add `flymake-fennel` to your Emacs config:

```elisp
(add-to-list 'load-path "/path/to/flymake-fennel")
(require 'flymake-fennel)

(add-hook 'fennel-mode-hook #'flymake-mode)
(add-hook 'fennel-mode-hook #'fnl-setup-flymake-backend)
```


