if g:dein#_cache_version !=# 150 || g:dein#_init_runtimepath !=# '/home/paddi/.vim,/usr/share/vim/vimfiles,/usr/share/vim/vim81,/usr/share/vim/vimfiles/after,/home/paddi/.vim/after,/home/paddi/.vim/dein/repos/github.com/Shougo/dein.vim' | throw 'Cache loading error' | endif
let [plugins, ftplugin] = dein#load_cache_raw(['/home/paddi/.vimrc'])
if empty(plugins) | throw 'Cache loading error' | endif
let g:dein#_plugins = plugins
let g:dein#_ftplugin = ftplugin
let g:dein#_base_path = '/home/paddi/.vim/dein'
let g:dein#_runtime_path = '/home/paddi/.vim/dein/.cache/.vimrc/.dein'
let g:dein#_cache_path = '/home/paddi/.vim/dein/.cache/.vimrc'
let &runtimepath = '/home/paddi/.vim,/usr/share/vim/vimfiles,/home/paddi/.vim/dein/repos/github.com/junegunn/fzf,/home/paddi/.vim/dein/repos/github.com/Shougo/dein.vim,/home/paddi/.vim/dein/.cache/.vimrc/.dein,/usr/share/vim/vim81,/home/paddi/.vim/dein/.cache/.vimrc/.dein/after,/usr/share/vim/vimfiles/after,/home/paddi/.vim/after'
