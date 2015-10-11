call pathogen#infect()
call pathogen#helptags()

if has("mouse")
    set mouse=a
    set mousehide
endif

set background=dark         " All terminals have dark backgrounds
colorscheme solarized       " I like solarized
set tabstop=4               " Number of visual spaces per tab
set softtabstop=4           " Number of spaces to use when tab editing
set shiftwidth=4            " >> and << should go forward / back 1 tab
set expandtab               " Tabs are spaces
set number                  " Show line numbers
set cursorline              " Hihgligh the current line
filetype plugin indent on   " Indent please
syntax enable               " Syntax highlighting 
set wildmenu                " Enable autocomplete for command
set wildmode=list:longest,full
set showmatch               " Highlight closing parentheses
set nowrap                  " Don't wrap lines by default

" Search options
set hlsearch                " Highlight search results
set smartcase               " Search strings that are all-lowercase will do a case-insensitive search
set incsearch               " Incremental search
nnoremap <CR> :noh<CR><CR>  " Clear search highlight by hitting enter

"Disable swap
set nobackup
set nowritebackup
set noswapfile

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

" Use Groovy syntax highlighting for gradle buildfiles
au BufNewFile,BufRead *.gradle setf groovy

" Set up NERDTree keybinds and options
let g:NERDTreeDirArrows=0
map <C-e> :NERDTreeToggle<CR>:NERDTreeMirror<CR>
map <F3> :NERDTreeFind<CR>
let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
let NERDTreeChDirMode=0
let NERDTreeQuitOnOpen=1
let NERDTreeMouseMode=2
let NERDTreeShowHidden=1
let NERDTreeKeepTreeInNewTab=1
let g:nerdtree_tabs_open_on_gui_startup=0

"Load the NERDTree on startup and put the cursor in the main window
"autocmd VimEnter * NERDTree
"autocmd VimEnter * wincmd p

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
map :X :x
let g:pydiction_location='~/.vim/bundle/Pydiction/complete-dict'

" Uncomment the following to have Vim jump to the last position when                                                       
" reopening a file
if has("autocmd")
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
                \| exe "normal! g'\"" | endif
endif

" For snippet_complete marker.
if has('conceal')
    set conceallevel=2 concealcursor=i
endif
"Highlight problematic whitespace
set list
set listchars=tab:,.,trail:.,extends:#,nbsp:.

"Allow tabluarizing of puppet files

function! CustomTabularPatterns()
    if exists('g:tabular_loaded')
        AddTabularPattern! block /=>
        AddTabularPattern! assignment      / = /l0
        AddTabularPattern! chunks          / \S\+/l0
        AddTabularPattern! colon           /:\zs /l0
        AddTabularPattern! comma           /^[^,]*,/l1
        AddTabularPattern! hash            /^[^>]*\zs=>/
        AddTabularPattern! options_hashes  /:\w\+ =>/
        AddTabularPattern! symbol          /^[^:]*\zs:/l1r0
        AddTabularPattern! symbols         / :/l0
        AddTabularPattern! doublequote     /"/l5c1
    endif
endfunction
autocmd VimEnter * call CustomTabularPatterns()
