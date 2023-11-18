# flymake-fennel

Flymake backend for [Fennel](https://fennel-lang.org).

## Installation

Make sure you have
[fennel-mode](https://git.sr.ht/~technomancy/fennel-mode) installed.

Install from VC:

```
M-x package-vc-install RET https://git.sr.ht/~mgmarlow/flymake-fennel
```

Add `flymake-fennel` to your Emacs config:

```elisp
(add-hook 'fennel-mode-hook #'flymake-fennel-setup)
```

