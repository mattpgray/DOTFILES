local oil = require('oil')

vim.keymap.set("n", "-", oil.open, { desc = "Open parent directory" })

---Copied from vim.ui.open in Neovim 0.10+
---@param path string
---@return nil|string[] cmd
---@return nil|string error
local function get_open_cmd(path)
    if vim.fn.has("mac") == 1 then
        return { "open", path }
    elseif vim.fn.has("win32") == 1 then
        if vim.fn.executable("rundll32") == 1 then
            return { "rundll32", "url.dll,FileProtocolHandler", path }
        else
            return nil, "rundll32 not found"
        end
    elseif vim.fn.executable("explorer.exe") == 1 then
        return { "explorer.exe", path }
    elseif vim.fn.executable("xdg-open") == 1 then
        return { "xdg-open", path }
    else
        return nil, "no handler found"
    end
end

oil.setup({
    columns = {
        "icon",
        "permissions",
        "size",
        "mtime",
    },
    -- The default keymaps with some disabled
    keymaps = {
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["<C-s>"] = { "actions.select", opts = { vertical = true }, desc = "Open the entry in a vertical split" },
        -- conflicts with my remaps for navigating between windows and tmux.
        -- ["<C-h>"] = { "actions.select", opts = { horizontal = true }, desc = "Open the entry in a horizontal split" },
        ["<C-t>"] = { "actions.select", opts = { tab = true }, desc = "Open the entry in new tab" },
        ["<C-p>"] = "actions.preview",
        ["<C-c>"] = "actions.close",
        ["<C-l>"] = "actions.refresh",
        ["-"] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["`"] = "actions.cd",
        ["~"] = { "actions.cd", opts = { scope = "tab" }, desc = ":tcd to the current oil directory", mode = "n" },
        ["gs"] = "actions.change_sort",
        ["gx"] = "actions.open_external",
        ["g."] = "actions.toggle_hidden",
        ["g\\"] = "actions.toggle_trash",
        ["go"] = {
            callback = function()
                local entry = oil.get_cursor_entry()
                local dir = oil.get_current_dir()
                if not entry or not dir then
                    return
                end
                local path = dir .. entry.name
                local cmd, err = get_open_cmd(path)
                if not cmd then
                    vim.notify(string.format("Could not open %s: %s", path, err), vim.log.levels.ERROR)
                    return
                end
                local jid = vim.fn.jobstart(cmd, { detach = true })
                assert(jid > 0, "Failed to start job")
            end,
            desc = "Open the entry under the cursor in an external program",
        }
    },
    use_default_keymaps = false,
    view_options = {
        -- Show files and directories that start with "."
        show_hidden = true,
    }
})

local file_is_set = function()
    return vim.api.nvim_buf_get_name(0) == ""
end

-- Stops a scratch buffer from being created when neovim is opened without a file provided, which
-- has its pros and cons.
if file_is_set() then
    vim.cmd [[silent edit .]]
end
