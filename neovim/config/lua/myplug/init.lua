local myplug = {}

function file_exists(path)
    local f = io.open(path, "r")
    if f ~= nil then io.close(f) return true else return false end
end

function count(base, pattern)
    return select(2, string.gsub(base, pattern, ""))
end

function myplug.load_plugins(dir)
    local current_dir = os.getenv("PWD")
    local depth = count(current_dir, "/")
    for i=1, depth+1 do
        local file = current_dir .. "/.nvim/" .. dir .. "/init.lua"
        if file_exists(file) then
            dofile(file)
            break
        end
        current_dir = current_dir .. "/.."
    end
end

return myplug
