;;; ~shynur/.emacs.d/init.el  -*- lexical-binding: t; -*-
;;; Copyright (C) 2023 Shynur <one.last.kiss@outlook.com>

;;--------------------------------------------------------------------
;; 你可以修改的选项:
;;     - `shynur/user-first-name'
;;     - `shynur/user-full-name'
;;     - `shynur/user-emails'
;;--------------------------------------------------------------------
;; 为了获得更好的Emacs体验,你还可以进行如下的操作.
;;
;;     1. 设置环境变量:
;;         - EDITOR=bin/emacsclientw
;;         - VISUAL=$EDITOR
;;         - ALTERNATE_EDITOR=bin/runemacs
;;--------------------------------------------------------------------

(setq shynur/user-first-name "Shynur"
      shynur/user-full-name  "Shynur 谢"
      shynur/user-emails '("one.last.kiss@outlook.com" "segrece@outlook.com"))

(setq shynur/etc/ (concat
                   "~/.emacs.d/"
                   (downcase shynur/user-first-name)
                   "/etc/"))

(defun shynur/pathname-ensure-parent-directory-exist (pathname-string)
  (progn
    (require 'files)
    (make-directory (file-name-directory pathname-string) t))
  pathname-string)

;;--------------------------------------------------------------------

(custom-set-variables
 '(package-archive-priorities '(("gnu"    . 0)
                                ("nongnu" . 0)
                                ("melpa"  . 0))
                              1 (package)
                              "暂时不需要修改,因为根据`package-menu-hide-low-priority',默认选取最新的包")
 '(package-menu-hide-low-priority t
                                  2 (package))
 '(package-archives '(("gnu"    . "https://mirrors.sjtug.sjtu.edu.cn/emacs-elpa/gnu/")
                      ("nongnu" . "https://mirrors.sjtug.sjtu.edu.cn/emacs-elpa/nongnu/")
                      ("melpa"  . "https://mirrors.sjtug.sjtu.edu.cn/emacs-elpa/melpa/"))
                    3 (package)
                    "[1]其它'ELPA'中的包会依赖gnu中的包[2]'nongnu'是官方维护的[3]'MELPA'滚动升级,收录的包的数量最大[4]stable-melpa依据源码的Tag(Git)升级,数量比'MELPA'少,因为很多包作者根本不打Tag[5]Org仅仅为了org-plus-contrib这一个包,Org重度用户使用[6]gnu-devel收录GNU中的包的开发中版本,一般不必启用(类似于'MELPA'与stable-melpa的关系)[7]nongnu-devel收录'nongnu'中的包的开发中版本,一般不必启用")
 '(package-selected-packages (progn
                               ;;摘编自'https://orgmode.org/elpa.html'
                               (unless (file-exists-p (concat
                                                       shynur/etc/
                                                       ".shynur-package-refreshed"))
                                 (package-refresh-contents)
                                 (make-empty-file (concat
                                                   shynur/etc/
                                                   ".shynur-package-refreshed") t))
                               (mapcar #'(lambda (package-symbol)
                                           (unless (package-installed-p package-symbol)
                                             (package-install package-symbol))
                                           (cond
                                            ((eq package-symbol 'sly) (setq lisp-mode-hook '(sly-editing-mode))))
                                           package-symbol)
                                       '(ag expand-region sublime-themes slime-company company-quickhelp centaur-tabs helpful smex doom-themes
                                            . (highlight-parentheses
                                               dimmer
                                               rainbow-mode
                                               doom-modeline
                                               restart-emacs
                                               ivy
                                               page-break-lines
                                               sly
                                               all-the-icons
                                               swiper
                                               neotree
                                               paredit
                                               pacmacs
                                               rainbow-delimiters
                                               transwin
                                               company
                                               on-screen
                                               markdown-mode))))
                             4 (package))
 '(highlight-nonselected-windows t
                                 nil ()
                                 "除了当前选中的'window',还'高亮'非选中的'window'的'active-region'")
 '(transient-history-file (shynur/pathname-ensure-parent-directory-exist
                           (concat
                            shynur/etc/
                            "transient-history-file.el"))
                          nil (transient))
 '(transient-levels-file (shynur/pathname-ensure-parent-directory-exist
                          (concat
                           shynur/etc/
                           "transient-levels-file.el"))
                         nil (transient))
 '(transient-values-file (shynur/pathname-ensure-parent-directory-exist
                          (concat
                           shynur/etc/
                           "transient-values-file.el"))
                         nil (transient))
 '(case-fold-search t
                    nil ()
                    "search/match时忽略大小写(经试验,isearch仅在给定模式串全部是小写时忽略大小写);影响函数:`char-equal';无关函数:`string='")
 '(case-replace t
                nil (replace)
                "文本替换时,大小写敏感")
 '(blink-cursor-mode nil
                     nil (frame)
                     "取消'光标'闪烁")
 '(gc-cons-threshold (* 1000 1000 1000 4))
 '(garbage-collection-messages t
                               nil ()
                               "GC时在 echo area 显示信息,但不会并入到'*Messages*'中")
 '(gc-cons-percentage 0.5
                      nil ()
                      "没搞懂这是干嘛的")
 '(completion-styles '(basic partial-completion initials)
                     nil (minibuffer)
                     "minibuffer的补全风格(从`completion-styles-alist'中选取)")
 '(confirm-kill-emacs nil
                      nil (files)
                      "退出时,不询问“Really exit Emacs?”")
 '(completions-format 'horizontal
                      nil (minibuffer)
                      "minibuffer补全候选词在help窗口中排列的方式:尽可能的水平")
 '(blink-cursor-delay blink-cursor-delay
                      nil (frame)
                      "静止一段时间(有最小值且大于0,设置为0等价于设置为最小值)之后开始闪烁'光标'.(因为关闭了`blink-cursor-mode'所以该变量'无效')")
 '(column-number-mode t
                      nil (simple)
                      "mode line 显示列数")
 '(blink-cursor-blinks blink-cursor-blinks
                       nil (frame)
                       "'光标'闪烁的次数.(因为关闭了`blink-cursor-mode'所以该变量'无效')")
 '(completion-auto-help t
                        nil (minibuffer)
                        "一次TAB以显示help列表")
 '(completions-detailed t
                        nil (minibuffer)
                        "在'minibuffer'中对符号进行'补全'时,在符号所在的那一行显示符号的类型和'docstring'的第一行")
 '(blink-cursor-interval blink-cursor-interval
                         nil (frame)
                         "'光标'闪烁的时间间隔.(因为关闭了`blink-cursor-mode'所以该变量'无效')")
 '(truncate-lines nil
                  nil ()
                  "溢出的行尾转向下一个 screen line")
 '(confirm-kill-processes nil
                          nil (files)
                          "退出时,不询问是否要kill子进程")
 '(calendar-week-start-day 1
                           nil (calendar)
                           "'日历'中以星期一作为一周的开始")
 '(auth-sources (mapcar #'(lambda (filename-string)
                            (shynur/pathname-ensure-parent-directory-exist
                             (concat
                              shynur/etc/
                              (substring filename-string 2)))) auth-sources)
                nil (auth-source)
                "'远程登陆'的认证信息(包含明文密码)的存储位置")
 '(coding-system-for-write 'utf-8-unix
                           nil ()
                           "该customization中的NEW被Emacs设置为t")
 '(auto-save-list-file-prefix (shynur/pathname-ensure-parent-directory-exist
                               (concat
                                shynur/etc/
                                ".auto-save-list-file-prefix/")))
 '(meta-prefix-char meta-prefix-char)
 '(completion-cycle-threshold nil
                              nil (minibuffer)
                              "minibuffer补全时,按TAB会轮换候选词")
 '(current-language-environment (cond
                                 ((eq system-type 'windows-nt)
                                  "UTF-8")
                                 (t
                                  "UTF-8"))
                                nil ()
                                "如果设置为Chinese-GB18030,则`shell'能兼容Windows,且键入[C-h t]之后就会默认使用中文版的TUTORIAL.cn但更好的方式是使用`help-with-tutorial-spec-language'")
 '(completion-category-overrides completion-category-overrides
                                 nil (minibuffer)
                                 "minibuffer在不同场景下的补全风格(从`completion-styles-alist'中选取)")
 '(kill-ring-max most-positive-fixnum
                 nil (simple))
 '(delete-trailing-lines t
                         nil (simple)
                         "执行`delete-trailing-whitespace'时,还删除首尾的多余的空行")
 '(transient-mark-mode t
                       nil ()
                       "高亮'region'")
 '(mark-even-if-inactive mark-even-if-inactive
                         nil ()
                         "不知道干嘛用的")
 '(mark-ring-max mark-ring-max
                 nil (simple)
                 "太大的话就不能轮回访问了")
 '(global-mark-ring-max most-positive-fixnum
                        nil (simple)
                        "`global-mark-ring'只会在离开某个'buffer'时,记住那个'buffer'最后设置的'mark',这相当于将'buffer'作为节点的路径;因此,可以设置为较大的值")
 '(cua-mode nil)
 '(completion-ignored-extensions completion-ignored-extensions
                                 nil ()
                                 "对文件路径进行补全时,忽略这些后缀限定的文件名")
 '(confirm-nonexistent-file-or-buffer 'after-completion
                                      nil (files)
                                      "`switch-to-buffer'或`find-file'时,输入前缀并按下TAB后,若有多个候选者但仍然RET,会再确认一遍")
 '(custom-enabled-themes '(modus-vivendi)
                         nil (custom))
 '(custom-file (shynur/pathname-ensure-parent-directory-exist
                (concat
                 shynur/etc/
                 ".custom-file.el"))
               nil (cus-edit)
               "修改Emacs导出'customization'的位置,以防Emacs搅乱这个文件的'custom-set-variables'形式和'custom-set-faces'形式")
 '(doom-modeline-mode t
                      nil (doom-modeline all-the-icons))
 '(display-time-day-and-date t
                             nil (time)
                             "使`display-time-mode'显示'日期'")
 '(display-time-default-load-average 0
                                     nil (time)
                                     "使`display-time-mode'显示过去1min的平均'CPU荷载'")
 '(display-time-hook `((lambda ()
                         ,(progn
                            (require 'transwin)
                            '(transwin-ask 77)))
                       (lambda ()
                         (make-thread #'(lambda ()
                                          (while (not (boundp 'shynur/emacs-running-minutes))
                                            (sleep-for 1))
                                          (message #("爱来自Emacs喵~ 已运行[%d]min, 进程PID为[%d], 启动耗时[%.3f]s"
                                                     15 17 (face bold)
                                                     30 32 (face bold)
                                                     40 42 (face bold))
                                                   ,(progn
                                                      (require 'cl-lib)
                                                      '(cl-incf shynur/emacs-running-minutes))
                                                   ,(emacs-pid)
                                                   shynur/emacs-init-seconds)))))
                     nil (time)
                     "`display-time-mode'每次更新'时间'时调用(也即,每`display-time-interval'秒一次)")
 '(display-time-interval 60
                         nil (time)
                         "决定`display-time-mode'显示'时间'的更新频率")
 '(display-time-load-average-threshold 0
                                       nil (time)
                                       "使`display-time-mode'在'CPU荷载'>=0时,显示'CPU荷载'")
 '(display-time-mode t
                     nil (time)
                     "显示'时间',更新频率由`display-time-interval'决定.(行为上的细节受`display-time-day-and-date',`display-time-default-load-average',`display-time-load-average-threshold'影响)(为了在'时间'之后显示'电量',必须在'电量'(`display-battery-mode')之前打开此开关)")
 '(display-battery-mode t
                        nil (battery)
                        "想要将'电量'显示在'时间'之后,就必须在`display-time-mode'开启之后,再开启这个模式;显示格式受`battery-mode-line-format'影响")
 '(battery-mode-line-format battery-mode-line-format
                            nil (battery))
 '(battery-update-interval battery-update-interval
                           nil (battery))
 '(delete-selection-mode t
                         nil (delsel)
                         "选中文本后输入字符,会先删除刚刚选择的文本,再插入输入的字符")
 '(enable-recursive-minibuffers nil
                                nil ()
                                "禁用`recursive-minibuffer'")
 '(eshell-directory-name (shynur/pathname-ensure-parent-directory-exist
                          (concat
                           shynur/etc/
                           "eshell-directory-name/"))
                         nil (esh-mode))
 '(eshell-history-file-name (shynur/pathname-ensure-parent-directory-exist
                             (concat
                              shynur/etc/
                              "eshell-history-file-name.txt"))
                            nil (em-hist))
 '(eshell-last-dir-ring-file-name (shynur/pathname-ensure-parent-directory-exist
                                   (concat
                                    shynur/etc/
                                    "eshell-last-dir-ring-file-name.txt"))
                                  nil (em-dirs))
 '(eww-bookmarks-directory (shynur/pathname-ensure-parent-directory-exist
                            (concat
                             shynur/etc/
                             "eww-bookmarks-directory/"))
                           nil (eww))
 '(extended-command-suggest-shorter t
                                    nil (simple)
                                    "通过不完整的函数名调用command时,在 echo area 中提示这个command的全名")
 '(desktop-restore-frames nil
                          nil (desktop)
                          "保存'desktop'时,将'frame'和'window'的参数排除在外")
 '(desktop-save-mode nil
                     nil (desktop))
 '(desktop-path (list
                 (shynur/pathname-ensure-parent-directory-exist
                  (concat
                   shynur/etc/
                   "desktop-path/")))
                nil (desktop)
                "查找被保存的'desktop'的位置所在的目录")
 '(desktop-base-file-name "desktop-base-file-name.el"
                          nil (desktop)
                          "和`desktop-path'组合使用")
 '(desktop-base-lock-name "desktop-base-lock-name.el"
                          nil (desktop))
 '(savehist-file (shynur/pathname-ensure-parent-directory-exist
                  (concat
                   shynur/etc/
                   "savehist-file.el"))
                 nil (savehist)
                 "必须在打开`savehist-mode'之前设置此变量,否则`savehist-mode'将找不到该文件")
 '(savehist-mode t
                 nil (savehist)
                 "保存minibuffer的历史记录")
 '(savehist-autosave-interval nil
                              nil (savehist)
                              "每多少秒保存一次minibuffer的历史记录")
 '(desktop-restore-eager t
                         nil (desktop)
                         "不使用懒惰策略去恢复'desktop'")
 '(desktop-load-locked-desktop nil
                               nil (desktop)
                               "Emacs运行时会创建一个locked'dekstop'文件,如果Emacs崩溃了再启动,将忽略这个文件")
 '(desktop-auto-save-timeout nil
                             nil (desktop)
                             "取消功能:在idle时自动保存'desktop'")
 '(file-name-shadow-mode t
                         nil (rfn-eshadow)
                         "`find-file'时,若输入绝对路径,则调暗默认值的前景")
 '(fringe-mode '(0 . nil)
               nil (fringe)
               "不显示左'流苏',显示右'流苏'且使用默认宽度")
 '(global-display-line-numbers-mode t
                                    nil (display-line-numbers)
                                    "启用行首行号")
 '(display-line-numbers-type t
                             nil (display-line-numbers)
                             "启用绝对行号")
 '(global-font-lock-mode t
                         nil (font-core)
                         "全局'语法高亮'")
 '(display-line-numbers-widen nil
                              nil (display-line-numbers))
 '(neo-show-hidden-files t
                         nil (neotree))
 '(c-mode-common-hook (append c-mode-common-hook
                              (list
                               #'(lambda ()
                                   ;;见<https://www.gnu.org/software/emacs/manual/html_node/efaq/Indenting-switch-statements.html>
                                   (c-set-offset 'case-label '+))
                               #'(lambda ()
                                   ;;只保留当前编译环境下,生效的ifdef从句
                                   (progn
                                     (require 'hideif)
                                     (hide-ifdef-mode)))))
                      nil (cc-mode))
 '(neotree-mode-hook (append neotree-mode-hook
                             (list
                              #'(lambda ()
                                  ;;关闭'neotree'的行号
                                  (progn
                                    (require 'display-line-numbers)
                                    (display-line-numbers-mode -1)))))
                     nil (neotree))
 '(visible-cursor visible-cursor
                  nil ()
                  "在 text terminal 下,如果有可能的话,使'cursor'外形或特征更加显著")
 '(global-hl-line-mode t
                       nil (hl-line)
                       "'高亮'当前行")
 '(goto-line-history-local t
                           nil (simple)
                           "调用``M-g g''或``M-g M-g''(`goto-line')时,每个buffer使用自己的goto-line历史记录,而不是使用全局的")
 '(help-enable-symbol-autoload t
                               nil (help-fns)
                               "如果一个autoloaded符号的autoload形式没有提供'docstring',那就加载包含它的定义的文件,以查看它是否有'docstring'")
 '(history-delete-duplicates t
                             nil ()
                             "去重minibuffer历史记录列表")
 '(history-length t
                  nil ()
                  "使minibuffer历史记录的长度没有上限")
 '(horizontal-scroll-bar-mode nil
                              nil (scroll-bar)
                              "不显示横向'滚动条'")
 '(tab-width 4)
 '(indent-tabs-mode nil
                    nil ()
                    "制表符尽量用空格代替.(不过,诸如'Bash'脚本之类的文件编写还是需要tab字符的)")
 '(kill-whole-line nil
                   nil (simple)
                   "`C-k'不删除换行符")
 '(visible-bell t
                nil ()
                "响铃可视化.在Windows上表现为,任务栏图标闪烁")
 '(inhibit-startup-screen t
                          nil ()
                          "取消原本的 startup screen")
 '(initial-buffer-choice user-init-file)
 '(global-auto-revert-mode t
                           nil (autorevert)
                           "<https://www.gnu.org/software/emacs/manual/html_mono/efaq-w32.html#Reverting-buffers>")
 '(auto-save-interval auto-save-interval
                      nil ()
                      "两次'自动保存'之间的等待击键次数")
 '(insert-default-directory t
                            nil (minibuffer)
                            "`find-file'时,给出默认目录")
 '(integer-width 8192
                 nil ()
                 "'bignum'的位宽")
 '(isearch-resume-in-command-history nil
                                     nil (isearch)
                                     "isearch将不会出现在`command-history'中")
 '(line-move-visual t
                    nil (simple)
                    "按照 screen line 上下移动")
 '(line-number-mode nil
                    nil (simple)
                    "mode line 不显示行")
 '(max-mini-window-height max-mini-window-height
                          nil ()
                          "minubuffer最大高度:占比(float)/绝对高度(int)")
 '(message-log-max t
                   nil ()
                   "对于'*Messages*'的最大行数,不做限制")
 '(minibuffer-depth-indicate-mode t
                                  nil (mb-depth)
                                  "显示'minibuffer'的深度(e.g. “[2] Describe function: ”).(文档说仅当`enable-recursive-minibuffers'非nil时,该变量有效,但是实际上试验结果是:都有效)")
 '(minibuffer-eldef-shorten-default t
                                    nil (minibuf-eldef)
                                    "将minibuffer的prompt的默认值提示字符串改成[default-arg]的形式,以节约屏幕面积.(生效的前提是打开`minibuffer-electric-default-mode',然而,这个模式下,输入任何字符后,就会隐藏默认值(改变prompt的长度),光标会瞬间向前移动,所以拒绝使用它,那么这个变量是'无效'变量)")
 '(minibuffer-follows-selected-frame t
                                     nil ()
                                     "切换frame时,minibuffer跟着跳转(但仍然在原来的那个frame中生效)")
 '(print-circle t
                nil ()
                "使用这种循环结构表示法打印:``#1=(t . #1#)''")
 '(max-lisp-eval-depth max-lisp-eval-depth)
 '(max-specpdl-size max-specpdl-size
                    nil ()
                    "似乎在emacs-29中被废弃了")
 '(shr-offer-extend-specpdl t
                            nil (shr)
                            "'HTML'可能会有很深的嵌套,因此需要更多的'PDL'.该变量决定自动增长PDL的大小")
 '(shift-select-mode t
                     nil (simple)
                     "按住'shift'时移动光标,以选中文本")
 '(read-buffer-completion-ignore-case t
                                      nil ()
                                      "对buffer名字进行补全时,忽略大小写")
 '(read-extended-command-predicate read-extended-command-predicate
                                   nil (simple)
                                   "在minibuffer中,补全command时,决定要保留哪些候选词.默认不进行筛选")
 '(read-file-name-completion-ignore-case read-file-name-completion-ignore-case
                                         nil (minibuffer)
                                         "对文件路径进行补全时,是否忽略大小写(系统相关的)")
 '(read-quoted-char-radix 16
                          nil (simple)
                          "`C-q'后接16进制")
 '(resize-mini-windows t
                       nil ()
                       "minibuffer可以变宽变窄,由输入的字符串的行数决定")
 '(inhibit-startup-echo-area-message user-login-name
                                     nil ()
                                     "只有将该变量设置为自己在OS中的'username',才能屏蔽'startup'时 echo area 的“For information about GNU Emacs and the GNU system, type C-h C-a.”")
 '(save-place-file (shynur/pathname-ensure-parent-directory-exist
                    (concat
                     shynur/etc/
                     "save-place-file.el"))
                   nil (saveplace))
 '(save-place-mode t
                   nil (saveplace)
                   "在'session'之间保存访问文件时的浏览位置")
 '(scroll-bar-mode 'right
                   nil (scroll-bar)
                   "'滚动条'置于window右侧")
 '(search-default-mode t
                       nil (isearch)
                       "令`isearch'使用'regexp'搜索")
 '(kill-read-only-ok t
                     nil (simple)
                     "'kill'只读的文本时,不再'beep'或显示'error消息',而是仅message以解释为何被'kill'的文本没有被擦除")
 '(kill-transform-function #'(lambda (string)
                               (and (not (string-blank-p string))
                                    string))
                           nil (simple)
                           "将它应用到被'kill'的文本上,并将其返回值加入到`kill-ring'中;若返回nil则不加入.(该例选自'<https://www.gnu.org/software/emacs/manual/html_node/emacs/Kill-Options.html>')")
 '(kill-do-not-save-duplicates t
                               nil (simple)
                               "'kill'重复的文本时,不将其加入到`kill-ring'中(具体行为受`equal-including-properties'影响)")
 '(show-paren-mode t
                   nil (paren)
                   "括号前后匹配时,高亮显示")
 '(show-paren-delay 0.125
                    nil (paren)
                    "延迟0.125s时间之后,高亮成对的括号")
 '(size-indication-mode t
                        nil (simple)
                        "mode line 显示buffer大小")
 '(split-string-default-separators split-string-default-separators
                                   nil ()
                                   "`split-string'分隔字符串时默认参考的分隔位点为[ \\t\\n\\r]+")
 '(hscroll-margin 3)
 '(hscroll-step 1)
 '(suggest-key-bindings 5
                        nil (simple)
                        "_1_通过函数名调用command时,在minibuffer中提示这个command可能绑定的快捷键;_2_决定`extended-command-suggest-shorter'的显示持续时间;_3_将前面这两个提示信息持续显示5秒;_4_使command候选词列表中,各函数名的后面显示该函数绑定的快捷键")
 '(temporary-file-directory (shynur/pathname-ensure-parent-directory-exist
                             (concat
                              shynur/etc/
                              "temporary-file-directory/"))
                            nil ()
                            "'临时文件'的放置目录(隐私文件放在“/tmp/”目录是不妥的)")
 '(text-quoting-style nil
                      nil ()
                      "渲染成对的'单引号'时,尽可能使用“‘curve’”这种样式,退而求此次地可以使用“`grave'”这种样式")
 '(track-eol nil
             nil (simple)
             "上下移动时,不紧贴行尾")
 '(tramp-auto-save-directory (shynur/pathname-ensure-parent-directory-exist
                              (concat
                               shynur/etc/
                               "tramp-auto-save-directory/"))
                             nil (tramp))
 '(apropos-do-all nil
                  nil (apropos)
                  "有些'apropos'命令,在提供'prefix'参数时,会扩大查找范围.如果该变量为t,则即使不提供'prefix'参数,'apropos'命令也仍然会扩大查找范围")
 '(on-screen-global-mode t
                         nil (on-screen)
                         "在'滚卷'时提示_刚刚的/接下来新增的_visible区域,以防止在'滚卷'时迷失方向")
 '(on-screen-inverse-flag t
                          nil (on-screen)
                          "令`on-screen-global-mode'提示刚刚的visible区域")
 '(on-screen-highlight-method (nth 1 '(fringe shadow line narrow-line))
                              nil (on-screen)
                              "决定`on-screen-global-mode'如何提示")
 '(tramp-default-method (cond
                         ((eq system-type 'windows-nt)
                          "plink")
                         (t
                          tramp-default-method))
                        nil (tramp)
                        "编辑'remote-file'时,选择使用何种方法链接至服务器(MS-Windows必须先下载plink工具: <https://www.gnu.org/software/emacs/manual/html_mono/efaq-w32.html#Tramp-ssh>)")
 '(tramp-persistency-file-name (shynur/pathname-ensure-parent-directory-exist
                                (concat
                                 shynur/etc/
                                 "tramp-persistency-file-name.el"))
                               nil (tramp-cache))
 '(apropos-sort-by-scores 'verbose
                          nil (apropos))
 '(apropos-documentation-sort-by-scores 'verbose
                                        nil (apropos))
 '(uniquify-buffer-name-style 'forward
                              nil (uniquify)
                              "当buffer对应的文件名相同时,在buffer名字之前补全文件的路径,使buffer的名字互异(行为上的细节受`uniquify-strip-common-suffix'影响)")
 '(uniquify-strip-common-suffix t
                                nil (uniquify)
                                "当`uniquify-buffer-name-style'的设置涉及补全文件路径时,保留显示路径名之间相同的部分")
 '(url-cache-directory (shynur/pathname-ensure-parent-directory-exist
                        (concat
                         shynur/etc/
                         "url-cache-directory/"))
                       nil (url-cache))
 '(url-cookie-file (shynur/pathname-ensure-parent-directory-exist
                    (concat
                     shynur/etc/
                     "url-cookie-file"))
                   nil (url-cookie))
 '(user-full-name shynur/user-full-name
                  nil ()
                  "用户的'姓名'")
 '(user-mail-address (nth 0 shynur/user-emails)
                     nil ()
                     "用户的网络'邮箱'")
 '(what-cursor-show-names t
                          nil (simple)
                          "使``C-x =''(`what-cursor-position')顺便显示字符的Unicode名字")
 '(window-divider-default-places 'right-only
                                 nil (frame)
                                 "横向'拖动条'可以用 mode line 代替,所以只需要纵向'拖动条',也即,只在window的右侧显示'拖动条'")
 '(window-divider-default-right-width 12
                                      nil (simple)
                                      "设置window'拖动条'的宽度")
 '(global-company-mode t
                       nil (company))
 '(ielm-mode-hook (append ielm-mode-hook
                          (list
                           '(lambda ()
                              (paredit-mode)
                              ;;'<return>'键被`paredit-mode'占用了,那就只好把'M-<return>'换成`ielm-return',而它原来绑定的`ielm-return-for-effect'就不要了
                              (local-set-key (kbd "M-<return>") 'ielm-return))))
                  nil (ielm paredit))
 '(company-idle-delay 0
                      nil (company)
                      "令'company'进行补全猜测时,零延迟.")
 '(company-tooltip-offset-display 'lines
                                  nil (company)
                                  "原本在候选词界面的右侧是由'滚动条'的,现在改成:提示前面和后面分别有多少候选词")
 '(on-screen-delay 1
                   nil (on-screen)
                   "'on-screen'的提示持续时间")
 '(company-minimum-prefix-length 2
                                 nil (company)
                                 "当输入2个字符时,'company'就开始猜测'补全'")
 '(company-dabbrev-code-everywhere t
                                   nil (company)
                                   "还在'comment'和'string'中进行'补全'")
 '(company-dabbrev-code-other-buffers t
                                      nil (company)
                                      "在具有相同 major mode 的'buffer'中搜索'补全'候选词")
 '(company-dabbrev-code-time-limit 2
                                   nil (company)
                                   "在'current-buffer'中搜索代码块中的关键词的时间限制")
 '(company-show-quick-access t
                             nil (company)
                             "给候选词编号")
 '(company-tooltip-limit 10
                         nil (company)
                         "一次性显示候选词的数量")
 '(w32-mouse-button-tolerance w32-mouse-button-tolerance
                              nil ()
                              "如果鼠标的3个案件中有一个失灵了,可以在这么多毫秒内同时按下其余两个键,Emacs会将其识别为失灵的那个键")
 '(w32-swap-mouse-buttons nil
                          nil ()
                          "是否交换鼠标的中键和右键")
 '(dimmer-mode t
               nil (dimmer)
               "暗淡非聚焦状态的'window'(似乎可以设置渐变色)")
 '(global-highlight-parentheses-mode t
                                     nil (highlight-parentheses)
                                     "给内层括号换种颜色")
 '(sentence-end-double-space t)
 '(prog-mode-hook (append prog-mode-hook
                          (list
                           'rainbow-mode
                           'rainbow-delimiters-mode))
                  nil (prog-mode rainbow-mode rainbow-delimiters)
                  "e.g.,让“#000000”显示黑色")
 '(scroll-bar-width 30)
 '(scroll-margin 2
                 nil ()
                 "相当于,'光标'不会到达的边缘地带的宽度(单位是 screen line)")
 '(scroll-conservatively 100
                         nil ()
                         "只有这样设置,`scroll-margin'才不会伴随诡异的情况,dunno")
 '(scroll-step 1
               nil ()
               "只有这样设置,`scroll-margin'才不会伴随诡异的情况,dunno")
 '(swiper-include-line-number-in-search t
                                        nil (swiper))
 '(ivy-count-format "%d/%d "
                    nil (ivy))
 '(ivy-height 6
              nil (ivy)
              "准确来说是最大高度")
 '(minibuffer-setup-hook (append
                          minibuffer-setup-hook
                          (list
                           #'(lambda () ;令ivy的minibuffer拥有'自适应'高度
                               (add-hook 'post-command-hook
                                         #'(lambda ()
                                             (when (progn
                                                     (require 'ivy)
                                                     ivy-mode)
                                               (progn
                                                 (require 'window)
                                                 (shrink-window (1+ (progn
                                                                      (require 'ivy)
                                                                      ivy-height))))))
                                         nil
                                         t)))))
 '(calendar-mark-holidays-flag t
                               nil (calendar))
 '(ls-lisp-use-insert-directory-program nil
                                        nil (ls-lisp)
                                        "'dired'是否要使用外部的ls-like命令?(如果该变量置t,将采纳`insert-directory-program'提供的值)")
 '(insert-directory-program (cond
                             (t
                              insert-directory-program))
                            nil (files)
                            "如果需要使用外部的ls-like命令,它的路径将被存储于该变量")
 '(debug-on-error nil
                  nil ()
                  "没有对应的'handler'时进入debugger;debugger直接在error所在的环境中运行,所以很方便;但是有些'package'没有使用'user-error',所以若此变量开启,会时常进入debugger,非常麻烦,所以暂时来说,应该关掉")
 '(eval-expression-debug-on-error t
                                  nil (simple)
                                  "在`eval-expression'时暂时地将`debug-on-error'设置为t")
 '(debug-on-quit nil)
 '(comint-completion-addsuffix '("/" . " ")
                               nil (comint)
                               "'shell-mode'对pathname补全时,在pathname之后添加的字符串.(e.g., cat+.emacs.d/init.el+该变量的值)")
 '(comint-process-echoes (cond
                          ((eq system-type 'windows-nt)
                           t)
                          (t
                           comint-process-echoes))
                         nil (comint)
                         "Windows上的PowerShell会回显输入的命令(至少在'shell-mode'中是这样),设置此变量以删除它")
 '(use-empty-active-region nil
                           nil (simple)
                           "有些命令的行为取决于是否有'active''region'.'region'长度为0时应该让那些命令无视'region',因为用户很难识别长度为0的'region'")
 '(delete-active-region t
                        nil (simple)
                        "当'region''active'时,删除命令删除整个'region'而非单个字符")
 '(set-mark-command-repeat-pop nil
                               nil (simple)
                               "置t的话,轮流跳转到'mark-ring'中指定的位置时,只有第一次需要加'C-u'前缀,后续全部只需要'C-SPC'即可")
 '(shell-mode-hook (append shell-mode-hook
                           (list
                            (cond
                             ;;为运行在Windows上的'shell-mode'调用powershell以取代默认的cmd.exe
                             ((eq system-type 'windows-nt)
                              #'(lambda ()
                                  (execute-kbd-macro (string-to-vector "powershell"))))
                             (t
                              #'ignore))))
                   nil (shell))
 '(mark-even-if-inactive nil
                         nil ()
                         "不把'inactive''region'当'region'看")
 '(explicit-shell-file-name (cond
                             (t
                              explicit-shell-file-name))
                            nil (shell)
                            "'shell-mode'的默认启动SHELL(见<https://www.gnu.org/software/emacs/manual/html_mono/efaq-w32.html#Using-shell>)")
 '(server-auth-dir (shynur/pathname-ensure-parent-directory-exist
                    (concat
                     shynur/etc/
                     "server-auth-dir/"))
                   nil (server)
                   "'server-auth-dir/server-name.txt',该变量需要在`server-start'之前设置好")
 '(server-name "server-name.txt"
               nil (server)
               "'server-auth-dir/server-name.txt',该变量需要在`server-start'之前设置好")
 '(mouse-autoselect-window nil
                           nil ()
                           "当鼠标在一个'frame'上移动时,并不根据鼠标的位置自动选择'window',以防鼠标突然被碰撞导致选中其它'window'")
 '(after-init-hook (append after-init-hook
                           (list)))
 '(emacs-startup-hook (append emacs-startup-hook
                              (list
                               #'(lambda ()
                                   (make-thread #'(lambda ()
                                                    (while (not (get-file-buffer initial-buffer-choice))
                                                      (sleep-for 0.5))
                                                    (kill-buffer "*scratch*"))))
                               #'server-start ;<https://www.gnu.org/software/emacs/manual/html_mono/efaq-w32.html#Associate-files-with-Emacs>;一定要在启动之后才调用该函数,让各项参数设置好
                               #'(lambda ()
                                   (progn
                                     (require 'window)
                                     (other-window 1)
                                     (delete-other-windows)))
                               #'(lambda ()
                                   ;;记录击键
                                   (lossage-size (* 10000 10)))
                               #'(lambda ()
                                   (prefer-coding-system 'utf-8-unix)
                                   (set-coding-system-priority 'utf-8-unix))
                               #'(lambda ()
                                   (progn
                                     (require 'zone)
                                     (zone-when-idle (* 60 10))))
                               #'(lambda ()
                                   ;;与X/Windows交互'clipboard'时的编码/解码方式
                                   (progn
                                     (require 'mule)
                                     (set-selection-coding-system 'utf-8)))
                               #'(lambda ()
                                   ;;调节'beep'的声音种类,而不是音量
                                   (set-message-beep nil))
                               #'(lambda ()
                                   (defconst shynur/emacs-init-seconds (/ (- (car (time-convert after-init-time 1000))
                                                                             (car (time-convert before-init-time 1000)))
                                                                          1000.0))
				                   (setq shynur/emacs-running-minutes -2)))))
 '(tooltip-delay 0
                 nil (tooltip))
 '(tooltip-mode t
                nil (tooltip))
 '(doom-modeline-window-width-limit nil
                                    nil (doom-modeline)
                                    "即使当前窗口宽度很小,也尽量显示所有信息")
 '(inferior-lisp-program (cond
                          ((eq system-type 'windows-nt) (cond
                                                         ((string= system-name "ASUS-TX2") "d:/Progs/Steel_Bank_Common_Lisp/sbcl.exe")
                                                         (t                                inferior-lisp-program)))
                          (t                            inferior-lisp-program))
                         nil (sly))
 '(help-at-pt-display-when-idle t
                                nil (help-at-pt)
                                "光标移到 active text 处时,在 echo area 显示 'tooltip'")
 '(help-at-pt-timer-delay 0
                          nil (help-at-pt)
                          "让`help-at-pt-display-when-idle'的效果没有延迟")
 '(global-page-break-lines-mode t
                                nil (page-break-lines)
                                "将 form feed 字符渲染成别致的下划线")
 '(page-break-lines-modes '(prog-mode
                            compilation-mode
                            outline-mode
                            help-mode)
                          nil (page-break-lines))
 '(page-break-lines-lighter page-break-lines-lighter
                            nil (page-break-lines)
                            "mode-line上显示的该模式名")
 '(page-break-lines-max-width nil
                              nil (page-break-lines)
                              "渲染的下划线将会占用两个 screen line")
 '(window-divider-mode t
                       nil (frame)
                       "在window的周围显示'拖动条',用来调整window的长和宽.(横向'拖动条'可以用 mode line 代替,所以只需要纵向'拖动条',据此设置`window-divider-default-places'为right-only)(`window-divider-default-right-width'决定'拖动条'的宽度)"))

(custom-set-faces
 '(default ((t (:family  "Maple Mono SC NF"
                :foundry "outline"
                :slant  normal
                :weight normal
                :height 151
                :width  normal)))))

;;--------------------------------------------------------------------

;;详见 info emacs 10.9: 一些似乎没啥用的帮助信息
(progn
  (global-unset-key [?\C-h ?\C-c])
  (global-unset-key [?\C-h ?g])
  (global-unset-key [?\C-h ?\C-m])
  (global-unset-key [?\C-h ?\C-o])
  (global-unset-key [?\C-h ?\C-t])
  (global-unset-key [?\C-h ?\C-w]))

;;'recenter'这种东西,个人看法是没啥用
(progn
  (global-unset-key [?\C-l]))

(global-unset-key [?\C-x ?f]) ;`set-fill-column'
(global-unset-key (kbd "C-x s")) ;保存所有文件
(global-unset-key (kbd "C-x C-o")) ;删除附近空行
(global-unset-key (kbd "M-^"))
(global-unset-key (kbd "C-S-<backspace>")) ;删除一整行及其换行符
(global-unset-key (kbd "C-x DEL")) ;kill至行首
(global-unset-key (kbd "M-k")) ;kill至行尾
(global-unset-key (kbd "M-z")) ;`zap-to-char'一帧就删完了,动作太快 反应不过来

(progn
  ;;区域大小写
  (global-unset-key (kbd "C-x C-u"))
  (global-unset-key (kbd "C-x C-l"))
  ;;区域缩进
  (global-unset-key (kbd "C-M-\\")))

;;设置mark并移动point的组合命令.由于是功能上的组合,所以不是很有必要
(progn
  (global-unset-key (kbd "M-@"))
  (global-unset-key (kbd "C-M-@"))
  (global-unset-key (kbd "M-h"))
  (global-unset-key (kbd "C-M-h"))
  (global-unset-key (kbd "C-x C-p")))

;;`undo'只需要绑定到'C-/'上就够了
(progn
  (global-unset-key [?\C-_])
  (global-unset-key [?\C-x ?u]))

;;'C-c 字母'
(progn
  (global-set-key [?\C-c ?r]
                  (progn
                    (require 'restart-emacs)
                    #'restart-emacs)))

(progn
  (global-set-key [?\C-s]
                  #'(lambda ()
                      (interactive)
                      (progn
                        (require 'ivy)
                        (ivy-mode 1))
                      (condition-case nil
                          (progn
                            (require 'swiper)
                            (swiper))
                        ('quit (progn
                                 (require 'ivy)
                                 (ivy-mode -1))))
                      (progn
                        (require 'ivy)
                        (ivy-mode -1))))
  (global-set-key [?\C-r]
                  #'(lambda ()
                      (interactive)
                      (progn
                        (require 'ivy)
                        (ivy-mode 1))
                      (condition-case nil
                          (progn
                            (require 'swiper)
                            (swiper-backward))
                        ('quit (progn
                                 (require 'ivy)
                                 (ivy-mode -1))))
                      (progn
                        (require 'ivy)
                        (ivy-mode -1)))))
(progn
  (keyboard-translate ?\[ ?\()
  (keyboard-translate ?\] ?\))
  (keyboard-translate ?\( ?\[)
  (keyboard-translate ?\) ?\]))

;;--------------------------------------------------------------------

;; 保存并恢复不同'session'之间的'frame'的位置和尺寸: '<https://emacs.stackexchange.com/questions/76087/remember-restore-the-frame-position-and-size-of-the-last-session>'
;; 以下代码摘编自: '<https://github.com/portacle/emacsd/blob/master/portacle-window.el>'
;; 缺点: '窗口最大化'会被转换成'尺寸',而不是'窗口最大化'这个概念.所以新会话的'frame'仍然不是与屏幕紧密贴合的.
(when (progn
        (require 'frame)
        (display-graphic-p))
  (defconst shynur/frame-save-position-size-file
    (shynur/pathname-ensure-parent-directory-exist
     (concat
      shynur/etc/
      "shynur-frame-save-position-size-file.el")))
  (add-hook 'emacs-startup-hook
            #'(lambda ()
                (when (file-exists-p shynur/frame-save-position-size-file)
                  (progn
                    (require 'files)
                    (load-file (progn
				                 (require 'frame)
				                 shynur/frame-save-position-size-file))))))
  (add-hook 'kill-emacs-hook
            #'(lambda ()
                (let* ((props
                        '(left top width height))
                       (values
                        (mapcar #'(lambda (parameter)
                                    (let ((value
                                           (frame-parameter (selected-frame) parameter)))
                                      (if (number-or-marker-p value)
                                          (max value 0)
                                        0))) props)))
                  (with-temp-buffer
                    (progn
                      (require 'cl-macs)
                      (cl-loop for prop in props
                               for val in values
                               do (insert
                                   (format "(add-to-list 'initial-frame-alist '(%s . %d))\n"
                                           prop val))))
                    (write-file shynur/frame-save-position-size-file))))))

;;--------------------------------------------------------------------

;;--------------------------------------------------------------------
;; TODO:
;; [1]
;; 不应该单纯开启`global-display-line-numbers-mode',
;; 而是应该给出一个分类机制,有需要的mode才打开`display-line-numbers-mode'.
;; 有些mode(例如,'neotree','calendar',...)显示行号反而会占用空间.
;; [2]
;; 将_非选中的window_且_是prog-mode的buffer_全部开启全局彩虹括号
;; 'highlight-parentheses'只会高亮光标附近的括号,其余地方还是一成不变.
;; 这样不够酷炫.
;;--------------------------------------------------------------------

(require 'eglot)
(add-to-list 'eglot-server-programs '((c++-mode c-mode) "d:/Progs/clangd_15.0.6/bin/clangd.exe"))
(add-hook 'c-mode-hook 'eglot-ensure)
(add-hook 'c++-mode-hook 'eglot-ensure)
