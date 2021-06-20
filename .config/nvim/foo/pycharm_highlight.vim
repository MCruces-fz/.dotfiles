
function IntellyJ_highlikes()
    " Highlight IntellyJ like.
    " This highlight is inspired by PyCharm (IntelliJ Idea).

    hi semshiLocal           ctermfg=209 guifg=#ff875f
    hi semshiGlobal          ctermfg=214 guifg=#ffaf00
    hi semshiImported        ctermfg=214 guifg=#A9B7C6 cterm=bold      gui=NONE
    hi semshiParameter       ctermfg=75  guifg=#A9B7C6
    hi semshiParameterUnused ctermfg=117 guifg=#5D5D5D cterm=underline gui=underline
    hi semshiFree            ctermfg=218 guifg=#ffafd7
    hi semshiBuiltin         ctermfg=207 guifg=#8888C6
    hi semshiAttribute       ctermfg=49  guifg=#A9B7C6
    hi semshiSelf            ctermfg=249 guifg=#94558D
    hi semshiUnresolved      ctermfg=226 guifg=#ffff00 cterm=underline gui=underline
    hi semshiSelected        ctermfg=231 guifg=#ffffff ctermbg=161     guibg=#d7005f
    
    hi semshiErrorSign       ctermfg=231 guifg=#ffffff ctermbg=160     guibg=#d70000
    hi semshiErrorChar       ctermfg=231 guifg=#ffffff ctermbg=160     guibg=#d70000
    sign define semshiError text=E> texthl=semshiErrorSign
endfunction
