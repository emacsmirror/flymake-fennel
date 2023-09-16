# flymake-fennel

Flymake backend for [Fennel](https://fennel-lang.org).

## Installation

Make sure you have
[fennel-mode](https://git.sr.ht/~technomancy/fennel-mode) installed.

Clone the repo:

```
git clone https://git.sr.ht/~mgmarlow/flymake-fennel /path/to/flymake-fennel
```

Require `flymake-fennel`:

```elisp
(add-to-list 'load-path "/path/to/flymake-fennel")
(require 'flymake-fennel)
```

Optionally, add `flymake-mode` to your `fennel-mode` hooks:

```elisp
(use-package fennel-mode
  :ensure t
  :hook (fennel-mode . flymake-mode))
```

Note: `flymake-fennel` automatically registers its own Flymake
backend.

