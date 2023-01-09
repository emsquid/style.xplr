# style.xplr

This plugin gives an easy way to replicate [xplr](https://xplr.dev) `Style` concept. 
It generates ansi escape codes itself without depending on xplr API, but the variables are the same so it can be used when writing plugins!

## Requirements

- A terminal with ansi color support

## Installation

### Install manually

- Add the following line in `~/.config/xplr/init.lua`

    ```lua
    local home = os.getenv("HOME")
    package.path = home
      .. "/.config/xplr/plugins/?/init.lua;"
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
    
    local separator = require("style").separator

    -- And
    
    local parse_style = require("style").parse_style
    
    -- And

    local get_node_style = require("style").get_node_style
    ```

## Usage

- The `style` table provides functions for each colors and modifiers in xplr
    ```lua
    -- Make text red
    style.fg.Red("I am red")

    -- Make text's background green
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
    > **NOTE**: The color being used is the first being applied (i.e. if you apply a Red foreground to a text, and apply a Black foreground after, it will be Red), same goes for adding and subbing modifiers 

- The `separator` variable can be used to reset styling
    ```lua
    -- This would make everything red
    local my_red_1 = style.fg.Red("Starting red... ") .. "ending red too..."

    -- To prevent that
    local my_red_2 = style.fg.Red("Starting red... ") .. separator .. "not ending red!"

    -- Note that this wouldn't cause any problem
    local my_mix = style.fg.Red("Starting red... ") .. style.fg.Blue("ending blue!")
    ```
    > **NOTE**: Before, the separator was used in every function but was causing unwanted behavior, it is easier to control manually

- The `parse_style` function returns a function which applies the given `Style` 
    ```lua
    -- Style has the same format as the documentation
    local my_style = parse_style({ fg = "Red", bg = "DarkGray", add_modifiers = { "Bold", "CrossedOut" } })

    local my_text_1 = my_style("Lookin' good crossed out")
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
