# flymake-fennel

[![MELPA](https://melpa.org/packages/flymake-fennel-badge.svg)](https://melpa.org/#/flymake-fennel)

Flymake backend for [Fennel](https://fennel-lang.org).

## Installation

You probably want to install
[fennel-mode](https://git.sr.ht/~technomancy/fennel-mode) first.

Install `flymake-fennel` from
[MELPA](https://melpa.org/#/getting-started):

```
(use-package flymake-fennel
  :hook (fennel-mode . flymake-fennel-setup-backend))
```
