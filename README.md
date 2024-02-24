# GriddyCode
Coding has never been more lit!

--

# Lua modding
GriddyCode allows you to extend its functionality via **Lua**.

## Where?
To open the folder with Lua scripts, go to:
- Windows: %APPDATA%\Bussin GriddyCode
- macOS: ~/Library/Application Support/Bussin GriddyCode
- Linux: ~/.local/share/Bussin GriddyCode
*Note: since the paths might change, we recommend you manually search for GriddyCode in the AppData of your OS.*

## How?
You may see the folders **"langs"** and **"themes"**.
- **"langs"** holds a bunch of `.lua` files that power GriddyCode's syntax highlighting & autocomplete.
- **"themes"** holds a bunch of `.lua` files that change GriddyCode's appearance.

*Note: the Lua scripts are reloaded only if you switch from a different file extension (i.e. "README.md" -> "main.ts"), or if GriddyCode is restarted.*

## Docs?
### Langs
#### Introduction
To extend the functionality of GriddyCode for a specific **file extension**, create a file with the name of it. (i.e. `toml.lua`)

#### Methods
#### Methods

| Method | Example | Description | Notes |
| -------- | -------- | -------- | -------- |
| `highlight(keyword: String, color: String)` | `highlight("const", "reserved")` | Tells GriddyCode to highlight a certain keyword with a preset of colors. | Available colors: `reserved`, `string`, `binary`, `symbol`, `variable`, `operator`, `comments`, `error`, `function`, `member` |
| `highlight_region(start: String, end: String, color: String, line_only: bool = false)` | `highlight("/*", "*/", "comments", false)` | Tells GriddyCode to highlight a region with a preset of colors. | The `start` must be a symbol. Due to Godot's limited functionality, you can't use RegEx. |
| `detect_functions(content: String) -> Array[String]` | `detect_functions("const test = 3; function main() {}; async init() => { main() }")` | Called by GriddyCode upon input. Results are showed in the autocomplete feature. | This must be provided by the Lua script. It must return an array of strings (i.e. ["main", "init"]). |
| `detect_variables(content: String) -> Array[String]` | `detect_variables("const test = 3;")` | Called by GriddyCode upon input. Results are showed in the autocomplete feature. | This must be provided by the Lua script. It must return an array of strings (i.e. ["test"]). |

### Themes
#### Introduction
To add a theme, create a file in the **"themes"** folder with any name. (i.e. "dracula.lua"). You will be able to choose it within GriddyCode.

#### Methods
| Method | Example | Description | Notes |
| -------- | -------- | -------- | -------- |
| `set_keywords(property: String, new_color: String)` | `set_keywords("reserved", "#ff00ff")` | Set the color of syntax highlighting. | The second argument must be a hex, `#` being optional. Available colors/properties listed above at `langs`. |
| `set_gui(property: String, new_color: String)` | `set_gui("background_color", "#ff00ff")` | This method is dedicated to the overall GUI aspect of GriddyCode. | Available properties: `background_color`, `current_line_color`, `selection_color`, `font_color`, `word_highlighted_color`, `selection_background_color`. Properties except `background_color`, if not provided, will be set to a slightly modified version of `background_color`. Although possible, we don't recommend you rely on those & set all the values. |
