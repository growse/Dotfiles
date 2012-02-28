call pathogen#infect()
call pathogen#helptags()

if has("mouse")
	set mouse=a
	set mousehide
endif

if has("gui_running") " gvim/win32 fails to do this automatically
	set lines=50 columns=100
	if has("gui_win32")
		source $VIMRUNTIME/mswin.vim
		set guifont=Consolas:h10:cANSI
		set background=dark
	else
		set guifont=Inconsolata:h14
		set background=light
	endif
else
	set background=dark
endif

if has("win32")
	cd $HOME " Default cwd is System32, which is stupid
endif

" Search options
set hlsearch    " Highlight search results
set smartcase   " Search strings that are all-lowercase will do a case-insensitive search
set incsearch   " Incremental search
nnoremap <CR> :noh<CR><CR>  " Clear search highlight by hitting enter

set number      " Show line numbers
set shiftwidth=4
set tabstop=4
set hlsearch    " Highlight search results
set smartcase   " Search strings that are all-lowercase will do a case-insensitive search
set incsearch   " Incremental search

syntax enable
filetype plugin indent on
colorscheme solarized

set laststatus=2
set statusline=[%l,%v\ %P%M]\ %f\ %y%r%w[%{&ff}]%{fugitive#statusline()}\ %b\ 0x%B
"set t_Co=256
"call togglebg#map("<F5>")

" Save Taskpaper files automatically and use light background
autocmd BufLeave,FocusLost *.taskpaper w
autocmd Filetype taskpaper set background=light

" Run wrapwithtag.vim script when opening html docs (shouldn't this be a
" filetype plugin? meh.)
autocmd Filetype html,xml,aspvbs runtime scripts/wrapwithtag.vim

" Use aspvbs filetype for .asa and .asp files so we get syntax highlighting
let g:filetype_asa = "aspvbs"
let g:filetype_asp = "aspvbs"

" Use Groovy syntax highlighting for gradle buildfiles
au BufNewFile,BufRead *.gradle setf groovy

" Set up NERDTree keybinds and options
map <F3> :NERDTreeFind<CR>
map <F4> :NERDTreeToggle<CR>u
let NERDTreeChDirMode=2 " pwd follows NERDtree
let NERDTreeHijackNetrw=0 " So vcscommand can commit directories
let NERDTreeIgnore=['^CVS$', '^\.svn$', '\~$']
let g:NERDTreeDirArrows=0

"Load the NERDTree on startup and put the cursor in the main window
autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p

autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()

" Close all open buffers on entering a window if the only
" buffer that's left is the NERDTree buffer
function! s:CloseIfOnlyNerdTreeLeft()
  if exists("t:NERDTreeBufName")
    if bufwinnr(t:NERDTreeBufName) != -1
      if winnr("$") == 1
        q
      endif
    endif
  endif
endfunction

:set pastetoggle=<F11>

" Set up taglist keybinds
map <F5> :TlistToggle<CR>
let Tlist_Use_Right_Window=1

command! -range=% Entities :<line1>,<line2>call Entities()
function! Entities()
  silent s/�/\&Agrave;/eg
  silent s/�/\&Aacute;/eg
  silent s/�/\&Acirc;/eg
  silent s/�/\&Atilde;/eg
  silent s/�/\&Auml;/eg
  silent s/�/\&Aring;/eg
  silent s/�/\&AElig;/eg
  silent s/�/\&Ccedil;/eg
  silent s/�/\&Egrave;/eg
  silent s/�/\&Eacute;/eg
  silent s/�/\&Ecirc;/eg
  silent s/�/\&Euml;/eg
  silent s/�/\&Igrave;/eg
  silent s/�/\&Iacute;/eg
  silent s/�/\&Icirc;/eg
  silent s/�/\&Iuml;/eg
  silent s/�/\&ETH;/eg
  silent s/�/\&Ntilde;/eg
  silent s/�/\&Ograve;/eg
  silent s/�/\&Oacute;/eg
  silent s/�/\&Ocirc;/eg
  silent s/�/\&Otilde;/eg
  silent s/�/\&Ouml;/eg
  silent s/�/\&Oslash;/eg
  silent s/�/\&Ugrave;/eg
  silent s/�/\&Uacute;/eg
  silent s/�/\&Ucirc;/eg
  silent s/�/\&Uuml;/eg
  silent s/�/\&Yacute;/eg
  silent s/�/\&THORN;/eg
  silent s/�/\&szlig;/eg
  silent s/�/\&agrave;/eg
  silent s/�/\&aacute;/eg
  silent s/�/\&acirc;/eg
  silent s/�/\&atilde;/eg
  silent s/�/\&auml;/eg
  silent s/�/\&aring;/eg
  silent s/�/\&aelig;/eg
  silent s/�/\&ccedil;/eg
  silent s/�/\&egrave;/eg
  silent s/�/\&eacute;/eg
  silent s/�/\&ecirc;/eg
  silent s/�/\&euml;/eg
  silent s/�/\&igrave;/eg
  silent s/�/\&iacute;/eg
  silent s/�/\&icirc;/eg
  silent s/�/\&iuml;/eg
  silent s/�/\&eth;/eg
  silent s/�/\&ntilde;/eg
  silent s/�/\&ograve;/eg
  silent s/�/\&oacute;/eg
  silent s/�/\&ocirc;/eg
  silent s/�/\&otilde;/eg
  silent s/�/\&ouml;/eg
  silent s/�/\&oslash;/eg
  silent s/�/\&ugrave;/eg
  silent s/�/\&uacute;/eg
  silent s/�/\&ucirc;/eg
  silent s/�/\&uuml;/eg
  silent s/�/\&yacute;/eg
  silent s/�/\&thorn;/eg
  silent s/�/\&yuml;/eg
  silent s/�/\&#x92;/eg
endfunction

" for typos
map :W :w
map :E :e

