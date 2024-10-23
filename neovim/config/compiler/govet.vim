if exists("current_compiler")
  finish
endif
let current_compiler = "govet"

CompilerSet makeprg=go\ vet
CompilerSet errorformat=vet:\ %f:%l:%c:\ %m,\ %f:%l:%c:\ %m
