if exists("current_compiler")
  finish
endif
let current_compiler = "golangci-lint"

CompilerSet makeprg=golangci-lint
