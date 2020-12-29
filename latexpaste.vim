if has('mac')
"TODO check if the current file is markdown or latex or org mode

  function! latexpaste#paste(save_path)
    " TODO: check whether command pngpaste exists
    let ret = system("pngpaste" . " " . a:save_path)
    if v:shell_error
      echomsg "[Error] " . ret
      return
    endif

    " TODO: overwrite check
    echo printf("Clipboard image saved at %s (%d bytes)", a:save_path, getfsize(a:save_path))

    " write to the current buffer
    "%s = name

    " TODO allow variable width
    " TODO indent caption and includegraphics
    let beg= printf("\\begin{figure}")
    put =beg
    let graph= printf("\\includegraphics[width=\\linewidth]{%s}", a:save_path)
    put =graph
    "TODO allow custom caption
    let cap = printf("\\caption{%s}", a:save_path)
    put=cap

    let ending = printf("\\end{figure}")
    put =ending
  endfunction

  command! -nargs=1 LatexPaste call latexpaste#paste(<q-args>)

endif
