command! -bang AckProjectDirCursor call ack#Ack('grep<bang>', expand('<cword>').' '.rubix#project_dir())
command! -bang AckProjectDirPrompt call ack#Ack('grep<bang>', shellescape(rubix#input_word()).' '.rubix#project_dir())
