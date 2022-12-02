# for emacs, create {HOME}/.emacs.d/init.el with followng lines

(require 'mozc)  ; or (load-file "/path/to/mozc.el")
(setq default-input-method "japanese-mozc")
(setq mozc-candidate-style 'overlay)
