if exists("current_compiler")
  finish
endif
let current_compiler = "gotest"

CompilerSet makeprg=go\ test
CompilerSet errorformat=%f:%l:%c:\ %m
