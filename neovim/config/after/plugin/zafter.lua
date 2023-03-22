local home_dir = os.getenv( "HOME" )
package.path = package.path .. ";" .. home_dir .. "/.config/nvim/?.lua"
local myplug = require("lua.myplug.init")

myplug.load_plugins("after")

