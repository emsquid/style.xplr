---@diagnostic disable
local xplr = xplr
---@diagnostic enable

local no_color = os.getenv("NO_COLOR")

local function split(str, sep)
    if sep == nil then
        sep = "%s"
    end

    local t = {}

    for m in string.gmatch(str, "([^" .. sep .. "]+)") do
        table.insert(t, m)
    end

    return t
end

-- Default function
local separator = "\x1b[0m"

local function normal(text)
    return text
end

-- Main function to apply ansi escape code to a text
local function ansi_escape(text, code)
    if no_color == nil then
        return "\x1b[" .. code .. "m" .. text
    else
        return text
    end
end

-- FG COLORS

local function fg_reset(x) return ansi_escape(x, 39) end

local function fg_rgb(rgb)
    return function(text) return ansi_escape(text, "38;2;" .. rgb[1] .. ";" .. rgb[2] .. ";" .. rgb[3]) end
end

local function fg_indexed(n)
    return function(text) return ansi_escape(text, "38;5;" .. n) end
end

local function fg_black(text) return fg_indexed(0)(text) end

local function fg_red(text) return fg_indexed(1)(text) end

local function fg_green(text) return fg_indexed(2)(text) end

local function fg_yellow(text) return fg_indexed(3)(text) end

local function fg_blue(text) return fg_indexed(4)(text) end

local function fg_magenta(text) return fg_indexed(5)(text) end

local function fg_cyan(text) return fg_indexed(6)(text) end

local function fg_gray(text) return fg_indexed(7)(text) end

local function fg_dark_gray(text) return fg_indexed(8)(text) end

local function fg_light_red(text) return fg_indexed(9)(text) end

local function fg_light_green(text) return fg_indexed(10)(text) end

local function fg_light_yellow(text) return fg_indexed(11)(text) end

local function fg_light_blue(text) return fg_indexed(12)(text) end

local function fg_light_magenta(text) return fg_indexed(13)(text) end

local function fg_light_cyan(text) return fg_indexed(14)(text) end

local function fg_white(text) return fg_indexed(15)(text) end

-- BG COLORS

local function bg_reset(text) return ansi_escape(49)(text) end

local function bg_rgb(rgb)
    return function(text) return ansi_escape(text, "48;2;" .. rgb[1] .. ";" .. rgb[2] .. ";" .. rgb[3]) end
end

local function bg_indexed(n)
    return function(text) return ansi_escape(text, "48;5;" .. n) end
end

local function bg_black(text) return bg_indexed(0)(text) end

local function bg_red(text) return bg_indexed(1)(text) end

local function bg_green(text) return bg_indexed(2)(text) end

local function bg_yellow(text) return bg_indexed(3)(text) end

local function bg_blue(text) return bg_indexed(4)(text) end

local function bg_magenta(text) return bg_indexed(5)(text) end

local function bg_cyan(text) return bg_indexed(6)(text) end

local function bg_gray(text) return bg_indexed(7)(text) end

local function bg_dark_gray(text) return bg_indexed(8)(text) end

local function bg_light_red(text) return bg_indexed(9)(text) end

local function bg_light_green(text) return bg_indexed(10)(text) end

local function bg_light_yellow(text) return bg_indexed(11)(text) end

local function bg_light_blue(text) return bg_indexed(12)(text) end

local function bg_light_magenta(text) return bg_indexed(13)(text) end

local function bg_light_cyan(text) return bg_indexed(14)(text) end

local function bg_white(text) return bg_indexed(15)(text) end

-- ADD MODIFIERS

local function add_bold(text) return ansi_escape(text, 1) end

local function add_dim(text) return ansi_escape(text, 2) end

local function add_italic(text) return ansi_escape(text, 3) end

local function add_underlined(text) return ansi_escape(text, 4) end

local function add_slowblink(text) return ansi_escape(text, 5) end

local function add_rapidblink(text) return ansi_escape(text, 6) end

local function add_reversed(text) return ansi_escape(text, 7) end

local function add_hidden(text) return ansi_escape(text, 8) end

local function add_crossedout(text) return ansi_escape(text, 9) end

-- SUB MODIFIERS

local function sub_bold(text) return ansi_escape(text, 22) end

local function sub_dim(text) return ansi_escape(text, 22) end

local function sub_italic(text) return ansi_escape(text, 23) end

local function sub_underlined(text) return ansi_escape(text, 24) end

local function sub_blink(text) return ansi_escape(text, 25) end

local function sub_reversed(text) return ansi_escape(text, 27) end

local function sub_hidden(text) return ansi_escape(text, 28) end

local function sub_crossedout(text) return ansi_escape(text, 29) end

-- Handle picking colors
local function handle_color(color_table, color)
    if type(color) == "table" then
        local rgb = color.Rgb
        local index = color.Indexed

        if rgb ~= nil then
            return color_table.Rgb(rgb)
        elseif index ~= nil then
            return color_table.Indexed(index)
        else
            return normal
        end
    elseif type(color) == "string" then
        return color_table[color] or normal
    else
        return normal
    end
end

local color_metatable = { __index = function(table, key) return handle_color(table, key) end }

-- Handle picking modifiers
local function handle_modifiers(modifier_table, modifiers)
    if type(modifiers) == "table" then
        return function(text)
            for _, modif in ipairs(modifiers) do
                local func = modifier_table[modif]
                if func ~= nil then
                    text = func(text)
                end
            end
            return text
        end
    else
        return normal
    end
end

local modifier_metatable = { __index = function(table, key) return handle_modifiers(table, key) end }

-- Map style to functions
local style = {
    fg = setmetatable(
        {
            Reset = fg_reset,
            Black = fg_black,
            Red = fg_red,
            Green = fg_green,
            Yellow = fg_yellow,
            Blue = fg_blue,
            Magenta = fg_magenta,
            Cyan = fg_cyan,
            Gray = fg_gray,
            DarkGray = fg_dark_gray,
            LightRed = fg_light_red,
            LightGreen = fg_light_green,
            LightYellow = fg_light_yellow,
            LightBlue = fg_light_blue,
            LightMagenta = fg_light_magenta,
            LightCyan = fg_light_cyan,
            White = fg_white,
            Rgb = fg_rgb,
            Indexed = fg_indexed,
        },
        color_metatable
    ),
    bg = setmetatable(
        {
            Reset = bg_reset,
            Black = bg_black,
            Red = bg_red,
            Green = bg_green,
            Yellow = bg_yellow,
            Blue = bg_blue,
            Magenta = bg_magenta,
            Cyan = bg_cyan,
            Gray = bg_gray,
            DarkGray = bg_dark_gray,
            LightRed = bg_light_red,
            LightGreen = bg_light_green,
            LightYellow = bg_light_yellow,
            LightBlue = bg_light_blue,
            LightMagenta = bg_light_magenta,
            LightCyan = bg_light_cyan,
            White = bg_white,
            Rgb = bg_rgb,
            Indexed = bg_indexed,
        },
        color_metatable
    ),
    add_modifiers = setmetatable(
        {
            Bold = add_bold,
            Dim = add_dim,
            Italic = add_italic,
            Underlined = add_underlined,
            SlowBlink = add_slowblink,
            RapidBlink = add_rapidblink,
            Reversed = add_reversed,
            Hidden = add_hidden,
            Crossedout = add_crossedout
        },
        modifier_metatable
    ),
    sub_modifiers = setmetatable(
        {
            Bold = sub_bold,
            Dim = sub_dim,
            Italic = sub_italic,
            Underlined = sub_underlined,
            SlowBlink = sub_blink,
            RapidBlink = sub_blink,
            Reversed = sub_reversed,
            Hidden = sub_hidden,
            Crossedout = sub_crossedout
        },
        modifier_metatable
    )
}

local function parse_style(style_table)
    local fg_color = style.fg[style_table.fg]
    local bg_color = style.bg[style_table.bg]
    local add_modifiers = style.add_modifiers[style_table.add_modifiers]
    local sub_modifiers = style.sub_modifiers[style_table.sub_modifiers]

    return function(text)
        return fg_color(bg_color(add_modifiers(sub_modifiers(text))))
    end
end

-- Return a function which applies the node style
local function get_node_style(node)
    local types = xplr.config.node_types
    local node_style = {}

    -- TYPE
    if node.is_symlink then
        node_style = types.symlink.style
    elseif node.is_dir then
        node_style = types.directory.style
    else
        node_style = types.file.style
    end

    -- MIME
    local mime = split(node.mime_essence, "/")
    local mime_essence = types.mime_essence[mime[1]]

    if mime_essence ~= nil then
        if mime_essence[mime[2]] ~= nil then
            node_style = mime_essence[mime[2]].style or node_style
        elseif mime_essence["*"] ~= nil then
            node_style = mime_essence["*"].style or node_style
        end
    end

    -- EXTENSION
    local extension = types.extension[node.extension]

    if extension ~= nil then
        node_style = extension.style or node_style
    end

    -- SPECIAL
    local special = types.special[node.relative_path]

    if special ~= nil then
        node_style = special.style or node_style
    end

    return parse_style(node_style)
end

return { style = style, separator = separator, parse_style = parse_style, get_node_style = get_node_style }
