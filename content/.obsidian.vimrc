" leader-key
unmap <Space>
exmap openswitcher obcommand switcher:open
nmap <Space>ff :openswitcher

" Yank to system clipboard
set clipboard=unnamed

" Go back and forward with Ctrl+O and Ctrl+I
" (make sure to remove default Obsidian shortcuts for these to work)
exmap back obcommand app:go-back
nmap <C-o> :back
exmap forward obcommand app:go-forward
nmap <C-i> :forward

" sidebar
exmap toggleleftbar obcommand app:toggle-left-sidebar
nmap gh :toggleleftbar
exmap togglerightbar obcommand app:toggle-right-sidebar
nmap gl :togglerightbar

" surround
exmap surround_wiki surround [[ ]]
exmap surround_double_quotes surround " "
exmap surround_single_quotes surround ' '
exmap surround_backticks surround ` `
exmap surround_brackets surround ( )
exmap surround_square_brackets surround [ ]
exmap surround_curly_brackets surround { }

" NOTE: must use 'map' and not 'nmap'
map [[ :surround_wiki
nunmap s
vunmap s
map s" :surround_double_quotes
map s' :surround_single_quotes
map s` :surround_backticks
map sb :surround_brackets
map s( :surround_brackets
map s) :surround_brackets
map s[ :surround_square_brackets
map s[ :surround_square_brackets
map s{ :surround_curly_brackets
map s} :surround_curly_brackets

" Emulate Folding https://vimhelp.org/fold.txt.html#fold-commands
exmap togglefold obcommand editor:toggle-fold
nmap zo :togglefold
nmap zc :togglefold
nmap za :togglefold

exmap unfoldall obcommand editor:unfold-all
nmap zR :unfoldall

exmap foldall obcommand editor:fold-all
nmap zM :foldall

" tab/window
exmap tabnext obcommand workspace:next-tab
nmap H :tabnext
exmap tabprev obcommand workspace:previous-tab
nmap L :tabprev
exmap splithor obcommand workspace:split-horizontal
nmap <C-w>s :splithor
exmap splitver obcommand workspace:split-vertical
nmap <C-w>v :splitver
exmap focusleft obcommand editor:focus-left
nmap <C-h> :focusleft
nmap <C-w>h :focusleft
exmap focusright obcommand editor:focus-right
nmap <C-l> :focusright
nmap <C-w>l :focusright
exmap focustop obcommand editor:focus-top
nmap <C-k> :focustop
nmap <C-w>k :focustop
exmap focusbottom obcommand editor:focus-bottom
nmap <C-j> :focusbottom
nmap <C-w>j :focusbottom
exmap movewindow obcommand workspace:move-to-new-window
nmap <C-w>x :movewindow
