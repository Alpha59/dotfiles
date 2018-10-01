""""""""""""""""" Random Hacker Typer Thingy
"Hackertyper.vim
function! HackerChar()
    let hackertyperfile = expand("%") . '.ht'

    if !filereadable(hackertyperfile)
        return
    endif

    let hackertyperbuffer = readfile(hackertyperfile)

    if line(".") > len(hackertyperbuffer)
        return ' '
    endif

    let a = hackertyperbuffer[line('.') - 1][col('.') - 1]
    if a == ''
        if line(".") < line('$')
            return ''
        endif
        return  "\n"
    endif
    return a
endfun

function! StartHackerTyper()
    mapclear <buffer>
    mapclear! <buffer>
    mapclear
    mapclear!
    setlocal noautoindent
    setlocal nocindent
    setlocal nosmartindent
    setlocal indentexpr=
    setlocal formatoptions-=cro

    let chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890[]\';/.,"
    let i = 0

    while i < len(chars)
        exe "inoremap <expr> <buffer> ". chars[i] . " HackerChar()"
        let i = i + 1
    endwhile
    exe "inoremap <expr> <buffer> <Space> HackerChar()"
endfun

function! HackOff()
    mapclear <buffer>
    mapclear! <buffer>
    :! rm %.ht
    :q!
endfun

function! Hack2() range
    :w %.ht
    exe printf('%s,%sd', a:firstline, a:lastline)
    :call StartHackerTyper()
endfun

com! -range=% D <line1>,<line2>call Hack2()
com! DO call HackOff()
