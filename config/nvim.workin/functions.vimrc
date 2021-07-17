" Rename
" -------------------------------------------
"  A function to :saveas and remove the old file
" -------------------------------------------
command! -nargs=* -complete=file -bang Rename :call Rename("<args>", "<bang>")

function! Rename(name, bang)
    let l:curfile = expand("%:p")
    let l:curfile_stripped = substitute(l:curfile, " ", "\\\\ ", "g")
    let l:curfilepath = expand("%:p:h")
    let l:newname = l:curfilepath . "/" . a:name
    let l:newname = substitute(l:newname, " ", "\\\\ ", "g")
    let v:errmsg = ""

    silent! exe "saveas " . a:bang . " " . l:newname
    if v:errmsg =~# '^$\|^E329'
        if expand("%:p") !=# l:curfile && filewritable(expand("%:p"))
            silent exe "bwipe! " . l:curfile_stripped
            if delete(l:curfile)
                echoerr "Could not delete " . l:curfile
            endif
        endif
    else
        echoerr v:errmsg
    endif
endfunction
