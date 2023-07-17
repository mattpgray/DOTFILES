local dracula = require("dracula")
dracula.setup({
    -- show the '~' characters after the end of buffers
    show_end_of_buffer = true, -- default false
    -- use transparent background
    transparent_bg = false,    -- default false
    -- set italic comment
    italic_comment = true,     -- default false
    colors = {
        bg = "#282A36",
        fg = "#F8F8F2",
        selection = "#44475A",
        comment = "#6272A4",
        red = "#FF5555",
        orange = "#FFB86C",
        yellow = "#F1FA8C",
        green = "#50fa7b",
        purple = "#BD93F9",
        cyan = "#8BE9FD",
        pink = "#FF79C6",
        bright_red = "#FF6E6E",
        bright_green = "#69FF94",
        bright_yellow = "#FFFFA5",
        bright_blue = "#D6ACFF",
        bright_magenta = "#FF92DF",
        bright_cyan = "#A4FFFF",
        bright_white = "#FFFFFF",
        menu = "#21222C",
        visual = "#3E4452",
        gutter_fg = "#4B5263",
        nontext = "#3B4048",
        white = "#ABB2BF",
        black = "#191A21",
    },
    overrides = function(colors)
        return {
            EndOfBuffer = { fg = colors.bright_red }, -- set NonText fg to white of theme
            ExtraWhitespace = { bg = colors.bright_red },
        }
    end
})

vim.cmd('match ExtraWhitespace /\\s\\+$/')

vim.cmd.colorscheme("dracula")
