;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Christopher J. Covert"
      user-mail-address "covertops5@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "Iosevka ss12" :size 12 :weight 'regular)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))
;;(setq doom-font (font-spec :family "Iosevka ss12" :size 18 :weight 'regular))
(setq doom-font (font-spec :family "Roboto Mono" :size 16 :weight 'regular))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq cjc-theme-list '(doom-challenger-deep doom-solarized-light))
(setq cjc-theme-index 0)
(setq doom-theme (car cjc-theme-list))

(defun cjc-toggle-themes ()
  "Switches between a list of themes"
  (interactive)
  (let* ((current-theme (nth cjc-theme-index cjc-theme-list))
         (next-index (mod (+ cjc-theme-index 1) (length cjc-theme-list)))
         (next-theme (nth next-index cjc-theme-list)))
    (disable-theme current-theme)
    (message "Theme: %s" next-theme)
    (setq cjc-theme-index next-index)
    (setq doom-theme next-theme)
    (condition-case nil
        (enable-theme next-theme)
      (error (load-theme next-theme))))
  )

(map! :leader
      :desc "Change Theme"
      "t t" #'cjc-toggle-themes)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)
(setq scroll-margin 10)

(add-to-list 'default-frame-alist '(fullscreen . maximized))

(setq cjc-notes-dir "~/notes/")
(setq cjc-notes-index (concat cjc-notes-dir "000Index.org"))
(setq org-directory cjc-notes-dir)
(setq org-roam-directory cjc-notes-dir)
(setq deft-directory cjc-notes-dir)
(setq deft-extensions '("org"))

;; create new notes using a timestamp
(setq org-roam-capture-templates
  '(("d" "default" plain (function org-roam-capture--get-point)
     "%?"
     :file-name "%<%Y-%m-%d%_H%M%S>"
     :head "#+TITLE: ${title}\n"
     :unnarrowed t)))

(defun cjc-org-edit-index ()
  (interactive)
  "Opens the index note in the current window"
  (evil-edit cjc-notes-index))

(map! :leader
      :desc "Open Org Index File"
      "o n" #'cjc-org-edit-index)

(defun cjc-all-term-mode-hook ()
  (setq scroll-margin 0))
(add-hook 'eshell-mode-hook 'cjc-all-term-mode-hook)
;; TODO verify this works on macos
(add-hook 'vterm-mode-hook 'cjc-all-term-mode-hook)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
