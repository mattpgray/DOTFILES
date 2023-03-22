require("mgray.packer")
-- set sets the leader so we need to call it before remap which uses the leader
require("mgray.set")
require("mgray.remap")
require("mgray.go")

local myplug = require("myplug")
myplug.load_plugins("before")

