# style.xplr

This plugin gives a better way to interact with xplr `Style`

## Requirements

- None

## Installation

### Install manually

- Add the following line in `~/.config/xplr/init.lua`

    ```lua
    local home = os.getenv("HOME")
    package.path = home
      .. "/.config/xplr/plugins/?/src/init.lua;"
      .. home
      .. "/.config/xplr/plugins/?.lua;"
      .. package.path
    ```

- Clone the plugin

    ```bash
    mkdir -p ~/.config/xplr/plugins
    git clone https://github.com/emsquid/style.xplr ~/.config/xplr/plugins/style
    ```

- Require the module in `~/.config/xplr/init.lua`

    ```lua
    local style = require("style").style

    -- And
    
    local get_node_style = require("style").get_node_style

    -- And
    
    local parse_style = require("style").parse_style
    ```

## Usage

- The `style` table provides functions for each colors and modifiers in xplr
    ```lua
    -- Make text red
    style.fg.Red("I am red")

    -- Make text background green
    style.bg.Green("My background is green")

    -- Make text bold
    style.add_modifiers.Bold("Bold'ish")

    -- Remove a modifier
    style.sub_modifiers.Reversed("Are you sure ? this can't be reversed")

    -- But you can also do
    style.fg[{ Rgb = { 32, 64, 128 } }]("Air jee beez")
    style.add_modifiers[{ "Bold", "Underlined" }]("Two birds with one stone")
    
    -- ...
    ```
    > **NOTE**: Sub modifiers should be applied before adding modifiers to be effective (This is how it is, if someone finds a way to fix it).

- the `parse_style` function returns a function which applies the given `Style` 
    ```lua
    -- Style has the same format as the documentation
    local my_style = parse_style({ fg = "Red", bg = "DarkGray", add_modifiers = { "Bold", "CrossedOut" } })

    local my_text_1 = my_style("Lookin' good crossed out)
    ```

- The `get_node_style` function returns a function which is supposed to replicate the given node style based on your configuration
    ```lua
    -- Get the style
    local my_node_style = get_node_style(node) 

    -- Use it as you want
    local my_text_2 = my_node_style("Yay I look like the node")
    local my_text_3 = my_node_style("Me 2")

    -- ...
    ```
