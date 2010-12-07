fun! FindSource()
  let word = expand("<cword>")

  if has("mac") || has("macunix")
    let cmd = 'egrep -Rlw "(class|(public|private|abstract|protected) function) ' . word . '" * | grep -v "cache" | grep -v "log" | grep -v ".svn"'
  elseif has("unix")
    " temp: mac/macunix not catching correctly.
    let cmd = 'egrep -Rlw "(class|(public|private|abstract|protected) function) ' . word . '" * | grep -v "cache" | grep -v "log" | grep -v ".svn"'

    "let cmd = 'egrep -Rlw --exclude-dirs=".svn cache" --exclude-dir="cache" "(class|function) ' . word . '" *'
  elseif has("win32") || has("win64")
    echomsg "Please upgrade to a real OS."
  endif

  let cmd_output = system(cmd)

  if cmd_output == ''
    echomsg "Declaration for " . word . " not found!"
  else
    "  @todo if cmd_output not already open in buffer...

      " open file in new tab
      execute "tabnew " . cmd_output
          
      " better search for [word] via function [word] OR class [word]
      execute "/class " . word . "\\|function " . word
  endif
endfun
